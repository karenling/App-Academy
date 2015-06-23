Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST['posts/index'],

  initialize: function () {
    this.listenTo(this.collection, "reset sync", this.render);
    this.listenTo(this.collection, "add", function (post) { this.addPostItem(post) }.bind(this));
  },

  events: {
    "click button": "submitForm"
  },

  render: function () {
    var that = this;
    var content = this.template();
    this.$el.html(content);
    this.collection.each(this.addPostItem.bind(this));
    var newPostFormView = new Journal.Views.PostForm();
    this.$('.form').html(newPostFormView.render().$el);
    return this;
  },

  addPostItem: function(post) {
    var postView = new Journal.Views.PostsIndexItem({ model: post });
    this.$('ul').append(postView.render().$el);
    this.collection.add(post);
  }
});
