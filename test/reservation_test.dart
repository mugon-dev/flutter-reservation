import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

void main() {
  test("시간대 슬라이싱", () {
    String wholeTime = '11:00-17:00';
    List sliceTime = wholeTime.split('-');
    print(sliceTime[0] + "|" + sliceTime[1]);
    var foreword =
        DateFormat.Hm().parse(sliceTime[0]); // 1970-01-01 11:00:00.000
    var backward = DateFormat.Hm().parse(sliceTime[1]);
    print('------');
    print(backward.difference(foreword).inHours);
    print(foreword.add(const Duration(minutes: 30)));
    print('------');
    print(DateFormat.Hm().format(foreword.add(Duration(minutes: 30))));
    print('------');

    String lunchTime = "13:00-14:00";
    String dinnerTime = "17:00-18:00";
    var timeTable = <TimeTable>[];
    for (var i = 0; i <= backward.difference(foreword).inHours * 2; i++) {
      timeTable.add(
        TimeTable(
          time: DateFormat.Hm().format(foreword.add(Duration(minutes: 30 * i))),
          isAm: DateFormat.jm()
              .format(foreword.add(Duration(minutes: 30 * i)))
              .contains('AM'),
        ),
      );
    }
    timeTable.forEach((element) {
      print(element.time + "|" + element.isAm.toString());
    });
  });
  test("정리", () {
    String wholeTime = '11:00-20:00';
    String lunchTime = "13:00-14:00";
    String dinnerTime = "17:00-18:00";
    List getSliceTime(String time) {
      return time.split('-');
      // 1970-01-01 11:00:00.000
    }

    DateTime getDateTimeTr(List slice, int index) {
      return DateFormat.Hm().parse(slice[index]);
    }

    var openForeword = getDateTimeTr(getSliceTime(wholeTime), 0);
    var openbackward = getDateTimeTr(getSliceTime(wholeTime), 1);
    // 시간대와 오전 오후 표시
    var timeTable = <TimeTable>[];
    for (var i = 0;
        i <= openbackward.difference(openForeword).inHours * 2;
        i++) {
      timeTable.add(
        TimeTable(
          time: DateFormat.Hm()
              .format(openForeword.add(Duration(minutes: 30 * i))),
          isAm: DateFormat.jm()
              .format(openForeword.add(Duration(minutes: 30 * i)))
              .contains('AM'),
        ),
      );
    }

    // 점심 시간 표시
    var lunchTable = <TimeTable>[];
    var lunchForeword = getDateTimeTr(getSliceTime(lunchTime), 0);
    var lunchbackward = getDateTimeTr(getSliceTime(lunchTime), 1);
    for (var i = 0;
        i <= lunchbackward.difference(lunchForeword).inHours * 2;
        i++) {
      lunchTable.add(
        TimeTable(
          time: DateFormat.Hm()
              .format(lunchForeword.add(Duration(minutes: 30 * i))),
        ),
      );
    }

    // 저녁시간 표시
    var dinnerTable = <TimeTable>[];
    var dinnerForeword = getDateTimeTr(getSliceTime(dinnerTime), 0);
    var dinnerbackward = getDateTimeTr(getSliceTime(dinnerTime), 1);
    for (var i = 0;
        i <= dinnerbackward.difference(dinnerForeword).inHours * 2;
        i++) {
      dinnerTable.add(
        TimeTable(
          time: DateFormat.Hm()
              .format(dinnerForeword.add(Duration(minutes: 30 * i))),
        ),
      );
    }
    print('time|isAm|islunch|isDinner');
    for (var element in timeTable) {
      for (var lunch in lunchTable) {
        if (element.time.contains(lunch.time)) {
          element.isLunch = true;
        }
      }
      for (var dinner in dinnerTable) {
        if (element.time.contains(dinner.time)) {
          element.isDinner = true;
        }
      }
      print(element.time +
          '|' +
          element.isAm.toString() +
          '|' +
          element.isLunch.toString() +
          '|' +
          element.isDinner.toString());
    }
  });
  test("주차 구하기", () {
    // 10월의 4주차 화요일
    // 2021-10-26
    // Current date and time of system
    String date = DateTime.now().toString();

// This will generate the time and date for first day of month
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    print(firstDay); // 10월 1일

    DateTime now12 = new DateTime.now();
    DateTime lastDayOfMonth2 = new DateTime(now12.year, now12.month + 1, 0);
    print("${lastDayOfMonth2.month}/${lastDayOfMonth2.day}"); // 10월 31일
    final date2 = DateTime.parse(firstDay);
    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
    print('Date: $date2');
    print(
        'Start of week: ${getDate(date2.subtract(Duration(days: date2.weekday - 1)))}');
    print(
        'End of week: ${getDate(date2.add(Duration(days: DateTime.daysPerWeek - date2.weekday)))}');

    // 첫째날부터 마지막 날까지 몇주차 있는지 구하기

// week day for the first day of the month
    int weekDay = DateTime.parse(firstDay).weekday;
    print(weekDay);

    DateTime testDate = DateTime.now();

    int weekOfMonth;

//  If your calender starts from Monday
    weekDay--;
    weekOfMonth = ((testDate.day + weekDay) / 7).ceil();
    print('Week of the month: $weekOfMonth');

    DateTime now = new DateTime.now();
    DateTime lastDayOfMonth = new DateTime(now.year, now.month + 1, 0);
    print("${lastDayOfMonth.month}/${lastDayOfMonth.day}");
  });
  test("특정주차특정요일쉬기", () {
    String weekNum = "4";
    String week = '화';
    String date = "11.25";
    String getYearMonthFirst(String date) {
      List split = date.split('.');
      return '2021-' + split[0] + '-01';
    }

    String yearMonthFirst = getYearMonthFirst(date);
    DateTime firstDate = DateTime.parse(yearMonthFirst);
    print(firstDate);
    DateTime lastDate = new DateTime(firstDate.year, firstDate.month + 1, 0);
    print("${lastDate.month}/${lastDate.day}"); // 10월 31일

    DateTime lasteMonthLastday = firstDate.subtract(Duration(days: 30));
    DateTime lastDayOfMonth =
        new DateTime(lasteMonthLastday.year, lasteMonthLastday.month + 1, 0);
    print(lastDayOfMonth);

    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);

    print('Date: $firstDate');
    print(
        'Start of week: ${getDate(firstDate.subtract(Duration(days: firstDate.weekday - 1)))}');
    print(
        'End of week: ${getDate(firstDate.add(Duration(days: DateTime.daysPerWeek - firstDate.weekday)))}');

    // 그 달의 마지막 날이 포함된 주의 월요일
    DateTime endOfWeek = getDate(
        lastDayOfMonth.subtract(Duration(days: lastDayOfMonth.weekday - 1)));
    print("endOfWeekMonth: $endOfWeek");
    // 월요일에서 3일 더했을때 다음달이 되지 않으면 포함 ㄴㄴ
    print("endOfWeekMonth+3: ${endOfWeek.add(Duration(days: 3))}");
    DateTime endOfWeekMonthThursday = endOfWeek.add(Duration(days: 3));
    print(
        "firstDate.isBefore(endOfWeekMonthThursday): $firstDate : $endOfWeekMonthThursday : ${firstDate.isBefore(endOfWeekMonthThursday)}");

    List weekList = [];
    DateTime startOfWeek;
    for (var i = 1; i <= lastDate.difference(firstDate).inDays; i++) {
      startOfWeek = getDate(firstDate.add(Duration(days: i)).subtract(
          Duration(days: firstDate.add(Duration(days: i)).weekday - 1)));
      if (!weekList.contains(startOfWeek)) {
        weekList.add(startOfWeek);
      }
    }
    print("---- result -----");
    weekList.forEach((element) {
      print(element);
    });
    print('---유효성 확인 첫번째 주----');
    DateTime test = weekList[0];
    if (test.isBefore(endOfWeekMonthThursday)) {
      weekList.removeAt(0);
    }
    weekList.forEach((element) {
      print(element);
    });
    print('---유효성 확인 마지막 주----');
    DateTime test2 = weekList.last;
    test2 = test2.add(Duration(days: 3));
    if (lastDate.isBefore(test2)) {
      weekList.removeLast();
    }
    weekList.forEach((element) {
      print(element);
    });
  });

  test("특정주차요일정리", () {
    String date = "10.25";
    String getYearMonthFirst(String date) {
      List split = date.split('.');
      if (split[0].toString().length == 1) {
        return '2021-0' + split[0] + '-01';
      }
      return '2021-' + split[0] + '-01';
    }

    // 해당 달의 1일
    String yearMonthFirst = getYearMonthFirst(date);
    DateTime firstDate = DateTime.parse(yearMonthFirst); // DateTime 형변환
    print("해당 달의 1일: $firstDate");
    // 해당 달의 마지막일
    DateTime lastDate = DateTime(firstDate.year, firstDate.month + 1, 0);
    print("해당 달의 마지막일: $lastDate");
    // 저번 달 마지막일
    DateTime lastMonthDate = DateTime(firstDate.year, firstDate.month, 0);
    print('저번 달 마지막일: $lastMonthDate');
    // 다음 달 1일
    DateTime nextMonthDate = DateTime(firstDate.year, firstDate.month + 1, 1);
    print('다음 달 1일: $nextMonthDate');
    // 해당 달이 총 몇일
    int monthDayNum = lastDate.difference(firstDate).inDays + 1;
    print('해당 달이 총 몇일: $monthDayNum');
    List weekList = [];
    DateTime startOfWeek;
    DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
    for (var i = 1; i < monthDayNum; i++) {
      startOfWeek = getDate(firstDate.add(Duration(days: i)).subtract(
          Duration(days: firstDate.add(Duration(days: i)).weekday - 1)));
      if (!weekList.contains(startOfWeek)) {
        weekList.add(startOfWeek);
      }
    }
    print("---- 해당 달의 매주 월요일 -----");
    weekList.forEach((element) {
      print(element);
    });
    // 첫번째 주 유효성 검사
    // 저번 달의 마지막 주의 월요일
    DateTime lastMonthEndOfWeek = getDate(
        lastMonthDate.subtract(Duration(days: lastMonthDate.weekday - 1)));
    print('저번 달의 마지막 날이 포함된 주의 월요일: $lastMonthEndOfWeek');
    // weekList에 전달 마지막 월요일이 포함되어 있을때
    if (weekList.contains(lastMonthEndOfWeek)) {
      // 전달의 마지막 주의 목요일
      DateTime endOfWeekMonthThursday =
          lastMonthEndOfWeek.add(Duration(days: 3));
      print('전달의 마지막 주의 목요일: $endOfWeekMonthThursday');
      // 전달의 마지막 주 목요일이 이번달 1일 이전라면 제거
      if (endOfWeekMonthThursday.isBefore(firstDate)) {
        weekList.removeAt(0);
      }
    }
    print("---- 첫번째 주의 유효성 검사 -----");
    weekList.forEach((element) {
      print(element);
    });
    // 마지막 주 유효성 검사
    // 다음달 첫번째 주의 월요일
    DateTime nextMonthEndOfWeek = getDate(
        nextMonthDate.subtract(Duration(days: nextMonthDate.weekday - 1)));
    print('다음 달의 첫 날이 포함된 주의 월요일: $nextMonthEndOfWeek');
    // 다음 달의 첫 날이 포함된 주의 월요일이 있으면
    if (weekList.contains(nextMonthEndOfWeek)) {
      // 이번 달 마지막 주 월요일에 3일 더함
      DateTime lastWeek = weekList.last;
      lastWeek = lastWeek.add(Duration(days: 3));
      //  이번 달말일이  마지막 주 목요일 전이라면 제거
      if (lastDate.isBefore(lastWeek)) {
        weekList.removeLast();
      }
    }
    print("---- 마지막 주의 유효성 검사 -----");
    weekList.forEach((element) {
      print(element);
    });
    //
    print("----몇 주차에 쉬는지 특정 짓기----");
    // 몇 주차에 쉬는지 특정 짓기
    List weekNum = [];
    String week = '화';
    String holiday = "1,end";
    List holidayList = holiday.split(',');
    for (var holidays in holidayList) {
      if (holidays.toString() == 'end') {
        weekNum.add(weekList.length);
      } else {
        weekNum.add(int.parse(holidays.toString()));
      }
    }
    // 중복 제거
    weekNum = weekNum.toSet().toList();
    weekNum.forEach((element) {
      print('$element 주차 $week');
    });
    // print('4주차 화요일');
    // // 해당 주차 월요일
    // DateTime objectWeek = weekList[weekNum[0] - 1];
    // print('해당 주차 월요일: $objectWeek');
    // 해당 주차의 해당 요일
    int getWeekDayNum(String week) {
      int weekday = 0;
      if (week == '월') {
        weekday = 0;
      } else if (week == '화') {
        weekday = 1;
      } else if (week == '수') {
        weekday = 2;
      } else if (week == '목') {
        weekday = 3;
      } else if (week == '금') {
        weekday = 4;
      } else if (week == '토') {
        weekday = 5;
      } else if (week == '일') {
        weekday = 6;
      }
      return weekday;
    }

    // DateTime objectDate = objectWeek.add(Duration(days: getWeekDayNum(week)));
    // print('해당 주차의 해당 요일: $objectDate');
    print('여러 주의 쉬는 날 구하기');
    // 여러 주의 쉬는 날 구하기
    for (var element in weekNum) {
      DateTime objectWeek = weekList[element - 1];
      print('$element 주차 월요일: $objectWeek');
      DateTime objectDate = objectWeek.add(Duration(days: getWeekDayNum(week)));
      print('해당 주차의 $week 요일: $objectDate');
    }
  });
  test("실제_테스트용", () {
    List<DateTime> getHoliday(
        {required List weekList,
        required String weekDay,
        required String holiday}) {
      List setHoliday = [];
      List splitHoliday = holiday.split(',');
      for (var holidays in splitHoliday) {
        if (holidays.toString() == 'end') {
          setHoliday.add(weekList.length);
        } else {
          setHoliday.add(int.parse(holidays.toString()));
        }
      }
      setHoliday = setHoliday.toSet().toList();

      int getWeekDayNum(String week) {
        int weekday = 0;
        if (week == '월') {
          weekday = 0;
        } else if (week == '화') {
          weekday = 1;
        } else if (week == '수') {
          weekday = 2;
        } else if (week == '목') {
          weekday = 3;
        } else if (week == '금') {
          weekday = 4;
        } else if (week == '토') {
          weekday = 5;
        } else if (week == '일') {
          weekday = 6;
        }
        return weekday;
      }

      List<DateTime> holidayList = [];
      for (var element in setHoliday) {
        DateTime objectWeek = weekList[element - 1];
        DateTime objectDate =
            objectWeek.add(Duration(days: getWeekDayNum(weekDay)));
        holidayList.add(objectDate);
      }
      return holidayList;
    }

    // 특정 달 매주 월요일을 리스트로 반환
    List weekList({required DateTime dateTime}) {
      String date = dateTime.toString();
      // This will generate the time and date for first day of month
      String firstDay = date.substring(0, 8) + '01' + date.substring(10);
      // 해당 달의 1일
      DateTime firstDate = DateTime.parse(firstDay); // DateTime 형변환
      // 해당 달의 마지막일
      DateTime lastDate = DateTime(firstDate.year, firstDate.month + 1, 0);
      // 저번 달 마지막일
      DateTime lastMonthDate = DateTime(firstDate.year, firstDate.month, 0);
      // 다음 달 1일
      DateTime nextMonthDate = DateTime(firstDate.year, firstDate.month + 1, 1);
      // 해당 달이 총 몇일
      int monthDayNum = lastDate.difference(firstDate).inDays + 1;
      List weekList = [];
      DateTime startOfWeek;
      DateTime getDate(DateTime d) => DateTime(d.year, d.month, d.day);
      for (var i = 1; i < monthDayNum; i++) {
        startOfWeek = getDate(firstDate.add(Duration(days: i)).subtract(
            Duration(days: firstDate.add(Duration(days: i)).weekday - 1)));
        if (!weekList.contains(startOfWeek)) {
          weekList.add(startOfWeek);
        }
      }
      // 첫번째 주 유효성 검사
      // 저번 달의 마지막 주의 월요일
      DateTime lastMonthEndOfWeek = getDate(
          lastMonthDate.subtract(Duration(days: lastMonthDate.weekday - 1)));
      // weekList에 전달 마지막 월요일이 포함되어 있을때
      if (weekList.contains(lastMonthEndOfWeek)) {
        // 전달의 마지막 주의 목요일
        DateTime endOfWeekMonthThursday =
            lastMonthEndOfWeek.add(Duration(days: 3));
        // 전달의 마지막 주 목요일이 이번달 1일 이전라면 제거
        if (endOfWeekMonthThursday.isBefore(firstDate)) {
          weekList.removeAt(0);
        }
      }
      // 마지막 주 유효성 검사
      // 다음달 첫번째 주의 월요일
      DateTime nextMonthEndOfWeek = getDate(
          nextMonthDate.subtract(Duration(days: nextMonthDate.weekday - 1)));
      // 다음 달의 첫 날이 포함된 주의 월요일이 있으면
      if (weekList.contains(nextMonthEndOfWeek)) {
        // 이번 달 마지막 주 월요일에 3일 더함
        DateTime lastWeek = weekList.last;
        lastWeek = lastWeek.add(Duration(days: 3));
        //  이번 달 말일이  마지막 주 목요일 전이라면 제거
        if (lastDate.isBefore(lastWeek)) {
          weekList.removeLast();
        }
      }
      return weekList;
    }

    List<TimeTable> getTimeTableList({
      required String wholeTime,
      required String lunchTime,
      required String dinnerTime,
    }) {
      // wholeTime = '11:00-20:00';
      // lunchTime = "13:00-14:00";
      // dinnerTime = "17:00-18:00";
      List getSliceTime(String time) {
        if (time != '') {
          return time.split('-');
        }
        return [];
      }

      DateTime getDateTimeTr(List slice, int index) {
        return DateFormat.Hm().parse(slice[index]);
      }

      var openForeword = getDateTimeTr(getSliceTime(wholeTime), 0);
      var openbackward = getDateTimeTr(getSliceTime(wholeTime), 1);
      // 시간대와 오전 오후 표시
      var timeTable = <TimeTable>[];
      for (var i = 0;
          i <= openbackward.difference(openForeword).inHours * 2;
          i++) {
        timeTable.add(
          TimeTable(
            time: DateFormat.Hm()
                .format(openForeword.add(Duration(minutes: 30 * i))),
            isAm: DateFormat.jm()
                .format(openForeword.add(Duration(minutes: 30 * i)))
                .contains('AM'),
          ),
        );
      }

      // 점심 시간 표시
      var lunchTable = <TimeTable>[];
      var lunchTimeList = getSliceTime(lunchTime);
      if (lunchTimeList.isNotEmpty) {
        var lunchForeword = getDateTimeTr(getSliceTime(lunchTime), 0);
        var lunchbackward = getDateTimeTr(getSliceTime(lunchTime), 1);
        for (var i = 0;
            i <= lunchbackward.difference(lunchForeword).inHours * 2;
            i++) {
          lunchTable.add(
            TimeTable(
              time: DateFormat.Hm()
                  .format(lunchForeword.add(Duration(minutes: 30 * i))),
            ),
          );
        }
      }
      // 저녁시간 표시
      var dinnerTable = <TimeTable>[];
      var dinnerTimeList = getSliceTime(dinnerTime);
      if (dinnerTimeList.isNotEmpty) {
        var dinnerForeword = getDateTimeTr(getSliceTime(dinnerTime), 0);
        var dinnerbackward = getDateTimeTr(getSliceTime(dinnerTime), 1);
        for (var i = 0;
            i <= dinnerbackward.difference(dinnerForeword).inHours * 2;
            i++) {
          dinnerTable.add(
            TimeTable(
              time: DateFormat.Hm()
                  .format(dinnerForeword.add(Duration(minutes: 30 * i))),
            ),
          );
        }
      }
      for (var element in timeTable) {
        for (var lunch in lunchTable) {
          if (element.time.contains(lunch.time)) {
            element.isLunch = true;
          }
        }
        for (var dinner in dinnerTable) {
          if (element.time.contains(dinner.time)) {
            element.isDinner = true;
          }
        }
      }
      return timeTable;
    }

    print("real test");
    List weekListData = weekList(dateTime: DateTime.now());
    List holidayList =
        getHoliday(weekList: weekListData, weekDay: '화', holiday: '1,end');
    for (var element in holidayList) {
      print(element);
    }
    List<TimeTable> timeTableList = getTimeTableList(
        wholeTime: '11:00-20:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '17:00-18:00');
    print('time|isAm|islunch|isDinner');
    for (var element in timeTableList) {
      print(element.time +
          '|' +
          element.isAm.toString() +
          '|' +
          element.isLunch.toString() +
          '|' +
          element.isDinner.toString());
    }
  });
  test("한달단위", () {
    String date = DateTime.now().toString();
    String firstDay = date.substring(0, 8) + '01' + date.substring(10);
    // 해당 달의 1일
    DateTime firstDate = DateTime.parse(firstDay); // DateTime 형변환
    // 해당 달의 마지막일
    DateTime lastDate = DateTime(firstDate.year, firstDate.month + 1, 0);
    // 해당 달이 총 몇일
    int monthDayNum = lastDate.difference(firstDate).inDays + 1;
    List<Calendar> monthDayList = [];
    for (var i = 0; i < monthDayNum; i++) {
      DateTime date = firstDate.add(Duration(days: i));
      monthDayList.add(
        Calendar(
          dateTime: date,
          timeTableList: [],
        ),
      );
    }
  });
}

class Calendar {
  final DateTime dateTime;
  late List<TimeTable> timeTableList;
  Calendar({
    required this.dateTime,
    required this.timeTableList,
  });
}

class TimeTable {
  final String time;
  final bool isAm;
  bool isHoliday;
  bool isLunch;
  bool isDinner;
  // final bool isPossible;
  TimeTable(
      {required this.time,
      this.isAm = false,
      this.isHoliday = false,
      this.isLunch = false,
      this.isDinner = false});
}
