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
    this.model.save(params);
    $(".profile-top.activated").toggleClass("activated")
  },

	initialize: function () {
		this.$el.addClass("group");
    this.listenTo(this.model, "change", this.render);
	},

  render: function () {
    console.log("rendered")
    var renderedContent = this.template({user: this.model})
    this.$el.html(renderedContent)

    return this
  }
})