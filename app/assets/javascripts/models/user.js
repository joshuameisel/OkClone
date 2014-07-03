var User = OkClone.Models.User = Backbone.Model.extend({
  urlRoot: "/api/users"
});

User.sexTexts = {
	"m": "Men",
	"f": "Women"
}