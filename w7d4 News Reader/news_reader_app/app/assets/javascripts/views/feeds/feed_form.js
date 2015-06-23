NewsReader.Views.FeedsForm = Backbone.View.extend({

  template: JST['feeds/form'],

  events: {
    "submit form": "submitForm"
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    var attributes = $(event.currentTarget).serializeJSON();
    var newFeed = new NewsReader.Models.Feed();
    newFeed.save(attributes, {
      success: function () {
        this.collection.add(newFeed);
      }.bind(this)
    })
  }

});
