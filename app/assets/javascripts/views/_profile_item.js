OkClone.Views.ProfileItem = Backbone.View.extend({
  template: JST["users/profile_item"],
  className: "profile-item can-activate",
  events: {
    "submit form": "updateProfile"
  },

  updateProfile: function(event){
    OkClone.Helpers.updateModel.bind(this)(event);
  },

  initialize: function (options) {
    this.attr = options.attr;
    this.$el.attr("id", this.attr);
    this.listenTo(this.model, "change:" + this.attr, this.render);
  },

  render: function () {
    var renderedContent = this.template({
      profile: this.model,
      attr: this.attr
    });
    this.$el.html(renderedContent);

    return this;
  }
});