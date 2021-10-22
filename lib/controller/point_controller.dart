import 'package:get/get.dart';

class PointController extends GetxController {
  static PointController get to => Get.find();
  RxString dropdownValue = '전체내역'.obs;
}
