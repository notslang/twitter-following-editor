request = require 'request-promise'
jsdom = require 'jsdom'
nodefn = require 'when/node'
W = require 'when'

class TwitterSession
  _isLoggedIn: false
  authenticityToken: ''

  constructor: (@username, @password) ->
    @cookieJar = request.jar()

  _getAuthenticityToken: =>
    request.get(
      uri: 'https://twitter.com/'
      jar: @cookieJar
    ).then((response) ->
      nodefn.call(jsdom.env, response)
    ).then((window) =>
      @authenticityToken = JSON.parse(
        window.document.getElementById('init-data').value
      ).formAuthenticityToken
    )

  ###*
   * Sets `@authenticityToken` (via `@_getAuthenticityToken`) and puts
     `@cookieJar` in the right state to make requests.
  ###
  doLogin: =>
    @_getAuthenticityToken().then( =>
      request.post(
        uri: 'https://twitter.com/sessions'
        headers:
          'User-Agent': 'request'
          'Origin': 'https://twitter.com'
        form:
          'session[username_or_email]': @username
          'session[password]': @password
          'authenticity_token': @authenticityToken
          'scribe_log': ''
          'redirect_after_login': '/'
          'remember_me': 1
        jar: @cookieJar
        simple: false
      )
    ).then((res) =>
      if /https:\/\/twitter\.com\/login\/error\?username_or_email/.test(res)
        throw new Error(
          "USERNAME (#{@username}) or PASSWORD (#{@password}) is incorrect"
        )
      else
        console.info('login done')
        @_isLoggedIn = true
      return
    )

  sendAction: ({userId, username, action}) =>
    if action in ['follow', 'unfollow']
      url = "https://twitter.com/i/user/#{action}"
    else
      throw new Error("Unknown Action: #{action}")

    formData = {
      'challenges_passed': false
      'handles_challenges': 1
      'impression_id': ''
      'inject_tweet': false
    }

    if userId?
      formData['user_id'] = userId
    else if username
      formData['screen_name'] = username
    else
      throw new Error('either userId or username args need to be supplied')

    promise = (
      if @_isLoggedIn
        # noop
        W.resolve()
      else
        # make sure we're logged in before doing our first request
        @doLogin()
    )

    promise.then( =>
      # now that login is done, we know that we have the authenticity token
      formData['authenticity_token'] = @authenticityToken

      request.post(
        uri: url
        headers:
          'User-Agent': 'request'
          'Origin': 'https://twitter.com'
        form: formData
        jar: @cookieJar
      )
    ).then( ->
      console.info("#{action}ed #{username}")
    )

module.exports = {TwitterSession}
