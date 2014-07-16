QuestionsInfo = OkClone.Models.QuestionsInfo = Backbone.Model.extend({
  url: function () {
    return "/api/users/" + this.userId + "/questions";
  },
  initialize: function (options) {
    this.userId = options.userId;
  }
});