OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top group can-activate",

  events: {
    "submit form": "updateUser"
  },

  updateUser: function(event) {
    OkClone.Helpers.updateModel.bind(this)(event);
  },

	initialize: function () {
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
    var renderedContent = this.template({user: this.model});
    this.$el.html(renderedContent);

    return this;
  }
});