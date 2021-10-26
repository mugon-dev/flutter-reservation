enum POINTTYPE { PURCHASE, BOUNS, RESERVATION, USEPOINT }
enum POINTFILTERTYPE { WHOLE, SAVE, USE }

class Point {
  final String date;
  final List<PointUsage> pointUsage;

  Point({required this.date, required this.pointUsage});
  Map<String, dynamic> toJson() => {
        'date': date,
        'pointUsage': pointUsage.map((e) => e.toJson()).toList(),
      };
}

class PointUsage {
  final POINTTYPE pointType;
  final String address;
  final String usePoint;

  PointUsage(
      {required this.pointType, required this.address, required this.usePoint});
  Map<String, dynamic> toJson() => {
        'pointType': pointType.toString(),
        'address': address,
        'usePoint': usePoint,
      };
}

class PointDto {
  final DateTime date;
  final List<PointUsage> pointUsage;

  PointDto({required this.date, required this.pointUsage});
  Map<String, dynamic> toJson() => {
        'date': date.toString(),
        'pointUsage': pointUsage.map((e) => e.toJson()).toList(),
      };
}

List<Point> samplePoint = [
  Point(
    date: '9.15',
    pointUsage: [
      PointUsage(
        pointType: POINTTYPE.RESERVATION,
        address: '더건강한펫케어',
        usePoint: '1',
      ),
      PointUsage(
        pointType: POINTTYPE.RESERVATION,
        address: '러브펫',
        usePoint: '1',
      ),
    ],
  ),
  Point(
    date: '9.12',
    pointUsage: [
      PointUsage(
        pointType: POINTTYPE.BOUNS,
        address: '',
        usePoint: '1',
      ),
      PointUsage(
        pointType: POINTTYPE.RESERVATION,
        address: '놀이터',
        usePoint: '1',
      ),
    ],
  ),
  Point(
    date: '9.7',
    pointUsage: [
      PointUsage(
        pointType: POINTTYPE.USEPOINT,
        address: '스튜디오펫',
        usePoint: '-1',
      ),
    ],
  ),
  Point(
    date: '8.24',
    pointUsage: [
      PointUsage(
        pointType: POINTTYPE.PURCHASE,
        address: '더건강한펫케어',
        usePoint: '1',
      ),
    ],
  ),
];
