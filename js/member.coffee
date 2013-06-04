window.birdseye ?= {}

class Member

  constructor: (@id, fullName, username) ->
    @fullName = ko.observable(fullName)
    @username = ko.observable(username)
    @home = ko.observable()

  update: () =>
    Trello.members.get("#{@id}", {},
    (data) =>
      @fullName(data.fullName)
      @username(data.username)
      @home(data.url)
    ,
    @_error)

  matches: (filter) =>
    if filter? and (@fullName()? or @username()?)
      f = filter.toLowerCase()
      @fullName().toLowerCase().indexOf(f) >= 0 or @username().indexOf(f) >= 0
    else
      true

  _error: (m) =>
    console.log("Error: #{m}")

window.birdseye.Member = Member