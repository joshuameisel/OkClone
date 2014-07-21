Answer = OkClone.Models.Answer = Backbone.Model.extend({
  urlRoot: "/api/answers",

  initialize: function (options) {
    if (options) {
  		this.id = options.id;
    }
  }
});