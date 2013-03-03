window.birdseye ?= {}

class Membership

  constructor: (idMember, type, isMember) ->
    @idMember = ko.observable(idMember)
    @type = ko.observable(type)
    @isMember = ko.observable(isMember)

window.birdseye.Membership = Membership