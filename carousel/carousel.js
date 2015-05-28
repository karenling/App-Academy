$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  $('.items').first().addClass('active');

  $('.slide-left').on("click", this.slide.bind(this, -1));
  $('.slide-right').on("click", this.slide.bind(this, 1));
};

$.Carousel.prototype.slide = function (dir) {
  $('.items').eq(this.activeIdx).removeClass('active');
  this.activeIdx += dir;
  $('.items').eq(this.activeIdx).addClass('active');
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
