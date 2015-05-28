$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.removeTags.bind(this)();
  this.addTags.bind(this)();
  console.log("hi")

  $('.slide-left').on("click", this.slide.bind(this, -1));
  $('.slide-right').on("click", this.slide.bind(this, 1));
};

$.Carousel.prototype.slide = function (dir) {
  this.removeTags.bind(this)();
  this.activeIdx += dir;
  this.addTags.bind(this)();
};

$.Carousel.prototype.wrapIndex = function (num) {
  console.log("wrapping");
  var numItems = $('.items').length;
  if (num > numItems) {
    num -= numItems;
  } else if (num < 0) {
    num += numItems;
  }
  return num;
};

$.Carousel.prototype.removeTags = function() {
  console.log("removing");
  $('.items').eq(this.activeIdx).removeClass('active');
  $('.items').eq(this.wrapIndex(this.activeIdx + 1)).removeClass('active').removeClass('right');
  $('.items').eq(this.wrapIndex(this.activeIdx - 1)).removeClass('active').removeClass('left');
};

$.Carousel.prototype.addTags = function() {
  console.log("adding");

  $('.items').eq(this.activeIdx).addClass('active left');
  // $('.items').eq(this.activeIdx).removeClass('left');
  setTimeout(function() {
    $('.items').eq(this.activeIdx).removeClass('left');
  }.bind(this), 0);
  $('.items').eq(this.wrapIndex(this.activeIdx + 1)).addClass('active right');
  $('.items').eq(this.wrapIndex(this.activeIdx - 1)).addClass('active left');
  //active.Idx -> setTimeout, function removes 'left'
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
