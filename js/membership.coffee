window.birdseye ?= {}

class Membership

  constructor: (member, type, isMember) ->
    @member = ko.observable(member)
    @type = ko.observable(type)
    @isMember = ko.observable(isMember)

window.birdseye.Membership = Membership