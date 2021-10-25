import 'package:flutter_test/flutter_test.dart';
import 'package:mypet_reservation/domain/point.dart';

void main() {
  List<Point> sample = samplePoint;
  test("포인트 filtering", () {
    List<Point> test = [];
    for (var element in sample) {
      test.add(Point(
          date: element.date,
          pointUsage: element.pointUsage
              .where((data) => data.pointType == POINTTYPE.PURCHASE)
              .toList()));
    }
    for (var element in test) {
      print(element.toJson());
    }
  });
  test("날짜 테스트", () {
    DateTime dt = DateTime.parse('2021.09.15');
    print(dt);
  });
}
