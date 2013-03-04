window.birdseye ?= {}

class Organisation
  constructor: (@id, name, @errors, @memberFilter) ->
    @name = ko.observable(name)
    @members = ko.observableArray()
    @boards = ko.observableArray()

  loadAll: () =>
    @members([])
    @boards([])
    @_loadMembers(@_loadBoards)

  _loadMembers: (onSuccess) =>
    @members([])
    Trello.organizations.get("#{@id}/members", {},
      (data) =>
        data.forEach((m) =>
          member = new birdseye.Member(m.id, m.fullName, m.username, m.initials)
          @members.push(member))
        onSuccess()
      ,
      @_error)

  _loadBoards: () =>
    @boards([])
    Trello.organizations.get("#{@id}/boards", {},
      (data) =>
        data.forEach((b) =>
          board = new birdseye.Board(b.id, b.name, @_memberships(b.memberships), @memberFilter)
          @boards.push(board))
      ,
      @_error)

  _memberships: (data) =>
    list = []
    data.forEach((m) =>
      membershipTypeMap = {}
      if !m.deactivated
        membershipTypeMap[m.idMember] = m.memberType
      @members().forEach((member) =>
        membershipType = membershipTypeMap[member.id]
        if membershipType?
          list.push(new birdseye.Membership(member, membershipType, true))
      )
    )
    list

  _error: (m) =>
    @errors().add(m)
    console.log("App: Error: #{m}")

window.birdseye.Organisation = Organisation