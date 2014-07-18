Answer = OkClone.Models.Answer = Backbone.Model.extend({
  urlRoot: "/api/answers",

  initialize: function (options) {
		this.id = options.id;
  }
});