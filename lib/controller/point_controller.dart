import 'package:get/get.dart';
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
    pointList(samplePoint);
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
                  data.pointType == POINTTYPE.RESERVATION)
              .isNotEmpty) {
            filterList.add(
              Point(
                  date: element.date,
                  pointUsage: element.pointUsage
                      .where((data) =>
                          data.pointType == POINTTYPE.BOUNS ||
                          data.pointType == POINTTYPE.RESERVATION)
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
    for (var element in filterList) {}
    pointFilterList([...filterList]);
  }
}
