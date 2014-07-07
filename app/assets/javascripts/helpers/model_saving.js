OkClone.Helpers.updateModel = function (event, modelToSave) {
  if (!modelToSave) {
    modelToSave = this.model;
  }
  event.preventDefault();
  var params = $(event.currentTarget).serializeJSON();
  var view = this;
  modelToSave.save(params, {
    wait: true,
    patch: true,
    success: function () {
      view.$el.toggleClass("activated");
    },
    error: function (model, response) {
      view.$el.find(".errors").html(response.responseText);
      view.$el.toggleClass("activated");
    }
  });
};