OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
	tagName: "section",
	className: "profile-top",

  events: {
    "submit form": "updateUser"
  },

  updateUser: function(event){
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    var view = this;
    this.model.save(params, {
      wait: true,
      error: function (model, response) {
        view.$el.prepend(
          "<p class='errors'>" + response.responseText + "</p>"
        );
      }
    });
    $(".profile-top.activated").toggleClass("activated")
  },

	initialize: function () {
		this.$el.addClass("group");
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
    var renderedContent = this.template({user: this.model})
    this.$el.html(renderedContent)

    return this
  }
})