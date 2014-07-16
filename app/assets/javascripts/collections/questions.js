Questions = OkClone.Collections.Questions = Backbone.Collection.extend({
  url: function () {
    return "/api/users/" + this.userId + "/questions";
  },
  initialize: function (models, options) {
    this.userId = options.userId;
  }
});