OkClone.Collections.Conversation = Backbone.Collection.extend({
  model: OkClone.Models.Message,
  urlRoot: "/api/messages"
});