$.TweetCompose = function(el) {
  this.$el = $(el);
  this.$inputs = $(':input');
  this.counter = 0;
  this.$mentionedUserA = this.$el.find(".add-mentioned-user");
  this.$mentionedUserA.on("click", this.addMentionedUser.bind(this));
  this.$el.find('textarea').on("input", this.remainingCount.bind(this));
  this.$el.on("submit", this.submit.bind(this));
  $('.mentioned-users').on("click", 'a.remove-mentioned-user', this.removeMentionedUser.bind(this));


};

$.TweetCompose.prototype.removeMentionedUser = function(event) {
  var currentLink = event.currentTarget;
  var $parentDiv = $(currentLink.parentElement);
  $parentDiv.hide();
}
$.TweetCompose.prototype.addMentionedUser = function() {
  this.$selectMention = this.$el.find('script').html();
  $('.mentioned-users').append(this.$selectMention);

};
$.TweetCompose.prototype.remainingCount = function() {
  this.counter++;
  $('.chars-left').html("Characters Remaining: " + (140-this.counter));
};
$.TweetCompose.prototype.submit = function(event) {
  event.preventDefault();
  var formData = this.$el.serializeJSON();
  this.$inputs.prop("disabled", true);

  $.ajax({
    type: "POST",
    url: "/tweets",
    dataType: "json",
    data: formData,
    success: function(response) {
      console.log("successful");
      this.handleSuccess(response);
    }.bind(this)
  });
};

$.TweetCompose.prototype.clearInput = function () {
  this.counter = 0;
  this.$el.find('textarea').val('');
  this.$el.find('select').val('');
  $('.mentioned-users').empty();
};

$.TweetCompose.prototype.handleSuccess = function(response) {
  this.$inputs.prop("disabled", false);
  this.clearInput();

  // populate ul with new posts
  var ulId = this.$el.data("tweets-ul");
  var jsonResponse = JSON.stringify(response);
  // console.log(jsonResponse);
  // debugger
  var tweetContent = response.content;
  var author = response.user.username;
  var authorId = response.user_id;
  // var tweetMentionedId = response.mentions[0].user_id;
  // var tweetMentionedUsername = response.mentions[0].user.username;
  // var tweetMentionedUser = response.
  var tweetCreatedAt = response.created_at;

  var createLink = $('<a>').attr("href", "/users/" + authorId).html(author);
  var createTweet = tweetContent + "--" + createLink + "--" + tweetCreatedAt;
  $(ulId).prepend($('<li>').append(tweetContent).append(" -- ").append(createLink).append(" -- ").append(tweetCreatedAt));


};
$.fn.tweetCompose = function() {
  return this.each(function() {
    new $.TweetCompose(this);
  });
}

$(function() {
  $('.tweet-compose').tweetCompose();
});
