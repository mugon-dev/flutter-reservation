import 'package:intl/intl.dart';
import 'package:mypet_reservation/domain/reservation/time_table.dart';

class ReservationUtils {
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

  // 특정 주의 쉬는 요일의 날짜를 리스트에 넣어 반환
  List getHoliday(
      {required List weekList,
      required String weekDay,
      required String holiday}) {
    List setHoliday = [];
    if (holiday != '') {
      List splitHoliday = holiday.split(',');
      for (var holidays in splitHoliday) {
        if (holidays.toString() == 'end') {
          setHoliday.add(weekList.length);
        } else {
          setHoliday.add(int.parse(holidays.toString()));
        }
      }
    }
    setHoliday = setHoliday.toSet().toList();

    List holidayList = [];
    for (var element in setHoliday) {
      DateTime objectWeek = weekList[element - 1];
      DateTime objectDate =
          objectWeek.add(Duration(days: getWeekDayNum(weekDay)));
      holidayList.add(objectDate.toString().substring(0, 10).trim());
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

  // 영업시간, 점심시간, 저녁시간을 받아 영업시간을 30분 단위로 나워 해당하는 시간 표시하여 리스트 반환
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

    // wholeTime = '' 일때 추가
    var timeTable = <TimeTable>[];
    if (wholeTime.isEmpty) {
      wholeTime = '10:00-20:00';
    }
    var openForeword = getDateTimeTr(getSliceTime(wholeTime), 0);
    var openBackward = getDateTimeTr(getSliceTime(wholeTime), 1);
    // 시간대와 오전 오후 표시
    for (var i = 0;
        i <= openBackward.difference(openForeword).inHours * 2;
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
}
