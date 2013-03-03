window.birdseye ?= {}

class User
  status: ko.observable("signed-out")
  name: ko.observable()

  constructor: ->
    @signedIn = ko.computed(() =>
      @status() == "signed-in"
    )

  freshSignIn: () =>
    @signOut()
    @_signIn()

  signOut: () =>
    Trello.deauthorize()
    @status("signed-out")
    @name(null)

  _signIn: () =>
    @status("signing-in")
    Trello.authorize({
      type: "popup",
      name: "Birds eye",
      success: () =>
        @status("signed-in")
        @_updateName()
      ,
      error: @_error
    })

  _error: (m) =>
    @signOut()
    console.log("Error: #{m}")

  _updateName: () =>
    Trello.members.get("me", {},
      (user) =>
        @name(user.fullName)
      ,
      @_error
    )

window.birdseye.User = User