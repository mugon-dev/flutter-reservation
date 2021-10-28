class DetailSchedule {
  final String openTime;
  final String lunchTime;
  final String dinnerTime;

  DetailSchedule(
      {required this.openTime,
      required this.lunchTime,
      required this.dinnerTime});

  Map<String, dynamic> toJson() => {
        'openTime': openTime,
        'lunchTime': lunchTime,
        'dinnerTime': dinnerTime,
      };
  DetailSchedule.fromJson(Map<String, dynamic> json)
      : openTime = json['openTime'],
        lunchTime = json['lunchTime'],
        dinnerTime = json['dinnerTime'];
}
