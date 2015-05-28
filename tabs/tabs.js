$.Tabs = function (el) {
  this.$el = $(el);
  $('.tab-pane').first().addClass('active');
  this.$contentTabs = $(this.$el.data("content-tabs")); //#content-tabs
  this.$activeTab = this.$contentTabs.find('.active');
  this.$el.on('click', 'a', this.clickTab.bind(this));
};

$.Tabs.prototype.clickTab = function (event) {
  event.preventDefault();
  this.$activeTab.removeClass('active');
  var $targeta = $(event.currentTarget);
  var currentHref = $targeta.attr('href'); // id
  this.$activeTab = $(currentHref).addClass('active');
}

$.fn.tabs = function () {
  return this.each(function () {
    new $.Tabs(this);
  });
};
