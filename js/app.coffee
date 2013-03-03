window.birdseye ?= {}

class App
  organisations: ko.observableArray([])
  selectedOrganisation: ko.observable()
  user: ko.observable(new birdseye.User())

window.birdseye.App = App