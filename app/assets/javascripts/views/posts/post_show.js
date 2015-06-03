Journal.Views.PostShow = Backbone.View.extend({
  template: JST['posts/show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render);
  },

  events: {
    'dblclick span': 'createForm',
    'click button': 'delete'
  },

  render: function() {
    var content = this.template({ post: this.model });
    this.$el.html(content);
    return this;
  },

  createForm: function(event) {
    var $field = $(event.currentTarget);

    var $form = $(JST['posts/post_form']({
      name: $field.attr("class"),
      value: $field.html()
    }));

    $field.replaceWith($form);

    var that = this;

    $form.on('blur', "input", function(event) {
      event.preventDefault();
      that.updateField($(event.currentTarget));
    });
    $form.on("submit", function(e) {
      e.preventDefault();
    })
  },

  updateField: function($form) {
    var attr = $form.serializeJSON();
    $form.remove();
    this.model.save(attr, {
      error: this.displayError.bind(this)
    });
    this.render();
  },

  displayError: function(model, response, attrs) {
    var error = JSON.parse(response.responseText);
    this.render();
    $("div.errors").html(error);
  },

  delete: function (event) {
    event.preventDefault();
    this.model.destroy();
    this.remove();
    Backbone.history.navigate("#", { trigger: true });
  }
});
