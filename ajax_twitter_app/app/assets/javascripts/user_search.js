$.UserSearch = function (el) {
  this.$el = $(el);
  this.$input = this.$el.find("input");
  this.$ul = this.$el.find("ul");
  var that = this;
  this.$input.on("input", this.handleInput.bind(this));
};

$.UserSearch.prototype.handleInput = function(event) {
  var currentInput = this.$input.val();
  console.log(currentInput);
  $.ajax({
    type: "GET",
    url: "/users/search",
    data: {
      query: currentInput
    },
    dataType: "json",
    success: function(response) {
      this.renderResults(response);
    }.bind(this)
  });
};

$.UserSearch.prototype.renderResults = function(response) {
  this.$ul.html("");
  response.forEach(function(el) {
    // console.log(current_user);

    var userId = el.id;
    // debugger
    var currentLink = "/users/" + userId;
    var currentUsername = el.username;
    var $link = $('<a>').attr("href", currentLink).text(currentUsername);
    var $button = $('<button>').followToggle({
      userId: userId,
      followState: el.followed ? "followed" : "unfollowed"
    }); // pass userid and initial follow state
    console.log($link);
    this.$ul.append($('<li>').append($link).append("    ").append($button));
  }.bind(this));
};

$.fn.userSearch = function () {
  return this.each(function () {
    new $.UserSearch(this);
  });
};

$(function () {
  $("div.users-search").userSearch();
});
