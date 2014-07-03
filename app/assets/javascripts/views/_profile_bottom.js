OkClone.Views.ProfileBottom = Backbone.View.extend({
  template: JST["users/profile_bottom"],
  className: "profile-bottom gets-activated",

  events: {
    "submit form":"sendMessage"
  },

  initialize: function (options) {
    this.user = options.user;
    this.model = new OkClone.Models.Message({
      recipient_id: this.user.get("id")
    });
  },

  sendMessage: function(event) {
    OkClone.Helpers.updateModel.bind(this)(event);
  },

  render: function () {
    var renderedContent = this.template({user: this.user});
    this.$el.html(renderedContent);

    return this;
  }
});