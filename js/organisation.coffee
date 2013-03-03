window.birdseye ?= {}

class Organisation
  constructor: (@id, name, @errors) ->
    @name = ko.observable(name)
    @members = ko.observableArray()
    @boards = ko.observableArray()

  loadAll: () =>
    @_loadMembers()
    @_loadBoards()

  _loadMembers: () =>
    @members([])
    Trello.organizations.get("#{@id}/members", {},
      (data) =>
        data.forEach((m) =>
          member = new birdseye.Member(m.id, m.fullName, m.username)
          @members.push(member))
      ,
      @_error)

  _loadBoards: () =>
    @boards([])
    Trello.organizations.get("#{@id}/boards", {},
      (data) =>
        data.forEach((b) =>
          board = new birdseye.Board(b.id, b.name, @_memberships(b.memberships))
          @boards.push(board))
      ,
      @_error)

  _memberships: (data) =>
    list = []
    data.forEach((m) =>
      if !m.deactivated
        list.push(new birdseye.Membership(m.idMember, m.memberType, true))
    )
    list

  _error: (m) =>
    @errors().add(m)
    console.log("App: Error: #{m}")

window.birdseye.Organisation = Organisation