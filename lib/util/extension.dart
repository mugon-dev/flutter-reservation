extension StringExtension on String {
  String? weekendTr() {
    return weekType[this];
  }
}

Map<String, String> weekType = {
  'Monday': '(월)',
  'Tuesday': '(화)',
  'Wednesday': '(수)',
  'Thursday': '(목)',
  'Friday': '(금)',
  'Saturday': '(토)',
  'Sunday': '(일)',
};
