window.birdseye ?= {}

class Membership

  constructor: (member, type, orgMember) ->
    @member = ko.observable(member)
    @type = ko.observable(type)
    @orgMember = ko.observable(orgMember)

window.birdseye.Membership = Membership