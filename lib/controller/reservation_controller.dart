import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypet_reservation/domain/time.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/extension.dart';

class ReservationController extends GetxController {
  static ReservationController get to => Get.find();
  RxBool possible = true.obs;
  RxBool impossible = false.obs;
  RxBool pick = false.obs;
  RxList<Time> sampleAm = <Time>[].obs;
  RxList<Time> samplePm = <Time>[].obs;
  RxString date = ''.obs;
  RxString pickTime = ''.obs;
  RxBool visible = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    sampleAm(sampleAM);
    samplePm(samplePM);
    today();
    super.onInit();
  }

  void dropdownToggle() {
    visible.value = !visible.value;
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
        pickTime(sampleAm[index].time);
        if (!sampleAm[index].pick) pickTime('');
      }
    }
    if (type == TIMETYPE.PM) {
      if (samplePm[index].possible) {
        samplePm[index].pick = !(samplePm[index].pick);
        samplePm[index] = Time.clone(samplePm[index]);
        pickTime(samplePm[index].time);
        if (!samplePm[index].pick) pickTime('');
      }
    }
  }

  void today() {
    var todayDate = DateTime.now();
    String dayMonth = DateFormat('MM.dd').format(todayDate);
    String weekend = DateFormat('EEEE').format(todayDate);
    String? wholeDate = dayMonth + weekend.weekendTr()!;
    date(wholeDate);
  }

  void datePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2022, 1, 1),
    ).then((pickedDate) {
      pickedDate ??= DateTime.now();
      String dayMonth = DateFormat('MM.dd').format(pickedDate);
      String weekend = DateFormat('EEEE').format(pickedDate);
      String? wholeDate = dayMonth + weekend.weekendTr()!;
      date(wholeDate);
    });
  }
}
