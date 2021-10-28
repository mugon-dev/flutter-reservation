import 'package:get/get.dart';

class ReservationProvider extends GetConnect {
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

  Future<Response> getTimeTable() => get('url');
}
