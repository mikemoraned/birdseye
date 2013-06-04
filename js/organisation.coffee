window.birdseye ?= {}

class Organisation
  constructor: (@id, name, @errors, @memberFilter, @adminsOnly, @nonOrgOnly) ->
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
          member = new birdseye.Member(m.id, m.fullName, m.username)
          @members.push(member))
        onSuccess()
      ,
      @_error)

  _loadBoards: () =>
    @boards([])
    membersById = {}
    @members().forEach((m) =>
      membersById[m.id] = m
      m.update()
    )
    Trello.organizations.get("#{@id}/boards", {},
      (data) =>
        data.forEach((b) =>
          board = new birdseye.Board(b.id, b.name, b.url, @_memberships(membersById, b.memberships), @memberFilter, @adminsOnly, @nonOrgOnly)
          @boards.push(board))
      ,
      @_error)

  _memberships: (orgMembersById, data) =>
    list = []
    data.forEach((m) =>
      membershipTypeMap = {}
      if !m.deactivated
        orgMember = orgMembersById[m.idMember]
        if orgMember?
          list.push(new birdseye.Membership(orgMember, m.memberType, true))
        else
          unknownMember = new birdseye.Member(m.idMember, "unknown", "unknown")
          list.push(new birdseye.Membership(unknownMember, m.memberType, false))
          unknownMember.update()
    )
    list

  _error: (m) =>
    @errors().add(m)
    console.log("App: Error: #{m}")

window.birdseye.Organisation = Organisation