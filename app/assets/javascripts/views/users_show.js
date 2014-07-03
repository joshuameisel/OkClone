OkClone.Views.UserShow = Backbone.View.extend({
  className: "profile",

  events: {
    "click .can-activate": "toggleActivated",
  },

  initialize: function (options) {
    this.subViews = [];
    if (currentUserId === this.model.id) {
      this.$el.addClass("editable");
    }
  },

  profile: function() {
    return new Profile(this.model.get("profile"))
  },

  toggleActivated: function (event) {
    event.preventDefault();
    $(event.currentTarget).closest(".gets-activated").toggleClass("activated");
  },

  render: function () {
    this.renderTop().renderLeft().renderRight();

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

		var bottomView = new OkClone.Views.ProfileBottom({user: this.model});
		$left.append(bottomView.render().$el);

    return this;
  },

  renderRight: function () {
    var rightView = new OkClone.Views.ProfileDetails({
      model: this.profile(),
      user: this.model
    });
    this.$el.append(rightView.render().$el);
    this.subViews.push(rightView);

    return this;
  }
});