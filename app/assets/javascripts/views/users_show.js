OkClone.Views.UserShow = Backbone.View.extend({
  template: JST["users/show"],
  className: ((this.ownProfile) ? "profile editable" : "profile"),
  initialize: function (options) {
    this.subViews = [];
		this.ownProfile = options.ownProfile;
		if (this.ownProfile) {
			this.$el.addClass("editable");
		}
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