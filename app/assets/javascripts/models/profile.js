OkClone.Models.Profile = Backbone.Model.extend({
});

OkClone.Models.Profile.displayText = function (attr) {
  switch(attr) {
    case "summary":
      return "My self-summary";
      "likes", "most_private"
    case "likes":
      return "Favorite books, movies, shows, music, and food";
    case "most_private":
      return "The most private thing I'm willing to admit";
  }
};