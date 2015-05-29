$.Thumbnail = function(el) {
  this.$el = $(el);
  this.$gutterImages =  $('.gutter-images');
  this.$activeImage = $('.gutter-images img:first-child');
  this.activate(this.$activeImage);

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
}

$.fn.thumbnail = function () {
  return this.each(function () {
    new $.Thumbnail(this);
  });
};
