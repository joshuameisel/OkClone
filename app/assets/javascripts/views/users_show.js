OkClone.Views.UserShow = Backbone.View.extend({
  template: JST["users/show"],
  className: ((this.ownProfile) ? "profile editable" : "profile"),

  events: {
    "click .show-modal": "showModal",
    "click .hide-modal": "hideModal"
  },

  initialize: function (options) {
    this.subViews = [];
		this.ownProfile = options.ownProfile;
		if (this.ownProfile) {
			this.$el.addClass("editable");
		}
  },

  showModal: function(event){
    $(event.currentTarget.parentElement).toggleClass("activated");
  },

  hideModal: function(event){
    event.preventDefault();
    $(event.currentTarget).closest(".activated").toggleClass("activated");
  },

  render: function () {
    var topView = new OkClone.Views.ProfileTop({
			model: this.model,
			ownProfile: this.ownProfile
		});
    this.$el.html(topView.render().$el)

    return this
  }
})