import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypet_reservation/domain/point.dart';

class PointController extends GetxController {
  static PointController get to => Get.find();
  RxString dropdownValue = '전체내역'.obs;
  RxList<Point> pointList = <Point>[].obs;
  RxList<Point> pointFilterList = <Point>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // 전체 포인트 내역
    pointList([...dateTimeConvertDto(samplePoint)]);
    filterPointList(POINTFILTERTYPE.WHOLE);
  }

  void filterPointList(POINTFILTERTYPE pointFilterType) {
    // filter 받아 정렬 후 날짜별 나열
    List<Point> filterList = [];
    switch (pointFilterType) {
      case POINTFILTERTYPE.WHOLE:
        for (var element in pointList) {
          filterList.add(
            Point(
              date: element.date,
              pointUsage: element.pointUsage.toList(),
            ),
          );
        }
        break;
      case POINTFILTERTYPE.SAVE:
        for (var element in pointList) {
          if (element.pointUsage
              .where((data) =>
                  data.pointType == POINTTYPE.BOUNS ||
                  data.pointType == POINTTYPE.RESERVATION ||
                  data.pointType == POINTTYPE.PURCHASE)
              .isNotEmpty) {
            filterList.add(
              Point(
                  date: element.date,
                  pointUsage: element.pointUsage
                      .where((data) =>
                          data.pointType == POINTTYPE.BOUNS ||
                          data.pointType == POINTTYPE.RESERVATION ||
                          data.pointType == POINTTYPE.PURCHASE)
                      .toList()),
            );
          }
        }
        break;
      case POINTFILTERTYPE.USE:
        for (var element in pointList) {
          if (element.pointUsage
              .where((data) => data.pointType == POINTTYPE.USEPOINT)
              .isNotEmpty) {
            filterList.add(
              Point(
                  date: element.date,
                  pointUsage: element.pointUsage
                      .where((data) => data.pointType == POINTTYPE.USEPOINT)
                      .toList()),
            );
          }
        }
        break;
    }
    // 정렬
    pointFilterList([...dateTimeConvertDto(filterList)]);
  }

  // String -> DateTimeFormat
  String stringToDateTimeFormat(String date) {
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

  // 정렬을 위해 날짜를 DateTime으로 변환 후 리스트로 만들고 최근 순으로 sort
  List<Point> dateTimeConvertDto(List<Point> beforeSort) {
    List<PointDto> dtoList = [];
    for (var element in beforeSort) {
      dtoList.add(PointDto(
          date: DateTime.parse(stringToDateTimeFormat(element.date)),
          pointUsage: element.pointUsage));
    }
    dtoList.sort((a, b) => b.date.compareTo(a.date));
    // 다시 날짜를 원하는 포맷으로 변경
    List<Point> sortList = [];
    for (var element in dtoList) {
      sortList.add(Point(
          date: DateFormat('MM.dd').format(element.date),
          pointUsage: element.pointUsage));
    }
    return sortList;
  }
}
