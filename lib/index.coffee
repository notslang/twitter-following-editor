map = require 'map-stream'
guard = require 'when/guard'

{TwitterSession} = require './util'

###*
 * Return a stream for piping Twitter requests.
 * @param {String} username The username of the account you want to login as.
 * @param {String} password The password for the account specified by `username`
 * @return {Stream} A stream, into which you can pipe action objects. Each
   action object has an `action` property (specifying 'follow', 'unfollow',
   'block', or 'unblock') and either a `username` property or a `userId`
   property (to define which user this action is being applied to).
###
module.exports = (username, password) ->
  session = new TwitterSession(username, password)
  return map(guard(guard.n(1), (action, cb) ->
    session.sendAction(action).catch((err) ->
      cb(err)
    ).then( ->
      cb()
    )
  ))
