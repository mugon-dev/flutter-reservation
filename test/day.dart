import 'day_detail.dart';

class Day {
  final String weekDay;
  final String holiday;
  final DayDetail dayDetail;

  Day({required this.weekDay, required this.holiday, required this.dayDetail});
  Map<String, dynamic> toJson() => {
        'weekDay': weekDay,
        'holiday': holiday,
        'dayDetail': dayDetail.toJson(),
      };
  Day.fromJson(Map<String, dynamic> json)
      : weekDay = json['weekDay'],
        holiday = json['holiday'],
        dayDetail = DayDetail.fromJson(
          json['dayDetail'],
        );
}
