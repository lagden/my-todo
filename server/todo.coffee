# Only publish tasks that are public or belong to the current user
Meteor.publish 'tasks', ->
  Tasks.find
    $or: [
      {private: {$ne: true}}
      {owner: @.userId}
    ]

return
