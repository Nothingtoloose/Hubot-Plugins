# Description
#   Middleware that adds a group function to user object
#   This also prepopulates a structure (userGroups) that assigns every user
#   to a set of groups. hubot-approval works based on peer or specifid group
#   approval so we need to set this data up.
#
#   The version property is used to ensure that we aren't settting the
#   structure on every request, and also gives us a way to reload that data
#   without restarting the bot
#
# Author:
#  Nadeem Shabir <ns@talis.com>

module.exports = (robot) ->
  # Lookup for all approvers
  userGroups = {
    'admin' : {groups:["test", "approvers"]}
    'admin1' : {groups:["test", "approvers"]}
    'admin2' : {groups:["test", "approvers"]}
    'hubot' : {groups:["test", "approvers"]}

  }
  version = 1

  robot.listenerMiddleware (context, next, done) ->
    environment = context.response.match[1]

    # allows us to repopulate the brain with changes to the above
    # list using the reload command without restarting the bot
    if robot.brain.get('userGroupsVersion') != version
      console.log("gruppen werden neu gesetzt")
      console.log(userGroups)
      console.log(version)
      robot.brain.set 'userGroups', userGroups
      robot.brain.set 'userGroupsVersion', version


    # The purpose of this middleware is to add a function call
    # groups to the user object. This function returns the list
    # of groups that a user belongs to, which the hubot-approval
    # middleware then uses.
    context.response.message.user.groups = (cb) ->
      groups = robot.brain.get('userGroups')
      console.log("--------Ausgabe Usergrup Version-------  " + robot.brain.get('userGroupsVersion'))
      #console.log(groups)
      #console.log('Message ID des Benutzers')
      #console.log(context.response.message.user.name)
      if groups.hasOwnProperty(context.response.message.user.name)
        robot.logger.debug('approval',context.response.message.user.id + " found in list of approvers")
        cb(groups[context.response.message.user.name]['groups'])
      else
        robot.logger.debug('approval',context.response.message.user.id + " was NOT found in list of approvers")
        cb([])
    next()

