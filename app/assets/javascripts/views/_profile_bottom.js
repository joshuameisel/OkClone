OkClone.Views.ProfileBottom = Backbone.View.extend({
  template: JST["users/profile_bottom"],
  className: "profile-bottom gets-activated",

  render: function () {
    var renderedContent = this.template({user: this.model});
    this.$el.html(renderedContent);

    return this;
  }
});