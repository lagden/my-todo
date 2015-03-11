@Tasks = new Mongo.Collection 'tasks'

Meteor.methods
  addTask: (text) ->
    if !Meteor.userId()
      throw new Meteor.Error 'not-authorized'

    Tasks.insert
      text: text
      createdAt: new Date()
      owner: Meteor.userId()
      username: Meteor.user().username
    return

  deleteTask: (taskId) ->
    task = Tasks.findOne taskId

    if task.private and task.owner isnt Meteor.userId()
      throw new Meteor.Error 'not-authorized'

    Tasks.remove taskId
    return

  setChecked: (taskId, setChecked) ->
    task = Tasks.findOne taskId

    if task.private and task.owner isnt Meteor.userId()
      throw new Meteor.Error 'not-authorized'

    Tasks.update taskId, {$set: checked: setChecked}
    return

  setPrivate: (taskId, setToPrivate) ->
    task = Tasks.findOne taskId

    if task.owner isnt Meteor.userId()
      throw new Meteor.Error 'not-authorized'

    Tasks.update taskId, {$set: private: setToPrivate}
    return
