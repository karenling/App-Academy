TrelloClone.Views.BoardsIndex = Backbone.CompositeView.extend({

  template: JST['boards/index'],

  initialize: function(options) {
    this.listenTo(this.collection, "sync", this.render);
    this.listenTo(this.collection, 'add', this.addBoardItemView);
    this.listenTo(this.collection, 'remove', this.removeBoardItemView);
    this.collection.each(this.addBoardItemView.bind(this));
  },


  events: {
    "click .form-closed": "formOpen",
    "click .form-opened .close-board-form": "formClose"
  },


  formOpen: function (event) {
    $('.form-opened').show();
    $('.form-closed').hide();
  },

  formClose: function (event) {
    $('.form-opened').hide();
    $('.form-closed').show();
  },

  removeBoardItemView: function (board) {
    this.removeModelSubview('.board-items', board);
  },

  addBoardItemView: function(board) {

    var subview = new TrelloClone.Views.BoardsIndexItem({ model: board });
    this.addSubview('.board-items', subview);
  },


  render: function() {
    var boardCollection = this.collection;
    var content = this.template({ boards: boardCollection });
    this.$el.html(content);

    this.attachSubviews();


    var formView = new TrelloClone.Views.BoardForm({ collection: this.collection});
    $('.form-opened').html(formView.render().$el);

    var content = "Create new board...";
    $('.form-closed').html(content);

    this.formClose();

    return this;
  }

});
