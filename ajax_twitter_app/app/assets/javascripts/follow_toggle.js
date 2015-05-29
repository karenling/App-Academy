$.FollowToggle = function (el) {
  this.$el = $(el);
  this.userId = this.$el.data("user-id");
  this.followState = this.$el.data("initial-follow-state");
  console.log(this.followState);
  this.render();
  this.$el.on("click", this.handleClick.bind(this));
};

$.FollowToggle.prototype.render = function () {

  if (this.followState === "unfollowing" || this.followState === "following") {
    this.$el.prop("disabled", true);
  }

  if (this.followState === "unfollowed") {
    this.$el.html("Follow!");
    this.$el.prop("disabled", false);
  } else if (this.followState === "followed") {
    this.$el.html("Unfollow!");
    this.$el.prop("disabled", false);
  }
};

$.FollowToggle.prototype.handleClick = function(event) {
  event.preventDefault();

  if (this.followState === "unfollowed") {
    this.followState = "following";
    this.render();
    // this.$el.prop("disabled", true);
    $.ajax({
      type: "POST",
      url: "/users/" + this.userId + "/follow",
      dataType: "json",
      success: function(response) {
        this.followState = "followed";
        this.render();
      }.bind(this)
    });
  } else if (this.followState === "followed") {
    this.followState = "unfollowing";
    this.render();
    // this.$el.prop("disabled", true);
    $.ajax({
      type: "DELETE",
      url: "/users/" + this.userId + "/follow",
      dataType: "json",
      success: function(response) {
        this.followState = "unfollowed";
        this.render();
      }.bind(this)
    });
  }

};

$.fn.followToggle = function () {
  return this.each(function () {
    new $.FollowToggle(this);
  });
};

$(function () {
  $("button.follow-toggle").followToggle();
});
