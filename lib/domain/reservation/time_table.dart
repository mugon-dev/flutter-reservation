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
