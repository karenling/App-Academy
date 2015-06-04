Journal.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts/post'],
  tagName: "li",
  className: "list-group-item",

  initialize: function () {
      this.listenTo(this.model, "sync change", this.render);
  },

  events: {
    "click button": "delete"
  },

  render: function () {
    var content = this.template({ post: this.model});
    this.$el.html(content);
    return this;
  },

  delete: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
  }
});
