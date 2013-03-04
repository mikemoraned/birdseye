// Generated by CoffeeScript 1.4.0
(function() {
  var Organisation, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  if ((_ref = window.birdseye) == null) {
    window.birdseye = {};
  }

  Organisation = (function() {

    function Organisation(id, name, errors, memberFilter, adminsOnly) {
      this.id = id;
      this.errors = errors;
      this.memberFilter = memberFilter;
      this.adminsOnly = adminsOnly;
      this._error = __bind(this._error, this);

      this._memberships = __bind(this._memberships, this);

      this._loadBoards = __bind(this._loadBoards, this);

      this._loadMembers = __bind(this._loadMembers, this);

      this.loadAll = __bind(this.loadAll, this);

      this.name = ko.observable(name);
      this.members = ko.observableArray();
      this.boards = ko.observableArray();
    }

    Organisation.prototype.loadAll = function() {
      this.members([]);
      this.boards([]);
      return this._loadMembers(this._loadBoards);
    };

    Organisation.prototype._loadMembers = function(onSuccess) {
      var _this = this;
      this.members([]);
      return Trello.organizations.get("" + this.id + "/members", {}, function(data) {
        data.forEach(function(m) {
          var member;
          member = new birdseye.Member(m.id, m.fullName, m.username, m.initials);
          return _this.members.push(member);
        });
        return onSuccess();
      }, this._error);
    };

    Organisation.prototype._loadBoards = function() {
      var membersById,
        _this = this;
      this.boards([]);
      membersById = {};
      this.members().forEach(function(m) {
        return membersById[m.id] = m;
      });
      return Trello.organizations.get("" + this.id + "/boards", {}, function(data) {
        return data.forEach(function(b) {
          var board;
          board = new birdseye.Board(b.id, b.name, b.url, _this._memberships(membersById, b.memberships), _this.memberFilter, _this.adminsOnly);
          return _this.boards.push(board);
        });
      }, this._error);
    };

    Organisation.prototype._memberships = function(orgMembersById, data) {
      var list,
        _this = this;
      list = [];
      data.forEach(function(m) {
        var membershipTypeMap, orgMember, unknownMember;
        membershipTypeMap = {};
        if (!m.deactivated) {
          orgMember = orgMembersById[m.idMember];
          if (orgMember != null) {
            return list.push(new birdseye.Membership(orgMember, m.memberType, true));
          } else {
            unknownMember = new birdseye.Member(m.idMember, "unknown", "unknown");
            return list.push(new birdseye.Membership(unknownMember, m.memberType, false));
          }
        }
      });
      return list;
    };

    Organisation.prototype._error = function(m) {
      this.errors().add(m);
      return console.log("App: Error: " + m);
    };

    return Organisation;

  })();

  window.birdseye.Organisation = Organisation;

}).call(this);
