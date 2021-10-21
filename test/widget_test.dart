// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';

extension StringExtension on String {
  String? weekendTr() {
    return weekType[this];
  }
}

Map<String, String> weekType = {
  'Monday': '월',
  'Tuesday': '화',
  'Wednesday': '수',
  'Thursday': '목',
  'Friday': '금',
  'Saturday': '토',
  'Sunday': '일',
};
void main() {
  test('description', () {
    var date = DateTime.now();
    print(date);
    String dateFormat = DateFormat('EEEE').format(date);
    print(dateFormat.weekendTr());
    String dateFormat2 = DateFormat('MM.dd').format(date);
    print(dateFormat2);
  });
}
