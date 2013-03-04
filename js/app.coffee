window.birdseye ?= {}

class App

  constructor: () ->
    @organisations = ko.observableArray([])
    @selectedOrganisation = ko.observable()
    @user = ko.observable(new birdseye.User())
    @errors = ko.observable(new birdseye.Errors())
    @memberFilter = ko.observable("")
    @adminsOnly = ko.observable(false)
    @user().organisationIds.subscribe(@_fetchOrganisations)
    @selectedOrganisation.subscribe((org) =>
      if org?
        org.loadAll())

  _fetchOrganisations: () =>
    console.log("Fetching orgs")
    @organisations([])
    @user().organisationIds().forEach((id) =>
      console.log("Fetching org with id: #{id}")
      Trello.organizations.get(id, {},
        (data) =>
          org = new birdseye.Organisation(id, data.displayName, @errors(), @memberFilter, @adminsOnly)
          @organisations.push(org)
          if @organisations.length == 1
            @selectedOrganisation(org)
        ,
        @_error)
    )

  _error: (m) =>
    @errors().add(m)
    console.log("App: Error: #{m}")

window.birdseye.App = App