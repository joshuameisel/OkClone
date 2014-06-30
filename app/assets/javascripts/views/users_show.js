OkClone.Views.UserShow = Backbone.View.extend({
  template: JST["users/show"],
  className: "profile",
  
  render: function () {
    var renderedContent = this.template({
      user: this.model, 
      profile: this.model.get("profile")
    });
    this.$el.html(renderedContent);

    return this;
  }
})