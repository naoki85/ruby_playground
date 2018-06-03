export default {
  today: function() {
    var today = new Date();
    var year = today.getFullYear();
    var month = today.getMonth() + 1;
    var day = today.getDate();
    var hour = today.getHours();
    var minute = today.getMinutes();
    var second = today.getSeconds();

    month = this.zeroFill(month);
    day = this.zeroFill(day);
    hour = this.zeroFill(hour);
    minute = this.zeroFill(minute);
    second = this.zeroFill(second);

    return year + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
  },
  zeroFill: function(number) {
    if (number < 10) {
      return '0' + number;
    } else {
      return number;
    }
  }
}