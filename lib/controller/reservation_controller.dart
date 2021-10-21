import 'package:flutter/cupertino.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:mypet_reservation/domain/time.dart';
import 'package:mypet_reservation/util/enum.dart';

class ReservationController extends GetxController {
  static ReservationController get to => Get.find();
  RxBool possible = true.obs;
  RxBool impossible = false.obs;
  RxBool pick = false.obs;
  RxList<Time> sampleAm = <Time>[].obs;
  RxList<Time> samplePm = <Time>[].obs;
  RxString date = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    sampleAm(sampleAM);
    samplePm(samplePM);
    super.onInit();
  }

  void pickItem(int index, TIMETYPE type) {
    if (!sampleAm[index].possible || !samplePm[index].possible) {
      Get.defaultDialog(title: '예약불가능', middleText: '예약 불가능한 시간입니다.');
    }
    pickValidation(index, type);
    int count = sampleAm.where((c) => c.pick == true).toList().length +
        samplePm.where((c) => c.pick == true).toList().length;
    if (count >= 2) {
      Get.defaultDialog(title: '중복선택', middleText: '하나만 선택가능합니다.');
      pickValidation(index, type);
    }
  }

  void pickValidation(int index, TIMETYPE type) {
    if (type == TIMETYPE.AM) {
      if (sampleAm[index].possible) {
        sampleAm[index].pick = !(sampleAm[index].pick);
        sampleAm[index] = Time.clone(sampleAm[index]);
      }
    }
    if (type == TIMETYPE.PM) {
      if (samplePm[index].possible) {
        samplePm[index].pick = !(samplePm[index].pick);
        samplePm[index] = Time.clone(samplePm[index]);
      }
    }
  }

  void today() {}

  void datePicker(BuildContext context) {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        minTime: DateTime.now().subtract(const Duration(days: 30)),
        maxTime: DateTime.now().add(const Duration(days: 30)),
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
      Get.defaultDialog(title: 'test', middleText: '$date');
    }, currentTime: DateTime.now(), locale: LocaleType.ko);
  }
}
