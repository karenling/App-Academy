TrelloClone.Views.BoardsShow = Backbone.CompositeView.extend({
  template: JST['boards/boards_show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.lists(), "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.addListItemView);
    this.model.lists().each(this.addListItemView.bind(this));
  },

  events: {
    'update-sort': "updateSort",
    'click .board-delete-button': "deleteBoard",
    'click .list-form-closed': "listFormOpen",
    'click .close-list-form': 'listFormClose'
  },


  updateSort: function(event, model, position) {
    // model.set('ord', position);
    // model.save();


    /// keep these
      //  this.model.lists().remove(model);
      //  this.model.lists().each(function (model, index) {
      //      var ordinal = index;
      //      if (index >= position) {
      //          ordinal += 1;
      //      }
      //      model.set('ord', ordinal);
      //      model.save();
      //  });
       //
      //  model.set('ord', position);
      //  model.save();
      //  this.model.lists().add(model);
    // keep1!


    //  this.model.lists().fetch();

    //  // to update ordinals on server:
    //  var ids = this.model.lists().pluck('id');
    //  $('#post-data').html('post ids to server: ' + ids.join(', '));
    //
    //  this.render();
   },

  listFormOpen: function (event) {
    $('.list-form-opened').show();
    $('.list-form-closed').hide();
  },

  listFormClose: function (event) {
    $('.list-form-opened').hide();
    $('.list-form-closed').show();
  },

  deleteBoard: function (event) {
    this.remove();
    this.model.destroy({
      success: function() {

        Backbone.history.navigate("#boards", { trigger: true });
      }
    });
  },


  addListItemView: function(list) {

    var subview = new TrelloClone.Views.BoardListItem({ model: list });
    this.addSubview('.board-list-items', subview);
  },

  render: function() {
    this.model.lists().comparator = "ord";
    var content = this.template({
      board: this.model
    });

    this.$el.html(content);
    this.attachSubviews();

    var newListView = new TrelloClone.Views.NewList({ model: this.model });

    $('.list-form-opened').html(newListView.render().$el);
    $('.list-form-closed').html("Add a list...");
    // this.listFormClose();
    this.listFormOpen();

    return this;
  }
});
