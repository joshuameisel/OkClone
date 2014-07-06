ConversationShow = OkClone.Views.ConversationShow = Backbone.View.extend({
  template: JST["conversations/show"],

  render: function () {
    var renderedContent = this.template({conversation: this.collection});
    this.$el.html(renderedContent);

    return this;
  }
});