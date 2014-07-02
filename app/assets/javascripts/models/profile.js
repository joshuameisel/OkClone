Profile = OkClone.Models.Profile = Backbone.Model.extend({
  url: function () {
    return "/api/users/" + this.get("user_id") + "/profile"
  }
});

Profile.displayText = function (attr) {
  switch(attr) {
    case "summary":
      return "My self-summary";
    case "likes":
      return "Favorite books, movies, shows, music, and food";
    case "most_private":
      return "The most private thing I'm willing to admit";
  }
};

Profile.religions = ["Jewish", "Christian", "Muslim"]