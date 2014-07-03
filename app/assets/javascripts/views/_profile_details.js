OkClone.Views.ProfileDetails = Backbone.View.extend({
  template: JST["users/profile_details"],
  tagName: "section",
  className: "profile-right gets-activated group",

  events: {
    "submit form": "updateProfile"
  },

  updateProfile: function(event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    var view = this;

    this.user.save(params["user"], {
      wait: true,
      success: function () {
        view.model.save(params["profile"], {
          wait: true,
          success: function () {
            view.$el.toggleClass("activated");
          },
          error: function (model, response) {
            view.$el.find(".errors").html(response.responseText);
            view.$el.toggleClass("activated");
          }
        });
      }
    });
  },

  initialize: function (options) {
    this.user = options.user;
    this.listenTo(this.model, "change", this.render);
    this.listenTo(this.user, "change", this.render);
  },

  render: function () {
    var view = this
    this.user.fetch({
      success: function () {
        var renderedContent = view.template({
          profile: view.model,
          user: view.user
        });
        view.$el.html(renderedContent);
      }
    });

    return this;
    // success: function () {
    //   var renderedContent = this.template({
    //     profile: this.model,
    //     user: this.user
    //   });
    //   this.$el.html(renderedContent);
    //
    //   return this;
    // }
  }
});