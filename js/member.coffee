window.birdseye ?= {}

class Member

  constructor: (@id, fullName, username) ->
    @fullName = ko.observable(fullName)
    @username = ko.observable(username)

  matches: (filter) =>
    if filter? and (@fullName()? or @username()?)
      f = filter.toLowerCase()
      @fullName().toLowerCase().indexOf(f) >= 0 or @username().indexOf(f) >= 0
    else
      true

window.birdseye.Member = Member