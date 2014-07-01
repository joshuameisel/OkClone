OkClone.Views.ProfileDetails = Backbone.View.extend({
  template: JST["users/profile_details"],
  tagName: "section",
  className: "profile-right group",

  initialize: function (options) {
    this.profile = options.profile;
  },

  render: function () {
    var renderedContent = this.template({
      user: this.model,
      profile: this.profile
    });
    this.$el.html(renderedContent);

    return this;
  }
})