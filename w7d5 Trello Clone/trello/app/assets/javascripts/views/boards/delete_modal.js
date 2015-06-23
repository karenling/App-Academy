TrelloClone.Views.DeleteModal = Backbone.View.extend({
  template: JST['boards/delete_modal'],

  events: {
    "click .board-delete-confirm": "confirmDeleteBoard",
    "click .board-delete-cancel": "cancelDeleteBoard"
  },

  confirmDeleteBoard: function (event) {
    this.model.destroy({
      success: function () {
        Backbone.history.navigate("#", { trigger: true });
      }
    });
    this.remove();
  },

  cancelDeleteBoard: function (event) {
    this.remove();
  },

  render: function () {
    var content = this.template();
    this.$el.append(content);
    return this;
  }
})
