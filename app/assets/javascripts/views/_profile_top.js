OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top group gets-activated",

  events: {
    "submit form": "updateUser"
  },

  profilePicURL: function() {
    var profile_pic = this.model.get("profile_pic");

    if (profile_pic) {
      return profile_pic.photo_file.url.profile;
    } else {
      return "/images/default_profile.gif";
    }
  },

  updateUser: function(event) {
    OkClone.Helpers.updateModel.bind(this)(event);
  },

	initialize: function () {
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
    var renderedContent = this.template({
      user: this.model,
      profilePicURL: this.profilePicURL()
    });
    this.$el.html(renderedContent);

    return this;
  }
});