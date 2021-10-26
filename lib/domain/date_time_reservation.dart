import 'package:mypet_reservation/domain/time.dart';

class DateTimeReservation {
  final String date;
  final List<Time> amTime;
  final List<Time> pmTime;

  DateTimeReservation(
      {required this.date, required this.amTime, required this.pmTime});
}

List<DateTimeReservation> sampleDateTime = [
  DateTimeReservation(
    date: "10.24(일)",
    amTime: [
      Time(time: "09:00"),
      Time(time: "09:30", possible: false),
      Time(time: "10:00", possible: false),
      Time(time: "10:30"),
      Time(time: "11:00", possible: false),
      Time(time: "11:30"),
    ],
    pmTime: [
      Time(time: "12:00"),
      Time(time: "12:30"),
      Time(time: "01:00", possible: false),
      Time(time: "01:30"),
      Time(time: "02:00"),
      Time(time: "02:30"),
      Time(time: "03:00"),
      Time(time: "03:30", possible: false),
      Time(time: "04:00"),
      Time(time: "04:30"),
      Time(time: "05:00"),
      Time(time: "05:30"),
    ],
  ),
  DateTimeReservation(
    date: "10.25(월)",
    amTime: [
      Time(time: "09:00"),
      Time(time: "09:30", possible: false),
      Time(time: "10:00", possible: false),
      Time(time: "10:30"),
      Time(time: "11:00", possible: false),
      Time(time: "11:30"),
    ],
    pmTime: [
      Time(time: "12:00"),
      Time(time: "12:30"),
      Time(time: "01:00", possible: false),
      Time(time: "01:30"),
      Time(time: "02:00", possible: false),
      Time(time: "02:30"),
      Time(time: "03:00"),
      Time(time: "03:30", possible: false),
      Time(time: "04:00"),
      Time(time: "04:30"),
      Time(time: "05:00", possible: false),
      Time(time: "05:30"),
    ],
  ),
  DateTimeReservation(
    date: "10.26(화)",
    amTime: [
      Time(time: "09:00"),
      Time(time: "09:30"),
      Time(time: "10:00"),
      Time(time: "10:30"),
      Time(time: "11:00", possible: false),
      Time(time: "11:30"),
    ],
    pmTime: [
      Time(time: "12:00"),
      Time(time: "12:30"),
      Time(time: "01:00", possible: false),
      Time(time: "01:30"),
      Time(time: "02:00", possible: false),
      Time(time: "02:30"),
      Time(time: "03:00"),
      Time(time: "03:30"),
      Time(time: "04:00"),
      Time(time: "04:30"),
      Time(time: "05:00", possible: false),
      Time(time: "05:30"),
    ],
  )
];
