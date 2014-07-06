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

	initialize: function () {
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
    debugger
    var renderedContent = this.template({user: this.model});
    this.$el.html(renderedContent);

    return this;
  }
});