ConversationShow = OkClone.Views.ConversationShow = Backbone.View.extend({
  template: JST["conversations/show"],

  events: {
    "submit form":"sendMessage"
  },

  sendMessage: function(event) {
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    var view = this;
    this.collection.create(new Message({
      recipient_id: location.pathname.split("/")[2],
      body: params.body
    }));
  },

  render: function () {
    var renderedContent = this.template({conversation: this.collection});
    this.$el.html(renderedContent);

    return this;
  }
});