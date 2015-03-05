Tasks = new Mongo.Collection 'tasks'

if Meteor.isClient

  Template.body.helpers
    tasks: ->
      if Session.get 'hideCompleted'
        return Tasks.find checked: $ne: true, sort: createdAt: -1
      else
        return Tasks.find {}, sort: createdAt: -1
    hideCompleted = ->
      Session.get 'hideCompleted'

  Template.body.events
    'submit .new-task': (event) ->
      target = event.currentTarget
      txt = target.txt.value

      Tasks.insert
        text: txt
        createdAt: new Date()

      target.txt.value = ''
      event.preventDefault()
      return

    'click .hide-completed > input': (event) ->
      Session.set 'hideCompleted', event.currentTarget.checked
      return

  Template.task.events
    'click .toggle': (event) ->
      Tasks.update @._id, $set: checked: !@.checked
      return

    'click .delete': (event) ->
      Tasks.remove @._id
      return