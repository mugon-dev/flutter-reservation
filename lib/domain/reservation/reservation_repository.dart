import 'dart:convert';

import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mypet_reservation/domain/reservation/dto/company_time_schedule.dart';
import 'package:mypet_reservation/domain/reservation/dto/holiday_dto.dart';
import 'package:mypet_reservation/domain/reservation/reservation_provider.dart';
import 'package:xml2json/xml2json.dart';

class ReservationRepository {
  final ReservationProvider _reservationProvider = ReservationProvider();
  Future<List<HolidayDto>> getHolidayData() async {
    final Xml2Json xml2Json = Xml2Json();
    Response response = await _reservationProvider.getData();
    xml2Json.parse(response.body);
    var jsonString = xml2Json.toParker();
    var data = jsonDecode(jsonString);
    data = data["response"]["body"]["items"];
    List<dynamic> temp = data["item"];
    List<HolidayDto> holidays =
        temp.map((e) => HolidayDto.fromJson(e)).toList();
    return holidays;
  }

  Future<List<CompanyTimeSchedule>> getScheduleData() async {
    var data = jsonDecode(jsonTest);
    List<dynamic> temp = data;
    List<CompanyTimeSchedule> companyTimeSchedule =
        temp.map((e) => CompanyTimeSchedule.fromJson(e)).toList();
    print("getScheduleData의 json 파싱");
    companyTimeSchedule.forEach((element) {
      print(element.toJson());
    });
    return companyTimeSchedule;
  }
}

String jsonTest = '''
[
  {
    "company": "회사",
    "weekDay": "월",
    "holiday": "end",
    "detailSchedule": {
      "openTime": "",
      "lunchTime": "",
      "dinnerTime": ""
    }
  },
  {
    "company": "회사",
    "weekDay": "화",
    "holiday": "1,3",
    "detailSchedule": {
      "openTime": "11:00-17:00",
      "lunchTime": "13:00-14:00",
      "dinnerTime": ""
    }
  },
  {
    "company": "회사",
    "weekDay": "수",
    "holiday": "3",
    "detailSchedule": {
      "openTime": "11:00-17:00",
      "lunchTime": "",
      "dinnerTime": ""
    }
  },
  {
    "company": "회사",
    "weekDay": "목",
    "holiday": "1,end",
    "detailSchedule": {
      "openTime": "11:00-17:00",
      "lunchTime": "",
      "dinnerTime": ""
    }
  },
  {
    "company": "회사",
    "weekDay": "금",
    "holiday": "",
    "detailSchedule": {
      "openTime": "11:00-20:00",
      "lunchTime": "",
      "dinnerTime": "17:00-18:00"
    }
  },
  {
    "company": "회사",
    "weekDay": "토",
    "holiday": "",
    "detailSchedule": {
      "openTime": "11:00-17:00",
      "lunchTime": "",
      "dinnerTime": ""
    }
  },
  {
    "company": "회사",
    "weekDay": "일",
    "holiday": "",
    "detailSchedule": {
      "openTime": "",
      "lunchTime": "",
      "dinnerTime": ""
    }
  }
]
''';
