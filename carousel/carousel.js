$.Carousel = function(el) {
  this.$el = $(el);
  this.activeIdx = 0;
  this.transitioning = false;
  $('.items').eq(this.activeIdx).addClass("active");
  // this.removeTags.bind(this)(0);
  // this.addTags.bind(this)(0);

  $('.slide-left').on("click", this.slide.bind(this, -1));
  $('.slide-right').on("click", this.slide.bind(this, 1));
};

$.Carousel.prototype.slide = function (dir) {
  if (this.transitioning) {
    return;
  }
  this.transitioning = true;
  this.removeTags.bind(this)();
  this.activeIdx += dir;
  this.activeIdx = this.wrapIndex(this.activeIdx);
  this.addTags.bind(this, dir)();
};

$.Carousel.prototype.wrapIndex = function (num) {
  var numItems = $('.items').length;
  if (num > numItems - 1) {
    num -= numItems;
  } else if (num < 0) {
    num += numItems;
  }
  return num;
};

$.Carousel.prototype.removeTags = function(dir) {
  var dirWord = "";
  if (dir === -1) {
    dirWord = "left";
  } else if (dir === 1) {
    dirWord = "right";
  }

  // $('.items').eq(this.activeIdx).removeClass('active');
  // $('.items').eq(this.wrapIndex(this.activeIdx + 1)).removeClass('right');
  // $('.items').eq(this.wrapIndex(this.activeIdx - 1)).removeClass('left');

  var $currentImage = $('.items').eq(this.activeIdx).addClass(dirWord);
  $currentImage.one("transitionend", function() {
    $currentImage.removeClass("active left right");
    this.transitioning = false;
  }.bind(this));

};

$.Carousel.prototype.addTags = function(dir) {

  var dirWord = "";
  if (dir === -1) {
    dirWord = "left";
  } else if (dir === 1) {
    dirWord = "right";
  }

  $('.items').eq(this.activeIdx).addClass('active').addClass(dirWord);
  setTimeout(function() {
    $('.items').eq(this.activeIdx).removeClass(dirWord);
  }.bind(this), 0);
  $('.items').eq(this.wrapIndex(this.activeIdx + 1)).addClass('right');
  $('.items').eq(this.wrapIndex(this.activeIdx - 1)).addClass('left');
  //active.Idx -> setTimeout, function removes 'left'
};

$.fn.carousel = function () {
  return this.each(function () {
    new $.Carousel(this);
  });
};
