class DayStart {
  num? ticks;
  num? days;
  num? hours;
  num? milliseconds;
  num? minutes;
  num? seconds;
  num? totalDays;
  num? totalHours;
  num? totalMilliseconds;
  num? totalMinutes;
  num? totalSeconds;

  DayStart(
      {this.ticks,
      this.days,
      this.hours,
      this.milliseconds,
      this.minutes,
      this.seconds,
      this.totalDays,
      this.totalHours,
      this.totalMilliseconds,
      this.totalMinutes,
      this.totalSeconds});

  DayStart.fromJson(Map<String, dynamic> json) {
    ticks = num.tryParse(json['ticks'].toString());
    days = num.tryParse(json['days'].toString());
    hours = num.tryParse(json['hours'].toString());
    milliseconds = num.tryParse(json['milliseconds'].toString());
    minutes = num.tryParse(json['minutes'].toString());
    seconds = num.tryParse(json['seconds'].toString());
    totalDays = num.tryParse(json['totalDays'].toString());
    totalHours = num.tryParse(json['totalHours'].toString());
    totalMilliseconds = num.tryParse(json['totalMilliseconds'].toString());
    totalMinutes = num.tryParse(json['totalMinutes'].toString());
    totalSeconds = num.tryParse(json['totalSeconds'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticks'] = this.ticks;
    data['days'] = this.days;
    data['hours'] = this.hours;
    data['milliseconds'] = this.milliseconds;
    data['minutes'] = this.minutes;
    data['seconds'] = this.seconds;
    data['totalDays'] = this.totalDays;
    data['totalHours'] = this.totalHours;
    data['totalMilliseconds'] = this.totalMilliseconds;
    data['totalMinutes'] = this.totalMinutes;
    data['totalSeconds'] = this.totalSeconds;
    return data;
  }
}
