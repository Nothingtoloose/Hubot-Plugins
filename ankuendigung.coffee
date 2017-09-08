# Description:
#   Schickt Nachrichten
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_ANNOUNCE_ROOMS - comma-separated list of rooms
#
# Commands:
#   hubot ankuendigung "<Nachricht>" "<Raum>[,<Raum>]" - Sendet die Nachricht an den / die angegebenen Räume
#
# Author:
#   Morgan Delagrange



AUDIT_CHANNEL = process.env.AUDIT_CHANNEL

module.exports = (robot) ->

  robot.respond /ankuendigung "(.*)" "(.*)"/i, (msg) ->
    announcement = msg.match[1]
    allRooms = msg.match[2].split(',')
 
    for room in allRooms
        robot.messageRoom room, announcement




 

