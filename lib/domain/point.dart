enum POINTTYPE { PURCHASE, BOUNS, RESERVATION }

class Point {
  final String date;
  final POINTTYPE pointType;
  final String address;
  final String usePoint;

  Point(
      {required this.date,
      required this.pointType,
      required this.address,
      required this.usePoint});
}

List<Point> samplePoint = [
  Point(
    date: '9.15',
    pointType: POINTTYPE.RESERVATION,
    address: '더건강한펫케어',
    usePoint: '1',
  ),
  Point(
    date: '9.12',
    pointType: POINTTYPE.RESERVATION,
    address: '러브펫',
    usePoint: '1',
  ),
  Point(
    date: '9.12',
    pointType: POINTTYPE.BOUNS,
    address: '',
    usePoint: '1',
  ),
  Point(
    date: '9.12',
    pointType: POINTTYPE.RESERVATION,
    address: '놀이터',
    usePoint: '1',
  ),
  Point(
    date: '9.7',
    pointType: POINTTYPE.PURCHASE,
    address: '스튜디오펫',
    usePoint: '-1',
  ),
  Point(
    date: '9.15',
    pointType: POINTTYPE.RESERVATION,
    address: '더건강한펫케어',
    usePoint: '1',
  ),
  Point(
    date: '8.24',
    pointType: POINTTYPE.PURCHASE,
    address: '더건강한펫케어',
    usePoint: '1',
  ),
];
