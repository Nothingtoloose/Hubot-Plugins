# Description:
#   Schicke Nachrichten an ausgewaehlte Raeume
#
# Dependencies:
#   None
#
# Configuration:
#   HUBOT_ANNOUNCE_ROOMS - Liste der Raeume, durch Komma getrennt
#
# Commands:
#   hubot Nachricht "<Nachricht>" "<Raum>[,<Raum>]" - Sendet die Nachricht an den / die angegebenen Räume
#   hubot Nachricht an alle "<Nachricht>"    - Sendet die Nachricht an die vorgegebenen Raeume
#
# Author:
#   Morgan Delagrange
#   Christian Koehler

module.exports = (robot) ->

  robot.respond /Nachricht "(.*)" "(.*)"/i, (msg) ->
    announcement = msg.match[1]
    allRooms = msg.match[2].split(',')
 
    for room in allRooms
        robot.messageRoom room, announcement

  robot.respond /Nachricht an alle "(.*)"/i, (msg) ->
    announcement = msg.match[1]
    allRooms = process.env.HUBOT_ANNOUNCE_ROOMS.split(',')
 
    for room in allRooms
        robot.messageRoom room, announcement



 

