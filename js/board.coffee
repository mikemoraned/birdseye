window.birdseye ?= {}

class Board

  constructor: (@id, name, url, memberships, memberFilter, adminsOnly) ->
    @name = ko.observable(name)
    @url = ko.observable(url)
    @memberships = ko.computed(() =>
      @_filterByAdmin(adminsOnly, @_filterByName(memberFilter, memberships)))

  _filterByName: (memberFilter, memberships) =>
      if memberFilter()?
        memberships.filter((m) => m.member().matches(memberFilter()))
      else
        memberships

  _filterByAdmin: (adminsOnly, memberships) =>
    if adminsOnly()
      memberships.filter((m) => m.type() == 'admin')
    else
      memberships

window.birdseye.Board = Board