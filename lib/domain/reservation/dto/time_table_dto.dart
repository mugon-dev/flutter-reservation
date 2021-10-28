import '../time_table.dart';

class TimeTableDto {
  final int weekday;
  final List<TimeTable> timetable;

  TimeTableDto({required this.weekday, required this.timetable});
  Map<String, dynamic> toJson() => {
        'weekday': weekday,
        'timetable': timetable.map((e) => e.toJson()).toList(),
      };
}
