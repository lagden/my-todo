Template.appBody.helpers
  tasks: ->
    if Session.get 'hideCompleted'
      return Tasks.find {checked: $ne: true}, {sort: createdAt: -1}
    else
      return Tasks.find {}, {sort: createdAt: -1}
  hideCompleted = ->
    Session.get 'hideCompleted'

Template.appBody.events
  'submit .new-task': (event) ->
    target = event.currentTarget
    txt = target.txt.value

    Meteor.call 'addTask', txt

    target.txt.value = ''
    event.preventDefault()
    return

  'click .hide-completed > input': (event) ->
    Session.set 'hideCompleted', event.currentTarget.checked
    return

Template.task.helpers
  isOwner: ->
    @owner == Meteor.userId()

Template.task.events
  'click .delete': ->
    Meteor.call 'deleteTask', @._id
    return

  'click .toggle': ->
    Meteor.call 'setChecked', @._id, !@.checked
    return

  'click .toggle-private': ->
    Meteor.call 'setPrivate', @._id, !@.private
    return

Meteor.subscribe 'tasks'
Accounts.ui.config passwordSignupFields: 'USERNAME_ONLY'

return
