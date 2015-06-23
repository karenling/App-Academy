TrelloClone.Views.NewList = Backbone.View.extend({
  template: JST['lists/new_list'],
  className: "new-list",

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    "submit form": "submitForm",
  },

  render: function() {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  submitForm: function(event) {
    event.preventDefault();
    var attrs = $(event.currentTarget).serializeJSON();
    var newList = new TrelloClone.Models.List();

    newList.save(attrs, {
      success: function() {
        this.model.lists().add(newList);
      }.bind(this),
      error: function(models, response) {
        $('.errors').html(response.responseJSON[0]);
      }
    });
  },


});
