OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top",

  events: {
    "submit form": "updateUser"
  },

  updateUser: function(event){
    debugger
  },

	initialize: function () {
		this.$el.addClass("group");
    if (this.model.id === currentUserId) {
      this.$el.addClass("activated");
    }
	},

  render: function () {
    var renderedContent = this.template({user: this.model})
    this.$el.html(renderedContent)

    return this
  }
})