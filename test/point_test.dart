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
    String date = sample[0].date;
    date = date.replaceAll(".", "-");
    date = "2021-0" + date;
    print("date: $date");
    DateTime dt = DateTime.parse(date);
    print("dt: $dt");
    DateTime dateTime = DateTime.parse('2021-09-15');
    DateTime dateTime2 = DateTime.parse('2021-09-16');
    //if() print("true");
    print(dateTime2.compareTo(dateTime));

    String trans(String date) {
      date = date.replaceAll(".", "-");
      List splitData = date.split("-");
      late String month;
      late String day;
      if (splitData[0].toString().length == 1) {
        month = "0" + splitData[0].toString();
      } else {
        month = splitData[0].toString();
      }
      if (splitData[1].toString().length == 1) {
        day = "0" + splitData[1].toString();
      } else {
        day = splitData[1].toString();
      }
      date = "2021-" + month + day;
      return date;
    }

    print("trans : ${trans('9.5').compareTo(trans('9.16'))}");
    // print(PointDto(
    //         date: DateTime.parse(trans(sample[0].date)),
    //         pointUsage: sample[0].pointUsage)
    //     .toJson());
    print('-----------');
    List<PointDto> dtoSample = [];
    // 비교용 dto list
    for (var element in sample) {
      dtoSample.add(PointDto(
          date: DateTime.parse(trans(element.date)),
          pointUsage: element.pointUsage));
    }
    dtoSample.sort((a, b) => a.date.compareTo(b.date));
    dtoSample.forEach((element) {
      print('-----------');
      print(element.toJson());
      print('-----------');
    });
  });

  test("date 정렬", () {
    sampleDate.forEach((element) {
      print(element.toJson());
    });
    sampleDate.sort((a, b) => b.date.compareTo(a.date));
    print("---------------");
    sampleDate.forEach((element) {
      print(element.toJson());
    });
  });
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

class DateDto {
  final DateTime date;
  DateDto({required this.date});
  Map<String, dynamic> toJson() => {
        'date': date.toString(),
      };
}

List<DateDto> sampleDate = [
  DateDto(date: DateTime.parse('2021-09-15')),
  DateDto(date: DateTime.parse('2021-09-05')),
  DateDto(date: DateTime.parse('2021-09-25')),
  DateDto(date: DateTime.parse('2021-09-10')),
  DateDto(date: DateTime.parse('2021-09-17')),
  DateDto(date: DateTime.parse('2021-09-21')),
  DateDto(date: DateTime.parse('2021-09-08')),
];
