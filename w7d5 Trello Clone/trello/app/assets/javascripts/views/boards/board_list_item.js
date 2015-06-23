TrelloClone.Views.BoardListItem = Backbone.CompositeView.extend({
  template: JST['lists/list_item'],
  className: 'list-item',

  initialize: function() {

    this.listenTo(this.model, "sync", this.render);
    this.listenTo(this.model.cards(), "add", this.hideForm);
    this.listenTo(this.model.cards(), "add", this.addCardView);
    this.model.cards().comparator = "ord";
    this.model.cards().each(this.addCardView.bind(this));
    this.addCardForm(this.model);
  },

  events: {
    "click .delete": "deleteList",
    "click .show-button": "showForm",
    "click .hide-button": "hideForm",
    "drop": "drop",
    "updateSortCards": "updateSortCards"

  },

  updateSortCards: function(event, model, position, newListId) {
    var originalListID = model.get("list_id")


    var originalList = this.collection.get(originalListID);

    originalList.cards().remove(model);

    originalList.cards().each(function (model, index) {
      model.set('ord', index);
      model.save();
    });

    var newList = this.collection.get(newListId);

    newList.cards().each(function (model, index) {
      var ordinal = index;
      if (index >= position) {
        ordinal += 1;
      }
      model.set('ord', ordinal);
      model.save();
    });

    // model.set("description", " is something");
    model.set("list_id", newListId);
    model.set('ord', position);
    model.save();

    newList.cards().add(model, { silent: true });

    // debugger;

    // originalL
    //
    // this.model.cards().remove(model);
    // this.model.cards().each(function (model, index) {
    //   if (index >= position) {
    //     model.set('ord', index + 1);
    //     model.save;
    //   }
    // })
    //
    // model.set('ord', position);
    // model.save();
    //
    // this.model.cards().add(model, { silent: true });
  },

  drop: function(event, index) { // we take the passed in ul index
     this.$el.trigger('update-sort', [this.model, index]);
    //  debugger;
 },

  hideForm: function() {
    this.$el.find('#card-description').attr("placeholder", "");
    this.$el.find('.hide-button').hide();
    this.$el.find('.card-form').hide();
    this.$el.find('.show-button').show();
  },

  showForm: function() {
    this.$el.find('.show-button').hide();
    this.$el.find('.card-form').show();
    this.$el.find('.hide-button').show();
  },

  addCardForm: function(list) {
    var subview = new TrelloClone.Views.CardForm({ model: list, collection: this.model.cards() });
    this.addSubview('.card-form', subview);
  },


  addCardView: function(card) {

    var subview = new TrelloClone.Views.Card({ model: card});
    this.addSubview('.cards', subview);
  },

  render: function() {

    var content = this.template({ listItem: this.model });
    this.$el.html(content);
    this.attachSubviews();
    return this;
  },


  deleteList: function(event) {
    this.model.destroy();
    this.remove();
  }

});
