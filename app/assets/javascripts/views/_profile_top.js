OkClone.Views.ProfileTop = Backbone.View.extend({
  template: JST["users/profile_top"],
  render: function () {
    var renderedContent = this.template({user: this.model})
    this.$el.html(renderedContent)
    
    return this
  }
})