OkClone.Views.UserShow = Backbone.View.extend({
  template: JST["users/show"],
  className: "profile",

  events: {
    "click .show-modal": "showModal",
    "click .hide-modal": "hideModal"
  },

  initialize: function (options) {
    this.subViews = [];
    if (currentUserId === this.model.id) {
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
		});
    this.$el.html(topView.render().$el)
    this.subViews << topView

    return this
  }
})