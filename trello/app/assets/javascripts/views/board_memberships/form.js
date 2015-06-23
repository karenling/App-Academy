TrelloClone.Views.BoardMembershipsForm = Backbone.View.extend({
  template: JST['board_memberships/form'],

  events: {
    "click .submit-board-member": "addBoardMember"
  },

  addBoardMember: function(event) {
    model = this.model;
    event.preventDefault();
    var attrs = this.$el.find('form').serializeJSON();
    var boardMembership = new TrelloClone.Models.BoardMembership();

    boardMembership.save(attrs, {
      success: function() {
        console.log("it worked!");
        this.$el.hide();
        $('.list-form-closed').show();
      }.bind(this),
      error: function(models, response) {
        console.log(response.responseText);
        model.trigger('close-add-member-form');
      }
    });
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  }
});
