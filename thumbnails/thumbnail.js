$.Thumbnail = function(el) {
  this.$el = $(el);
  this.$gutterImages =  $('.gutter-images');
  this.$activeImage = $('.gutter-images img:first-child');
  this.gutterIdx = 0;
  this.activate(this.$activeImage);

  this.$images = $('.gutter-images img');
  this.fillGutterImages();


  //activate on click
  this.$gutterImages.on('click', 'img', function(event) {
    this.$activeImage = $(event.currentTarget);
    this.activate(this.$activeImage);
  }.bind(this));

  //mouseenter
  this.$gutterImages.on('mouseenter', 'img', function(event) {
    this.activate($(event.currentTarget));
  }.bind(this));

  //mouseleave
  this.$gutterImages.on('mouseleave', 'img', function(event) {
    this.activate(this.$activeImage);
  }.bind(this));
};

$.Thumbnail.prototype.activate = function ($img) {
  $('.active img').remove();
  var imageURL = $img.attr("src");
  $('.active').append($('<img>').attr("src", imageURL));
};

$.Thumbnail.prototype.fillGutterImages = function() {
  $('.gutter-images img').remove();
  for (var i = this.gutterIdx; i < this.gutterIdx + 5; i++) {
    var imageURL = this.$images.eq(i).attr("src");
    $('.gutter-images').append($('<img>').attr("src", imageURL));
  }
};

$.fn.thumbnail = function () {
  return this.each(function () {
    new $.Thumbnail(this);
  });
};
