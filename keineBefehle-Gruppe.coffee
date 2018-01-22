# Description
#   Middleware to prevent hubot listeners from responding to direct messages.
#
# Configuration:
#   IGNORE_RESPONSE what the bot says when it ignores someone
#
#
# Notes:
#   Set empty response if you want cold silence ignores: `export IGNORE_RESPONSE=""`
#   Compares the room ID of each message with the direct room ID of the user
#
# Author:
#   Tim Kinnane @ 4thParty
#   Christian Köhler

{IGNORE_RESPONSE} = process.env

ignoreResponse = IGNORE_RESPONSE or "Entschuldigung. Befehle sind nur in Kanälen möglich."

module.exports = (robot) ->

  silentIgnore = ignoreResponse is ""
  robot.logger.info "Ignore DMs behaviour is running, will respond with:"
  robot.logger.info "\"#{ unless silentIgnore then ignoreResponse else 'silence' }\""

  # check context before allowing any interaction to proceed
  robot.receiveMiddleware (context, next, done) ->
    if (context.response.message.user.channel_type == 'G')
      unless silentIgnore
        context.response.reply ignoreResponse
        done() # Don't process further middleware.
    else
      next(done) # On to the next one
