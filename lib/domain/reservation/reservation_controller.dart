import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mypet_reservation/domain/reservation/dto/time_table_dto.dart';
import 'package:mypet_reservation/domain/reservation/reservation_repository.dart';
import 'package:mypet_reservation/domain/reservation/reservation_utils.dart';
import 'package:mypet_reservation/domain/reservation/time_table.dart';
import 'package:mypet_reservation/util/enum.dart';
import 'package:mypet_reservation/util/extension.dart';

import 'calendar.dart';
import 'dto/company_time_schedule.dart';
import 'dto/holiday_dto.dart';
import 'time.dart';

class ReservationControllerReal extends GetxController {
  static ReservationControllerReal get to => Get.find();
  final ReservationRepository _reservationRepository = ReservationRepository();
  final ReservationUtils _reservationUtils = ReservationUtils();
  RxBool visible = false.obs;
  late final List<CompanyTimeSchedule> companySchedule;
  late List weekList;
  List holidayList = [];
  late String date;
  late String firstDay;
  late DateTime firstDate;
  late DateTime lastDate;
  late int monthDayNum;
  final setWeekTimeTable = <TimeTableDto>[].obs;
  final monthDayList = <Calendar>[].obs;

  // 달력용
  RxList<Time> amList = <Time>[].obs;
  RxList<Time> pmList = <Time>[].obs;
  RxString pickTime = ''.obs;
  RxString calendarDate = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    initData();
    await getHolidayListWeekTimeTable();
    await getMonthData();
    today();
  }

  // 특정 날짜에 맞춰 예약 가능 불가능 리스트 출력
  void setDateTime(String getDate) {
    resetWeekTimeTable();
    List<Time> amList = <Time>[];
    List<Time> pmList = <Time>[];
    // 받아온 날짜로 시간대별 예약 가능 여부 가져오기
    for (var element in monthDayList) {
      if (element.dateTime == getDate) {
        List<TimeTable> temp = element.timeTableList;
        for (var data in temp) {
          if (data.isAm) {
            if (element.isHoliday) {
              amList.add(
                Time(time: data.time, possible: false),
              );
            } else if (data.isDinner || data.isLunch) {
              amList.add(
                Time(time: data.time, possible: false),
              );
            } else {
              amList.add(
                Time(time: data.time, possible: true),
              );
            }
          } else {
            if (element.isHoliday) {
              pmList.add(
                Time(time: data.time, possible: false),
              );
            } else if (data.isDinner || data.isLunch) {
              pmList.add(
                Time(time: data.time, possible: false),
              );
            } else {
              pmList.add(
                Time(time: data.time, possible: true),
              );
            }
          }
        }
      }
    }
    this.amList.value = amList;
    this.pmList.value = pmList;
  }

  void pickItem(int index, TIMETYPE type) {
    pickValidation(index, type);
    var count = amList.where((c) => c.pick == true).toList().length +
        pmList.where((c) => c.pick == true).toList().length;
    if (count >= 2) {
      Get.defaultDialog(title: '중복선택', middleText: '하나만 선택가능합니다.');
      pickValidation(index, type);
      pickTime(getBeforePicked(type));
    }
  }

  String getBeforePicked(TIMETYPE type) {
    if (type == TIMETYPE.AM) {
      return amList.singleWhere((e) => e.pick == true).time;
    }
    if (type == TIMETYPE.PM) {
      return pmList.singleWhere((e) => e.pick == true).time;
    }
    return '';
  }

  void pickValidation(int index, TIMETYPE type) {
    if (type == TIMETYPE.AM) {
      if (amList[index].possible) {
        amList[index].pick = !(amList[index].pick);
        amList[index] = Time.clone(amList[index]);
        pickTime(amList[index].time);
        if (!amList[index].pick) pickTime('');
      }
    }
    if (type == TIMETYPE.PM) {
      if (pmList[index].possible) {
        pmList[index].pick = !(pmList[index].pick);
        pmList[index] = Time.clone(pmList[index]);
        pickTime(pmList[index].time);
        if (!pmList[index].pick) pickTime('');
      }
    }
  }

  void today() {
    var todayDate = DateTime.now();
    var dayMonth = DateFormat('MM.dd').format(todayDate);
    var weekend = DateFormat('EEEE').format(todayDate);
    String? wholeDate = dayMonth + weekend.weekendTr()!;
    calendarDate(wholeDate);
    setDateTime(todayDate.toString().substring(0, 10));
  }

  // 예약 페이지에서 달력 open
  // 특정 날짜 누르면 date에 포맷팅된 날짜 입력
  // 선택한 날짜에 맞는 시간 별 예약 가능 불가능 여부 추가 및 선택 값 초기화
  void datePicker(BuildContext context) {
    if (visible.value) {
      visible.value = !visible.value;
    }
    showDatePicker(
      context: context,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021, 1, 1),
      lastDate: DateTime(2022, 1, 1),
    ).then((pickedDate) {
      pickedDate ??= DateTime.now();
      var dayMonth = DateFormat('MM.dd').format(pickedDate);
      var weekend = DateFormat('EEEE').format(pickedDate);
      String? wholeDate = dayMonth + weekend.weekendTr()!;
      calendarDate(wholeDate);
      // 날짜 변경 시 선택 값 초기화
      setDateTime(pickedDate.toString().substring(0, 10));
      for (var element in amList) {
        element.pick = false;
      }
      for (var element in pmList) {
        element.pick = false;
      }
      pickTime('');
    });
  }

  void initData() {
    date = DateTime.now().toString();
    firstDay = date.substring(0, 8) + '01' + date.substring(10);
    // 해당 달의 1일
    firstDate = DateTime.parse(firstDay); // DateTime 형변환
    // 해당 달의 마지막일
    lastDate = DateTime(firstDate.year, firstDate.month + 1, 0);
    // 해당 달이 총 몇일
    monthDayNum = lastDate.difference(firstDate).inDays + 1;
    // 이번달 매주 월요일 리스트
    weekList = _reservationUtils.weekList(dateTime: DateTime.now());
  }

  Future<void> getMonthData() async {
    List<Calendar> monthDayList = [];
    for (var i = 0; i < monthDayNum; i++) {
      DateTime beforeDate = firstDate.add(Duration(days: i));
      String date = beforeDate.toString().substring(0, 10).trim();
      for (var element in setWeekTimeTable) {
        if (element.weekday == beforeDate.weekday) {
          TimeTableDto temp = element;
          // 쉬는날
          if (holidayList.contains(date)) {
            monthDayList.add(Calendar(
                dateTime: date,
                isHoliday: true,
                timeTableList: temp.timetable));
          } else {
            monthDayList.add(Calendar(
                dateTime: date,
                isHoliday: false,
                timeTableList: temp.timetable));
          }
        }
      }
    }
    this.monthDayList.value = monthDayList;
  }

  void resetWeekTimeTable() {
    List<TimeTableDto> temp = [];
    for (var element in companySchedule) {
      temp.add(TimeTableDto(
          weekday: _reservationUtils.getWeekDayNum(element.weekDay),
          timetable: _reservationUtils.getTimeTableList(
            wholeTime: element.detailSchedule.openTime,
            lunchTime: element.detailSchedule.lunchTime,
            dinnerTime: element.detailSchedule.dinnerTime,
          )));
    }
    setWeekTimeTable.value = temp;
  }

  Future<void> getHolidayListWeekTimeTable() async {
    List<CompanyTimeSchedule> companySchedule =
        await _reservationRepository.getScheduleData();
    List<HolidayDto> holidays = await _reservationRepository.getHolidayData();
    if (companySchedule.isNotEmpty) {
      for (var element in companySchedule) {
        holidayList.add(_reservationUtils.getHoliday(
            weekList: weekList,
            weekDay: element.weekDay,
            holiday: element.holiday));
        setWeekTimeTable.add(TimeTableDto(
            weekday: _reservationUtils.getWeekDayNum(element.weekDay),
            timetable: _reservationUtils.getTimeTableList(
              wholeTime: element.detailSchedule.openTime,
              lunchTime: element.detailSchedule.lunchTime,
              dinnerTime: element.detailSchedule.dinnerTime,
            )));
      }
    }
    // 공휴일
    if (holidays.isNotEmpty) {
      for (var element in holidays) {
        String data = element.locdate.toString();
        data = data.substring(0, 4) +
            "-" +
            data.substring(4, 6) +
            '-' +
            data.substring(6, 8);
        holidayList.add(data);
      }
    }

    this.companySchedule = companySchedule;
  }

  void dropdownToggle() {
    visible.value = !visible.value;
  }
}
