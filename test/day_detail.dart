class DayDetail {
  final String openTime;
  final String lunchTime;
  final String dinnerTime;

  DayDetail(
      {required this.openTime,
      required this.lunchTime,
      required this.dinnerTime});

  Map<String, dynamic> toJson() => {
        'openTime': openTime,
        'lunchTime': lunchTime,
        'dinnerTime': dinnerTime,
      };
  DayDetail.fromJson(Map<String, dynamic> json)
      : openTime = json['openTime'],
        lunchTime = json['lunchTime'],
        dinnerTime = json['dinnerTime'];
}
