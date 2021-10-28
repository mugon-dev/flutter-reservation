class Time {
  final String time;
  final bool possible;
  late bool pick;

  Time({required this.time, this.possible = true, this.pick = false});
  Time.clone(Time cloneTime)
      : this(
            time: cloneTime.time,
            possible: cloneTime.possible,
            pick: cloneTime.pick);
}

List<Time> sampleAM = [
  Time(time: "09:00"),
  Time(time: "09:30", possible: false),
  Time(time: "10:00", possible: false),
  Time(time: "10:30"),
  Time(time: "11:00", possible: false),
  Time(time: "11:30"),
];
List<Time> samplePM = [
  Time(time: "12:00"),
  Time(time: "12:30"),
  Time(time: "01:00", possible: false),
  Time(time: "01:30"),
  Time(time: "02:00"),
  Time(time: "02:30"),
  Time(time: "03:00"),
  Time(time: "03:30", possible: false),
  Time(time: "04:00"),
  Time(time: "04:30"),
  Time(time: "05:00"),
  Time(time: "05:30"),
];
