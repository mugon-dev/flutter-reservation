import 'package:mypet_reservation/domain/reservation/time_table.dart';

class Calendar {
  final String dateTime;
  bool isHoliday;
  late List<TimeTable> timeTableList;
  Calendar({
    required this.dateTime,
    this.isHoliday = false,
    required this.timeTableList,
  });
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'isHoliday': isHoliday.toString(),
        'timeTableList': timeTableList.map((e) => e.toJson()).toList(),
      };
}
