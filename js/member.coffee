window.birdseye ?= {}

class Member

  constructor: (@id, fullName, username) ->
    @fullName = ko.observable(fullName)
    @username = ko.observable(username)

  matches: (filter) =>
    if filter?
      @fullName().toLowerCase().indexOf(filter) >= 0 or @username().indexOf(filter) >= 0
    else
      true

window.birdseye.Member = Member