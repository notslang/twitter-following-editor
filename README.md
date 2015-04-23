# Twitter Following Editor
[![Build Status](http://img.shields.io/travis/slang800/twitter-following-editor.svg?style=flat-square)](https://travis-ci.org/slang800/twitter-following-editor) [![NPM version](http://img.shields.io/npm/v/twitter-following-editor.svg?style=flat-square)](https://www.npmjs.org/package/twitter-following-editor) [![NPM license](http://img.shields.io/npm/l/twitter-following-editor.svg?style=flat-square)](https://www.npmjs.org/package/twitter-following-editor)

A tool for unfollowing / following people on Twitter, programmatically, without API access. This is useful if you need to edit large lists of people who you're following, on several accounts that you own, and you don't want to attach an app to each and every one of them.

Rather than using an API key, this tool signs into accounts using a username and password, and sends the same follow/unfollow requests that are generated when you press a follow/unfollow button on the Twitter website.

## Example
### CLI
The CLI operates entirely over STDIN / STDOUT

## Caveats
- This is probably against the Twitter TOS, so don't use it if that sort of thing worries you.
- Whenever Twitter updates certain parts of their front-end this tool will need to be updated to support the changes.
