OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top",

	initialize: function () {
		this.$el.addClass("group");
	},

  render: function () {
    var renderedContent = this.template({user: this.model})
    this.$el.html(renderedContent)

    return this
  }
})