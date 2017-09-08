# Description:
#   Pugme is the most important thing in life
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot pug me - Receive a pug
#   hubot pug bomb N - get N pugs

createGroupMapping = (user, groups, groupMapping) ->
  newItem =[]
  #console.log ("Append user '" + user + "' to group: " + grp) for grp in groups
  for grp in groups
    newItem.push grp,user
    groupMapping.push newItem
    newItem =[]
  #console.log("Group->Users: " + JSON.stringify(groupMapping))

sucheMitgliederausGruppe = (gesuchteGruppe, groupMapping) ->
  gefundeneBenutzer =[]
  for grp in groupMapping
    if grp[0] == gesuchteGruppe
      gefundeneBenutzer.push grp[1]
  #console.log("gefundene Gruppen-Mitglieder: " + JSON.stringify(gefundeneBenutzer))
  return gefundeneBenutzer


sucheGruppenDesBenutzers = (gesuchterBenutzer, groupMapping) ->
  gefundeneGruppen =[]
  for grp in groupMapping
    if grp[1] == gesuchterBenutzer
      gefundeneGruppen.push grp[0]
  #console.log("gefundene Gruppenmitgliedschaften: " + JSON.stringify(gefundeneGruppen))
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
    msg.reply "Your name is: #{user['name']}."
    a = robot.brain.get('userGroups') 
    createGroupMapping usr, a[usr].groups, groupMapping for usr of a
    ergebnis = sucheGruppenDesBenutzers user['name'], groupMapping
    if ergebnis.length == 0
      msg.reply("Du bist in keiner Gruppe")
    else
      msg.reply ("Du bist Mitglied in folgenden Gruppen:  #{ergebnis} " )
    groupMapping = []
    gefundeneGruppen = []




