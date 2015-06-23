TrelloClone.Views.BoardsShow = Backbone.CompositeView.extend({
  template: JST['boards/boards_show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
    // this.listenTo(this.model.lists(), "sync", this.render);
    this.listenTo(this.model.lists(), "add", this.addListItemView);
    this.model.lists().each(this.addListItemView.bind(this));
  },

  events: {
    'click .board-delete-button': "deleteBoard",
    'click .list-form-closed': "listFormOpen",
    'click .close-list-form': 'listFormClose',
    'update-sort': "updateSort",
    "click .add-member-closed": "openAddMemberForm",
    "click .close-member-form": "closeAddMemberForm",
  },


  openAddMemberForm: function() {
    $('.add-member-opened').show();
    $('.add-member-closed').hide();
  },
  closeAddMemberForm: function() {
    $('.add-member-opened').hide();
    $('.add-member-closed').show();

  },
  updateSort: function(event, model, position) {
    this.model.lists().remove(model); // remove the moved model from the collection
    this.model.lists().each(function (model, index) { // iterate through the changed collection
        var ordinal = index;
        if (index >= position) { // if we find a model in the changed collection that has an index greater than the ul index. this way we don't update anything that isn't changed.
          ordinal += 1;
        }
        model.set('ord', ordinal); // we will update his ord to be one more than before
        model.save();
    });

    model.set('ord', position); // now we can set the moved model's position
    model.save();
    this.model.lists().add(model, { silent: true }); // add it back to the collection
    this.model.lists().sort();

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

    event.preventDefault();
    var deleteView = new TrelloClone.Views.DeleteModal({ model: this.model });
    $('body').append(deleteView.render().$el);
    return this;
  },


  addListItemView: function(list) {

    var subview = new TrelloClone.Views.BoardListItem({ collection: this.model.lists(), model: list });
    this.addSubview('.board-list-items', subview);
  },

  render: function() {
    // this.model.lists().comparator = "ord";
    var content = this.template({
      board: this.model
    });

    this.$el.html(content);
    this.attachSubviews();

    var newListView = new TrelloClone.Views.NewList({ model: this.model });

    $('.list-form-opened').html(newListView.render().$el);
    $('.list-form-closed').html("Add a list...");
    this.listFormClose();
    // this.listFormOpen();

    var membershipForm = new TrelloClone.Views.BoardMembershipsForm({ model: this.model });
    $('.add-member-opened').html(membershipForm.render().$el);
    $('.add-member-closed').show();
    $('.add-member-opened').hide();

    return this;
  }
});
