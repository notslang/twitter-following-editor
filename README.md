# Twitter Following Editor
[![Build Status](http://img.shields.io/travis/slang800/twitter-following-editor.svg?style=flat-square)](https://travis-ci.org/slang800/twitter-following-editor) [![NPM version](http://img.shields.io/npm/v/twitter-following-editor.svg?style=flat-square)](https://www.npmjs.org/package/twitter-following-editor) [![NPM license](http://img.shields.io/npm/l/twitter-following-editor.svg?style=flat-square)](https://www.npmjs.org/package/twitter-following-editor)

A tool for unfollowing / following people on Twitter, programmatically, without API access. This is useful if you need to edit large lists of people who you're following, on several accounts that you own, and you don't want to attach an app to each and every one of them.

Rather than using an API key, this tool signs into accounts using a username and password, and sends the same follow/unfollow requests that are generated when you press a follow/unfollow button on the Twitter website.

## Example
### CLI
The CLI operates entirely over STDIN / STDOUT, and works by piping in an array of "action" objects. Each action object specifies a username or user id, and an action. For example, the following action object would make the account you're logged in with follow [slang800](https://twitter.com/slang800). Feel free to test this action object out on whatever accounts you want:

```json
{
  "username": "slang800",
  "action": "follow"
}
```

We can pipe this into the command like this:

```bash
$ echo '[{"username":"slang800","action":"follow"}]' | twitter-following-editor -u exampleusername -p examplepassword
login done
following slang800
```

Of course, the real use-case for this tool is to process thousands of follow/unfollow commands at a time. So it's more likely that we would put actions into a file and pipe them in that way:

```bash
$ cat ./example.json
[{"username": "slang800", "action": "follow"},
{"userId": 12513472, "action": "unfollow"},
{"username": "neilhimself", "action": "follow"},
{"username": "buzzfeed", "action": "unfollow"},
{"userId": 516047986, "action": "follow"}]
$ twitter-following-editor -u exampleusername -p examplepassword < example.json
login done
following slang800
not-following cracked
following neilhimself
not-following BuzzFeed
following pentametron
```

## Caveats
- This is probably against the Twitter TOS, so don't use it if that sort of thing worries you.
- Whenever Twitter updates certain parts of their front-end this tool will need to be updated to support the changes.
