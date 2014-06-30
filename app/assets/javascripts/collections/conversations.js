OkClone.Collections.Conversations = Backbone.Collection.extend({
  model: OkClone.Models.Conversation,
  urlRoot: "/api/messages"
});