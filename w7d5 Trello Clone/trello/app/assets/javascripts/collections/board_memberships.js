TrelloClone.Collections.BoardMembershps = Backbone.Collection.extend({
  url: '/api/board_memberships',
  model: TrelloClone.Models.BoardMembership
});
