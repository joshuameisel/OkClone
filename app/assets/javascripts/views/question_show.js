QuestionShow = OkClone.Views.QuestionShow = Backbone.View.extend({
  template: JST["questions/show"],
	tagName: "li",
	className: "group question gets-activated",
    events: {"click .can-activate": "toggleActivated"},

  toggleActivated: function (event) {
    event.preventDefault();
    $(event.currentTarget).closest(".editable .gets-activated")
                          .toggleClass("activated");
  },

  initialize: function (options) {

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