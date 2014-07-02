OkClone.Views.ProfileDetails = Backbone.View.extend({
  template: JST["users/profile_details"],
  tagName: "section",
  className: "profile-right can-activate group",

  events: {
    "submit form": "updateProfile"
  },

  updateProfile: function(event) {
    OkClone.Helpers.updateModel.bind(this)(event);
  },

  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.model, "change", this.render);
  },

  render: function () {
    var renderedContent = this.template({
      profile: this.model,
      user: this.user
    });
    this.$el.html(renderedContent);

    return this;
  }
})