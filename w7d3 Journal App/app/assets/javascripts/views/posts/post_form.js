Journal.Views.PostForm = Backbone.View.extend({
  template: JST['posts/new_form'],

  events: {
    "click button": "submitForm"
  },

  render: function() {
    var content = this.template();
    this.$el.html(content);
    return this;
  },

  submitForm: function (event) {
    event.preventDefault();
    var attrs = this.$('form').serializeJSON();
    var model = new Journal.Models.Post();
    var that = this;
    model.save(attrs, {
      success: function() {
        Backbone.history.navigate("#posts/" + model.id, { trigger: true });
      },
      error: this.displayError.bind(this)
    });
  },

  displayError: function(model, response, attrs) {
    var error = JSON.parse(response.responseText);
    this.render();
    $("div.errors").html(error);
  },
})
