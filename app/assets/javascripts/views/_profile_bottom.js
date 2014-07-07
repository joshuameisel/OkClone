OkClone.Views.ProfileBottom = Backbone.View.extend({
  template: JST["users/profile_bottom"],
  className: "profile-bottom gets-activated",

  events: {
    "submit form#send-message":"sendMessage",
    "submit form#edit-interested-in":"updateUser",
  },

  initialize: function (options) {
    this.user = options.user;
    this.model = new OkClone.Models.Message({
      recipient_id: this.user.get("id")
    });
    this.listenTo(
      this.user,
      "change:orientation change:min_age change:max_age",
      this.render
    )
  },

  updateUser: function(event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    params["min_age"] = parseInt(params["min_age"]);
    params["max_age"] = parseInt(params["max_age"]);
    var view = this;
    this.user.save(params, {
      wait: true,
      patch: true,
      error: function (model, response) {
        view.$el.find(".errors").html(response.responseText);
      }
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