window.birdseye ?= {}

class Organisation
  name: ko.observable()

  constructor: (@id, name) ->
    @name(name)

  loadAll: () =>
    @_loadUsers()
    @_loadBoards()

  _loadUsers: () =>

  _loadBoards: () =>


window.birdseye.Organisation = Organisation