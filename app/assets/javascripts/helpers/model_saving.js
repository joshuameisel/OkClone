OkClone.Helpers.updateModel = function (event) {
  event.preventDefault();
  var params = $(event.currentTarget).serializeJSON();
  var view = this;
  this.model.save(params, {
    wait: true,
    success: function () {
      view.$el.toggleClass("activated");
    },
    error: function (model, response) {
      view.$el.find(".errors").html(response.responseText);
      view.$el.toggleClass("activated");
    }
  });
};