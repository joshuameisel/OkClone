OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top group gets-activated",

  events: {
    "submit form": "updateUser"
  },

  updateUser: function(event) {
    OkClone.Helpers.updateModel.bind(this)(event);
  },

  profilePicURL: function() {
    var profile_pic = this.model.get("profile_pic");

    if (profile_pic) {
      return profile_pic.photo_file.url.profile;
    } else {
      return "/images/default_profile.gif";
    }
  },

	initialize: function () {
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
		var url = location.pathname.split("/");
		
		// users/?/photos => photos, .../questions => questions, users/? => about
		var selected = url[3] || "about"
		
    var renderedContent = this.template({
      user: this.model,
      profilePicURL: this.profilePicURL(),
			userUrl: url.slice(0,3).join("/"),
			selected: selected,
			isCurrentUser: currentUserId === this.model.get("id")
    });
    this.$el.html(renderedContent);

    return this;
  }
});