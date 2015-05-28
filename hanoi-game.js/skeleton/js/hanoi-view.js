(function () {
  if (typeof Hanoi === "undefined") {
    window.Hanoi = {};
  }

  var View = Hanoi.View = function(game, $el) {
    this.game = game;
    this.$el = $el;
    this.setupTowers();
    this.render();
    $('.tower').on('click', this.clickTower.bind(this));
  };

  View.prototype.setupTowers = function () {
    for (var i = 0; i < 3; i++) {
      this.$el.append($('<div>').addClass('tower').addClass('tower-' + i).data('num', i));
    }
    $('.tower').append($('<div>').addClass('disc-container'));

    for (var j = 0; j < 3; j++) {
      $('.disc-container').append($('<div>').addClass('disc').addClass('disc-' + (j+1)));
    }
  };

  View.prototype.render = function () {
    $('.disc').addClass('hidden');
    this.game.towers.forEach(function(gameTower, towerIdx) {
      gameTower.forEach(function(gameDisc) {
        $('.tower-' + towerIdx + ' .disc-' + (gameDisc)).removeClass('hidden');
      });
    });
  };

  View.prototype.clickTower = function(event) {
    var $tower = $(event.currentTarget);
    if (this.startTower === undefined) {
      $tower.addClass('selected');
      this.startTower = $tower.data('num');
      return;
    }
    var endTower = $tower.data("num");
    if (this.game.move(this.startTower, endTower)) {
      this.render();
      if (this.game.isWon()) {
        this.endGame();
      }
    } else {
      alert("Invalid move!");
    }
    $('.tower').removeClass('selected');
    this.startTower = undefined;
  };

  View.prototype.endGame = function () {
    $('.tower').off('click').addClass('won');
  };
})();
