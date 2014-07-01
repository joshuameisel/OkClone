OkClone.Views.UserShow = Backbone.View.extend({
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

  profile: function() {
    return new OkClone.Models.Profile(this.model.get("profile"))
  },

  showModal: function(event){
    $(event.currentTarget.parentElement).toggleClass("activated");
  },

  hideModal: function(event){
    event.preventDefault();
    $(event.currentTarget).closest(".activated").toggleClass("activated");
  },

  render: function () {
    this.renderTop().renderLeft();

    return this
  },

  renderTop: function () {
    var topView = new OkClone.Views.ProfileTop({
			model: this.model,
		});
    this.$el.html(topView.render().$el);
    this.subViews.push(topView);

    return this;
  },

  renderLeft: function () {
    var view = this;
    var $left = $("<section>").addClass("profile-left group")
                              .attr("id", "profile");
    this.$el.append($left);

    ["summary", "likes", "most_private"].forEach(function (attr) {
      var itemView = new OkClone.Views.ProfileItem({
        model: view.profile(),
        attr: attr
      })
      view.subViews.push(itemView);
      $left.append(itemView.render().$el);
    });

    return this;
  },

  renderRight: function () {
    return this;
  }
})