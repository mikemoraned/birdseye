window.birdseye ?= {}

class Board

  constructor: (@id, name, url, memberships, memberFilter, adminsOnly, nonOrgOnly) ->
    @name = ko.observable(name)
    @url = ko.observable(url)
    @totalMembers = ko.observable(memberships.length)
    @memberships = ko.computed(() =>
      @_filterByNonOrgOnly(nonOrgOnly, @_filterByAdmin(adminsOnly, @_filterByName(memberFilter, memberships))))

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

  _filterByNonOrgOnly: (nonOrgOnly, memberships) =>
    if nonOrgOnly()
      memberships.filter((m) => !m.orgMember())
    else
      memberships

window.birdseye.Board = Board