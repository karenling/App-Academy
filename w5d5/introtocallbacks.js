function Clock () {
   this.currentTime = new Date();
}

Clock.TICK = 5000;

Clock.prototype.printTime = function () {
  var hours = this.currentTime.getHours();
  var minutes = this.currentTime.getMinutes();
  var seconds = this.currentTime.getSeconds();

  console.log(hours+":"+minutes+":"+seconds);
};

Clock.prototype.run = function () {

  this.printTime();
  this._tick();

  setInterval(this._tick.bind(this), Clock.TICK);
};

Clock.prototype._tick = function () {
  // 1. Increment the .
  // 2. Call printTime.
  this.currentTime.setSeconds(this.currentTime.getSeconds() + Clock.TICK/1000);
  this.printTime();
};

var clock = new Clock();
clock.run();
