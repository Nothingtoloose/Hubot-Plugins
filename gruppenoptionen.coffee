# Description:
#   Dieses Plugin zeigt alle Gruppen an, in denen sich ein Benutzer befindet. 
#   Zudem lassen sich alle Mitglieder eine gegebenen Gruppe anzeigen.
#
# Dependencies:
#   Gruppen Plugin
#
# Configuration:
#   None
#
# Commands:
#   hubot wer ist in Gruppe <Gruppenname>     - Zeigt alle Mitglieder der Gruppe <Gruppenname> an
#   hubot meine Gruppen                       - Zeigt alle Gruppen des Benutzers an
#
# Author
# Christian Koehler


createGroupMapping = (user, groups, groupMapping) ->
  newItem =[]
  for grp in groups
    newItem.push grp,user
    groupMapping.push newItem
    newItem =[]

sucheMitgliederausGruppe = (gesuchteGruppe, groupMapping) ->
  gefundeneBenutzer =[]
  for grp in groupMapping
    if grp[0] == gesuchteGruppe
      gefundeneBenutzer.push grp[1]
  return gefundeneBenutzer


sucheGruppenDesBenutzers = (gesuchterBenutzer, groupMapping) ->
  gefundeneGruppen =[]
  for grp in groupMapping
    if grp[1] == gesuchterBenutzer
      gefundeneGruppen.push grp[0]
  return gefundeneGruppen


groupMapping = []

module.exports = (robot) ->

 
  robot.respond /wer ist in Gruppe \s?(.+)?/i, (msg) ->
    gesucht = msg.match[1]
    a = robot.brain.get('userGroups')
    createGroupMapping usr, a[usr].groups, groupMapping for usr of a
    ergebnis = sucheMitgliederausGruppe gesucht, groupMapping
    if ergebnis.length == 0
      msg.reply ("Die Gruppe '#{gesucht}' existiert nicht")
    else
      msg.reply ("Folgende Mitglieder sind in der Gruppe '#{gesucht}': #{ergebnis} ") 
    groupMapping = []
    gefundeneBenutzer =[]

  robot.respond /meine Gruppen/i, (msg) ->
    user = robot.brain.userForId(msg.envelope.user['id'])
    a = robot.brain.get('userGroups') 
    createGroupMapping usr, a[usr].groups, groupMapping for usr of a
    ergebnis = sucheGruppenDesBenutzers user['name'], groupMapping
    if ergebnis.length == 0
      msg.reply("Du bist in keiner Gruppe")
    else
      msg.reply ("Du bist Mitglied in folgenden Gruppen:  #{ergebnis} " )
    groupMapping = []
    gefundeneGruppen = []




