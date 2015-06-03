Journal.Collections.Posts = Backbone.Collection.extend({
  url: '/posts',
  model: Journal.Models.Post,

  getOrFetch: function (id) {
    var that = this;
    var post = that.get(id);
    if (post) {
      post.fetch();
    } else {
      post = new Journal.Models.Post({ id: id });
      post.fetch({
        success: function() {
          that.add(post);
        }
      });
    }
    return post;
  }


});
