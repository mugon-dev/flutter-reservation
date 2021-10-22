import 'package:mypet_reservation/util/enum.dart';

class Reservation {
  late CARDTYPE cardtype;
  late String hospital;
  late String time;
  late String date;
  late bool visitToggle;

  Reservation({
    required this.hospital,
    required this.date,
    required this.time,
    required this.visitToggle,
    required this.cardtype,
  });
}

List<Reservation> sampleReservation = [
  Reservation(
    cardtype: CARDTYPE.NONE,
    visitToggle: false,
    hospital: '참사랑 동물병원',
    date: '9월 23일(목)',
    time: '오전 11:30',
  ),
  Reservation(
    cardtype: CARDTYPE.BUTTON,
    visitToggle: true,
    hospital: '마이펫협동조합애견동반 리조트',
    date: '9월 23일(목)',
    time: '오전 11:30',
  ),
  Reservation(
    cardtype: CARDTYPE.STAR,
    visitToggle: true,
    hospital: '사랑할개 애견카페',
    date: '9월 23일(목)',
    time: '오전 11:30',
  ),
];
