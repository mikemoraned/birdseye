window.birdseye ?= {}

class Board

  constructor: (@id, name, memberships, memberFilter) ->
    @name = ko.observable(name)
    @memberships = ko.computed(() =>
      @_filterBy(memberFilter, memberships))

  _filterBy: (memberFilter, memberships) =>
      if memberFilter()?
        memberships.filter((m) => m.member().matches(memberFilter()))
      else
        memberships

window.birdseye.Board = Board