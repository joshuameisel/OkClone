OkClone.Helpers.updateModel = function (event) {
  event.preventDefault();
  var params = $(event.currentTarget).serializeJSON();
  var view = this;
  this.model.save(params, {
    wait: true,
    error: function (model, response) {
      view.$el.prepend(
        "<p class='errors'>" + response.responseText + "</p>"
      );
    }
  });
  this.$el.toggleClass("activated");
};