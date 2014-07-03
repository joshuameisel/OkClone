Message = OkClone.Models.Message = Backbone.Model.extend({
  urlRoot: function () {
    return "/api/users/" + this.get("recipient_id") + "/messages"
  }
});