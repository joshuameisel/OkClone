QuestionShow = OkClone.Views.QuestionShow = Backbone.View.extend({
  template: JST["questions/show"],
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

  mismatch: function () {
    var user = this.model.get("user");
    var currentUser = this.model.get("current_user");
    if (!(user && currentUser && currentUser.answer)) {
      return {};
    }

    var mismatch = {user: false, currentUser: false};
    if (currentUser.acceptable_answers.length > 0) {
			mismatch.user = true;

      currentUser.acceptable_answers.forEach(function(acc_answer) {
        if (acc_answer.answer_choice_id == user.answer.id) {
					mismatch.user = false;
        }
      });
    }

    if (user.acceptable_answers.length > 0) {
			mismatch.currentUser = true;
			var that = this;

      user.acceptable_answers.forEach(function(acc_answer) {
        if (acc_answer.answer_choice_id == currentUser.answer.id) {
					mismatch.currentUser = false;
        }
      });
    }
	  return mismatch;
  },

  render: function () {
    var renderedContent = this.template({
    	currentUser: this.model.get("current_user"),
			user: this.model.get("user"),
			question: this.model.get("question"),
      mismatch: this.mismatch()
    });
    this.$el.html(renderedContent);

    return this;
  }
});