EditFollowing = require './'
packageInfo = require '../package'
ArgumentParser = require('argparse').ArgumentParser
JSONStream = require 'JSONStream'

argparser = new ArgumentParser(
  version: packageInfo.version
  addHelp: true
  description: packageInfo.description
)
argparser.addArgument(
  ['--username', '-u']
  type: 'string'
  help: 'The username of the account to login as.'
  required: true
)
argparser.addArgument(
  ['--password', '-p']
  type: 'string'
  help: 'The password of the account to login as.'
  required: true
)

argv = argparser.parseArgs()

editFollowing = new EditFollowing(argv.username, argv.password)
process.stdin.pipe(JSONStream.parse('*')).pipe(editFollowing)
