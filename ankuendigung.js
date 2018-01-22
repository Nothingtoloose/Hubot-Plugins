// Description:
//   Schicke Nachrichten an ausgewaehlte Raeume
// Dependencies:
//   None
// Configuration:
//   HUBOT_ANNOUNCE_ROOMS - Liste der Raeume, durch Komma getrennt
// Commands:
//   hubot Nachricht "<Nachricht>" "<Raum>[,<Raum>]" - Sendet die Nachricht an den / die angegebenen Räume
//   hubot Nachricht an alle "<Nachricht>"    - Sendet die Nachricht an die vorgegebenen Räume
// Author:
//   Morgan Delagrange
//   Christian Koehler

module.exports = function(robot) {
  robot.respond(/Nachricht "(.*)" "(.*)"/i, function(msg) {
    var allRooms, announcement, i, len, results, room;
    announcement = msg.match[1];
    allRooms = msg.match[2].split(',');
    results = [];
    for (i = 0, len = allRooms.length; i < len; i++) {
      room = allRooms[i];
      results.push(robot.messageRoom(room, announcement));
    }
    return results;
  });
  
  robot.respond(/Nachricht an alle "(.*)"/i, function(msg) {
    var allRooms, announcement, i, len, results, room;
    announcement = msg.match[1];
    allRooms = process.env.HUBOT_ANNOUNCE_ROOMS.split(',');
    results = [];
    for (i = 0, len = allRooms.length; i < len; i++) {
      room = allRooms[i];
      results.push(robot.messageRoom(room, announcement));
    }
    return results;
  });
};
