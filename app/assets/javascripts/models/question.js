Question = OkClone.Models.Question = Backbone.Model.extend({
  urlRoot: function() {
    return "/api/users/" + this.userId + "/questions"
  },

  initialize: function (options) {
		this.id = options.id;
    this.userId = options.userId;
  }
});