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
