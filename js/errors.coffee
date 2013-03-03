window.birdseye ?= {}

class Errors
  seen: ko.observableArray()

  add: (m) =>
    seen.push(m)

window.birdseye.Errors = Errors