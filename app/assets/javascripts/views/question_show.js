QuestionShow = OkClone.Views.QuestionShow = Backbone.View.extend({
  template: JST["questions/show"],

  initialize: function (options) {
		this.currentUser = options.currentUser;
		this.user = options.user;
		
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({});
    this.$el.html(renderedContent);

    return this;
  }
});