window.birdseye ?= {}

class User
  status: ko.observable("signed-out")
  name: ko.observable()
  organisationIds: ko.observableArray()

  constructor: ->
    @signedIn = ko.computed(() =>
      @status() == "signed-in"
    )

  freshSignIn: () =>
    @_clear()
    @signOut()
    @_signIn()

  signOut: () =>
    @_clear()
    Trello.deauthorize()
    @status("signed-out")

  _clear: () =>
    @name(null)
    @organisationIds([])

  _signIn: () =>
    @status("signing-in")
    Trello.authorize({
      type: "popup",
      name: "Birds Eye",
      success: () =>
        @status("signed-in")
        @_update()
      ,
      error: @_error
    })

  _error: (m) =>
    @signOut()
    console.log("Error: #{m}")

  _update: () =>
    @_clear()
    Trello.members.get("me", {},
      (user) =>
        @name(user.fullName)
        @organisationIds(user.idOrganizations)
      ,
      @_error
    )

window.birdseye.User = User