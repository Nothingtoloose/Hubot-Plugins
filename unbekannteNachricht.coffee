# Description:
#   Dieses Plugin dient zum Benachrichtigen des Benutzers, wenn ein Befehl nicht erkannt wurde.
#   Als Erkennungswort wird der Name Hubot verwendet. 
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   None
#
# Author:
#   Christian Köhler

module.exports = (robot) ->

  robot.catchAll (msg) ->
    match = /^\@Hubot+/i.test(msg.message.text) or /^\Hubot+/i.test(msg.message.text)
    if match 
      msg.send "Der Befehl '#{msg.message.text}' wurde nicht erkannt. \nBitte geben Sie '@hubot Hilfe' ein, um sich alle Befehle angezeigen zu lassen."

