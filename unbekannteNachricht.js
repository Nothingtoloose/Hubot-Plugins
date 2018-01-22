module.exports = function(robot) {
  robot.catchAll(function(msg) {
    var match;
    match = /^\@Hubot+/i.test(msg.message.text) || /^\Hubot+/i.test(msg.message.text);
    if (match) {
      return msg.send(`Der Befehl '${msg.message.text}' wurde nicht erkannt. \nBitte geben Sie '@hubot Hilfe' ein, um sich alle Befehle angezeigen zu lassen.`);
    }
  });
};
