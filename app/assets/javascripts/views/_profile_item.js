OkClone.Views.ProfileItem = Backbone.View.extend({
  template: JST["users/profile_item"],

  initialize: function (options) {
    this.attr = options.attr;
  },

  render: function () {
    var renderedContent = this.template({profile: this.model, attr: this.attr})
    this.$el.html(renderedContent)

    return this
  }
})