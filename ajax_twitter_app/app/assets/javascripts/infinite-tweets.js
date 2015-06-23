$.InfiniteTweets = function(el) {
  this.$el = $(el);
  this.maxCreatedAt = null;
  this.$script = this.$el.find('script');
  console.log(this.$script);
  $('a.fetch-more').on("click", this.fetchTweets.bind(this));
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



$.InfiniteTweets.prototype.fetchTweets = function(event) {
  console.log("hello");

  // if (this.maxCreatedAt != null) {
  //   $.ajax({
  //     type: "GET",
  //     url: "/feed",
  //     dataType: "json",
  //     data: {
  //       max_created_at: this.maxCreatedAt
  //     },
  //     success: function(response) {
  //       this.insertTweets(response);
  //     }.bind(this)
  //   });
  //
  // } else {
  if (this.maxCreatedAt != null) {
    var createdAtData = {max_created_at: this.maxCreatedAt};
  }
  console.log(this.maxCreatedAt);
    $.ajax({
      type: "GET",
      url: "/feed",
      dataType: "json",
      data: createdAtData,
      success: function(response) {
        this.insertTweets(response);
      }.bind(this)
    });

  // }


};


$.InfiniteTweets.prototype.insertTweets = function(response) {
  // if less than 20 responses returned, remove the link
  if (response.length < 20) {
    $('a.fetch-more').hide();
    $('.infinite-tweets').append($('<p>').html("No more tweets"));
  }

  var code = this.$script.html();
  var templateFn = _.template(code);
  var compliedTemplate = templateFn({tweets: response});
  this.$el.find('ul#feed').append(compliedTemplate);


  // record new max_created_at here
  this.maxCreatedAt = response[response.length-1].created_at;
  console.log(this.maxCreatedAt);




};
$.fn.infiniteTweets = function() {
  this.each(function() {
    new $.InfiniteTweets(this);
  });
};


$(function() {
  $('.infinite-tweets').infiniteTweets();
});
