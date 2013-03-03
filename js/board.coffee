window.birdseye ?= {}

class Board

  constructor: (@id, name, memberships) ->
    @name = ko.observable(name)
    @memberships = ko.observableArray(memberships)

window.birdseye.Board = Board