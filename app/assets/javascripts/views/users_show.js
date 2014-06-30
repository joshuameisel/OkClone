OkClone.Views.UserShow = Backbone.View.extend({
  template: JST["users/show"],
  className: "profile",
  initialize: function () {
    this.subViews = [];
  },
  
  render: function () {
    var topView = new OkClone.Views.ProfileTop({model: this.model});
    this.$el.html(topView.render().$el)
    
    return this
  }
})