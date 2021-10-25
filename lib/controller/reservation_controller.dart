import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypet_reservation/domain/date_time_reservation.dart';
import 'package:mypet_reservation/domain/time.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/extension.dart';

class ReservationController extends GetxController {
  static ReservationController get to => Get.find();
  RxBool possible = true.obs;
  RxBool pick = false.obs;
  RxList<Time> sampleAm = <Time>[].obs;
  RxList<Time> samplePm = <Time>[].obs;
  RxString date = ''.obs;
  RxString pickTime = ''.obs;
  RxBool visible = false.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    today();
    super.onInit();
  }

  // 특정 날짜에 맞춰 예약 가능 불가능 리스트 출력
  setDateAmTime(String getDate) {
    // 받아온 날짜로 시간대별 예약 가능 여부 가져오기
    return sampleDateTime.firstWhere((data) => data.date == getDate).amTime;
  }

  setDatePmTime(String getDate) {
    return sampleDateTime.firstWhere((data) => data.date == getDate).pmTime;
  }

  void dropdownToggle() {
    visible.value = !visible.value;
  }

  void pickItem(int index, TIMETYPE type) {
    pickValidation(index, type);
    int count = sampleAm.where((c) => c.pick == true).toList().length +
        samplePm.where((c) => c.pick == true).toList().length;
    if (count >= 2) {
      Get.defaultDialog(title: '중복선택', middleText: '하나만 선택가능합니다.');
      pickValidation(index, type);
      pickTime(getBeforePicked(type));
    }
  }

  String getBeforePicked(TIMETYPE type) {
    if (type == TIMETYPE.AM) {
      return sampleAm.firstWhere((e) => e.pick == true).time;
    }
    if (type == TIMETYPE.PM) {
      return samplePm.firstWhere((e) => e.pick == true).time;
    }
    return '';
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
    sampleAm([...setDateAmTime(wholeDate)]);
    samplePm([...setDatePmTime(wholeDate)]);
  }

  // 예약 페이지에서 달력 open
  // 특정 날짜 누르면 date에 포맷팅된 날짜 입력
  // 선택한 날짜에 맞는 시간 별 예약 가능 불가능 여부 추가 및 선택 값 초기화
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
      // 날짜 변경 시 선택 값 초기화
      sampleAm([...setDateAmTime(wholeDate)]).forEach((element) {
        element.pick = false;
      });
      samplePm([...setDatePmTime(wholeDate)]).forEach((element) {
        element.pick = false;
      });
      pickTime('');
    });
  }
}
