TrelloClone.Collections.Lists = Backbone.Collection.extend({
  model: TrelloClone.Models.List,
  url: '/api/lists',

  comparator: 'ord',

  getOrFetch: function(id) {
    var collection = this;

    var list = collection.get(id);

    if (list) {
      list.fetch();
    }
    else {
      list = new TelloClone.Models.BoardList({id: id});
      list.fetch({
        success: function () {
          collection.add(list);
        }
      });
    }

    return list;
  }
});
