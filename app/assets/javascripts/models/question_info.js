QuestionInfo = OkClone.Models.QuestionInfo = Backbone.Model.extend({
  urlRoot: function () {
    return "/api/users/" + this.userId + "/questions";
  },
  initialize: function (options) {
    this.userId = options.userId;
		this.id = options.id
  }
});