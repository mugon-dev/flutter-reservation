import 'detail_schedule.dart';

class CompanyTimeSchedule {
  final String weekDay;
  final String holiday;
  final DetailSchedule detailSchedule;

  CompanyTimeSchedule(
      {required this.weekDay,
      required this.holiday,
      required this.detailSchedule});
  Map<String, dynamic> toJson() => {
        'weekDay': weekDay,
        'holiday': holiday,
        'dayDetail': detailSchedule.toJson(),
      };
  CompanyTimeSchedule.fromJson(Map<String, dynamic> json)
      : weekDay = json['weekDay'],
        holiday = json['holiday'],
        detailSchedule = DetailSchedule.fromJson(
          json['detailSchedule'],
        );
}
