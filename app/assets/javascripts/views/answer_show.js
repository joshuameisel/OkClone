AnswerShow = OkClone.Views.AnswerShow = Backbone.View.extend({
  template: JST["answers/show"],
	tagName: "li",
	className: "group question gets-activated",
    events: {
      "click .can-activate": "toggleActivated",
      "submit form": "updateAnswer"
    },

    updateAnswer: function(event){
      OkClone.Helpers.updateModel.bind(this)(event);
    },

  toggleActivated: function (event) {
    event.preventDefault();
    $(event.currentTarget).closest(".editable .gets-activated")
                          .toggleClass("activated");
  },

  initialize: function (options) {
    this.listenTo(this.model, "sync", this.render);
  },

  render: function () {
    var renderedContent = this.template({
    	currentUser: this.model.get("current_user"),
			user: this.model.get("user"),
			question: this.model.get("question")
    });
    this.$el.html(renderedContent);

    return this;
  }
});