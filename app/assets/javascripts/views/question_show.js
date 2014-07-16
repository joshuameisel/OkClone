QuestionShow = OkClone.Views.QuestionShow = Backbone.View.extend({
  template: JST["questions/show"],
	tagName: "li",
	className: "group question",

  initialize: function (options) {
    this.listenTo(this.model, "change", this.render);
  },

  render: function () {
    var renderedContent = this.template({
    	currentUser: this.model.get("current_user"), 
			user: this.model.get("user")
    });
    this.$el.html(renderedContent);

    return this;
  }
});