// Generated by CoffeeScript 1.4.0
(function() {
  var Member, _ref;

  if ((_ref = window.birdseye) == null) {
    window.birdseye = {};
  }

  Member = (function() {

    function Member(id, fullName, username) {
      this.id = id;
      this.fullName = ko.observable(fullName);
      this.username = ko.observable(username);
    }

    return Member;

  })();

  window.birdseye.Member = Member;

}).call(this);
