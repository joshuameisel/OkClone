OkClone.Helpers.updateModel = function (event) {
  event.preventDefault();
  var params = $(event.currentTarget).serializeJSON();
  var view = this;
  this.model.save(params, {
    wait: true,
    error: function (model, response) {
      view.$el.find(".errors").html(response.responseText);
    }
  });
  this.$el.toggleClass("activated");
};