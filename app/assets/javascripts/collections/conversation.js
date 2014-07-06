Conversation = OkClone.Collections.Conversation = Backbone.Collection.extend({
  model: OkClone.Models.Message,
  url: function () {
    return "/api/users/" + this.userId + "/messages";
  },
  initialize: function (models, options) {
    this.userId = options.userId;
  }
});