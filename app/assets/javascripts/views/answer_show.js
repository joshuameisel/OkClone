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

  mismatch: function () {
    var mismatch = {};
    var user = this.model.get("user");
    var currentUser = this.model.get("current_user");
    if (user && currentUser) {
      var isMatch = false;
      currentUser.acceptable_answers.forEach(function(acc_answer) {
        if (acc_answer.answer_choice_id == user.answer.id) {
          isMatch = true;
        }
      });
      if (!isMatch) {
        mismatch.user = true;
      }

      isMatch = false;
      user.acceptable_answers.forEach(function(acc_answer) {
        if (acc_answer.answer_choice_id == currentUser.answer.id) {
          var isMatch = true;
        }
      });
      if (!isMatch) {
        mismatch.currentUser = true;
      }
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