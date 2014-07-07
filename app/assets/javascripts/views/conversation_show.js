ConversationShow = OkClone.Views.ConversationShow = Backbone.View.extend({
  template: JST["conversations/show"],

  events: {
    "submit form":"sendMessage"
  },

  initialize: function () {
    this.listenTo(this.collection, "add", this.render);
  },

  sendMessage: function(event) {
    var that = this;
    event.preventDefault();
    var params = $(event.currentTarget).serializeJSON();
    params.recipient_id = location.pathname.split("/")[2];
    var newMessage = new Message;
    newMessage.save(params, {
      wait: true,
      patch: true,
      success: function () {
        that.collection.fetch();
      }
    });
  },

  render: function () {
    console.log("got here");
    var renderedContent = this.template({conversation: this.collection});
    this.$el.html(renderedContent);

    return this;
  }
});