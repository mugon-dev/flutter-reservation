import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xml2json/xml2json.dart';

void main() {
  test("함수테스트", () {
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
      dinnerTime: '17:00-18:00',
    );
    print('time|isAm|islunch|isDinner|isHoliday');
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
  test("한달단위테스트", () async {
    String _weekDay = '화';
    String _holiday = '1,end';
    String _wholetime = '11:00-20:00';
    String _lunchTime = '13:00-14:00';
    String _dinnerTime = '17:00-18:00';
    List weekListData = weekList(dateTime: DateTime.now());
    // 쉬는날 리스트
    List holidayList = getHoliday(
        weekList: weekListData, weekDay: _weekDay, holiday: _holiday);
    // 공휴일 데이터 받아 쉬는날 리스트에 추가
    List<HolidayDto> holidays = await fetchData();
    for (var element in holidays) {
      String data = element.locdate.toString();
      data = data.substring(0, 4) +
          "-" +
          data.substring(4, 6) +
          '-' +
          data.substring(6, 8);
      holidayList.add(data);
    }
    // 쉬는날 리스트
    holidayList.forEach((element) {
      print(element);
    });
    // 7일 데이터 세팅
    Map<int, dynamic> setWeekTimeTable = {
      1: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
      2: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
      3: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
      4: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
      5: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-20:00',
        dinnerTime: '17:00-18:00',
      ),
      6: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
      7: getTimeTableList(
        wholeTime: '11:00-17:00',
        lunchTime: '13:00-14:00',
        dinnerTime: '',
      ),
    };

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
      DateTime beforeDate = firstDate.add(Duration(days: i));
      String date = beforeDate.toString().substring(0, 10).trim();
      // 쉬는날
      if (holidayList.contains(date)) {
        monthDayList.add(Calendar(
            dateTime: date,
            isHoliday: true,
            timeTableList: setWeekTimeTable[beforeDate.weekday]));
      } else {
        monthDayList.add(Calendar(
            dateTime: date,
            isHoliday: false,
            timeTableList: setWeekTimeTable[beforeDate.weekday]));
      }
    }
    for (var element in monthDayList) {
      print(element.toJson());
    }
  });
  test("api", () async {
    final Xml2Json xml2Json = Xml2Json();
    Response response = await ApiConnect().getData();
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();
    var data = jsonDecode(jsonString);
    data = data["response"];
    data = data["body"];
    data = data["items"];
    List<dynamic> temp = data["item"];
    List<HolidayDto> holidays =
        temp.map((e) => HolidayDto.fromJson(e)).toList();
    holidays.forEach((element) {
      print(element.toJson());
    });
  });
}

Future<List<HolidayDto>> fetchData() async {
  final Xml2Json xml2Json = Xml2Json();
  Response response = await ApiConnect().getData();
  xml2Json.parse(response.body);
  var jsonString = xml2Json.toParker();
  var data = jsonDecode(jsonString);
  data = data["response"];
  data = data["body"];
  data = data["items"];
  List<dynamic> temp = data["item"];
  List<HolidayDto> holidays = temp.map((e) => HolidayDto.fromJson(e)).toList();
  return holidays;
}

class ApiConnect extends GetConnect {
  var baseurl =
      'http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getRestDeInfo';
  var serviceKey =
      'WYBetsmvlmXjNt%2FB66rL9qKv0QWs6d6CQ0hl%2FYCx6YK%2B26fmvbTwzqgSwksHgamGBwW640aGxwwJKb%2FZ5KR7zA%3D%3D';
  Future<Response> getData({String year = '2021'}) => get(baseurl +
      '?serviceKey=' +
      serviceKey +
      '&solYear=' +
      year +
      '&numOfRows=50');
}

class HolidayDto {
  final String dateName;
  final String locdate;

  HolidayDto({required this.dateName, required this.locdate});
  HolidayDto.fromJson(Map<String, dynamic> json)
      : dateName = json['dateName'],
        locdate = json['locdate'];
  Map<String, dynamic> toJson() => {
        'dateName': dateName,
        'locdate': locdate,
      };
}

class Calendar {
  final String dateTime;
  bool isHoliday;
  late List<TimeTable> timeTableList;
  Calendar({
    required this.dateTime,
    this.isHoliday = false,
    required this.timeTableList,
  });
  Map<String, dynamic> toJson() => {
        'dateTime': dateTime,
        'isHoliday': isHoliday.toString(),
        'timeTableList': timeTableList.map((e) => e.toJson()).toList(),
      };
}

class TimeTable {
  final String time;
  final bool isAm;
  bool isLunch;
  bool isDinner;
  // final bool isPossible;
  TimeTable(
      {required this.time,
      this.isAm = false,
      this.isLunch = false,
      this.isDinner = false});
  Map<String, dynamic> toJson() => {
        'time': time,
        'isAm': isAm.toString(),
        'isLunch': isLunch.toString(),
        'isDinner': isDinner.toString(),
      };
}

List getHoliday(
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
    DateTime endOfWeekMonthThursday = lastMonthEndOfWeek.add(Duration(days: 3));
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
  for (var i = 0; i <= openbackward.difference(openForeword).inHours * 2; i++) {
    timeTable.add(
      TimeTable(
        time:
            DateFormat.Hm().format(openForeword.add(Duration(minutes: 30 * i))),
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
