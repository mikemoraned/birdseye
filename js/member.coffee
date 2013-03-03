window.birdseye ?= {}

class Member

  constructor: (@id, fullName, username) ->
    @fullName = ko.observable(fullName)
    @username = ko.observable(username)

window.birdseye.Member = Member