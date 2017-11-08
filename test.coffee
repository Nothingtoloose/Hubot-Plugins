# Description:
#   Dieses Plugin dient zum Testen der einzelnen Sicherheitsfeatures
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot Test Vier-Augen-Prinzip              - Zeigt ein Beispiel des Vier-Augen-Prinzips
#   hubot Test Arbeitszeiten                   - Zeigt ein Beispiel des Einflusses von Arbeitszeiten
#   hubot Test Zwei-Faktor-Authentifizierung   - Zeigt ein Beispiel der Zwei-Faktor-Authentifizierung
#   hubot Test Benutzer-Rolle Rolle1	       - Zeigt ein Beispiel eines Befehls, der die Rolle "Rolle1" benötigt
#   hubot Test Benutzer-Rolle Administratoren  - Zeigt ein Beispiel eines Befehls, der die Rolle "test" benötigt
#
# Author:
#   Christian Köhler

arbeitszeit = ->
  zeit = new Date()
  stunde = (zeit.getHours() + 1) % 24
  tag = zeit.getDay()
  stunde in [7..15] && tag in [1..5]

module.exports = (robot) ->
  robot.respond /Test Vier-Augen-Prinzip/i, { id: 'approval.test', approval: { group: 'test', peer: true  } }, (msg) ->
    msg.send 'Vielen Dank :smiley:  Bestätigung erfolgreich. Führe Aktion aus :rocket:'

  robot.respond /Test Benutzer-Rolle Rolle1/i, { id: 'neu.test', approval: { group: 'Rolle1' } }, (msg) ->
    msg.send 'Vielen Dank :smiley:  Bestätigung erfolgreich. Führe Aktion aus :rocket:'

  robot.respond /Test Benutzer-Rolle Administratoren/i, { id: 'test.test', approval: { group: 'Administratoren' } }, (msg) ->
    msg.send 'Vielen Dank :smiley:  Bestätigung erfolgreich. Führe Aktion aus :rocket:'
  
  robot.respond /Test Arbeitszeiten/i, (msg) ->
    console.log(msg)
    unless arbeitszeit()
      msg.reply 'Sie sind außerhalb der Arbeitszeit von 7:00 - 15:00 Uhr.'
    else
      msg.send 'Vielen Dank :smiley: Führe Aktion aus :rocket:'



  robot.respond /Test Zwei-Faktor-Authentifizierung/i, (msg) ->
    msg.reply 'Bitte bestätigen Sie die Aktion mittels Klick in Ihrer Duo App auf Ihrem Handy.'
    robot.duo.auth msg.message.user.name, (err, res) ->
      if err
        return msg.send "Error during DUO authentication: #{err}"
      if res.result == 'allow'
        return msg.send 'Vielen Dank :smiley:  Bestätigung erfolgreich. Führe Aktion aus :rocket:'
      return msg.send 'Freigabe wurde nicht erteilt'

