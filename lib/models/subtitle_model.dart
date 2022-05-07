class Subtitle {
  final String subtitle;
  final Duration start;
  final Duration end;

  Subtitle({
    this.subtitle,
    this.start,
    this.end,
  });

  factory Subtitle.fromString(String startStr, String endStr, String sub) {
    List<String> tmpStartStr = startStr.split(':');
    var hourStart = int.parse(tmpStartStr[0]);
    assert(hourStart is int);
    var minuteStart = int.parse(tmpStartStr[1]);
    assert(minuteStart is int);
    var secondStart = int.parse(tmpStartStr[2].split(',')[0]);
    assert(secondStart is int);

    List<String> tmpEndStr = endStr.split(':');
    var hourEnd = int.parse(tmpEndStr[0]);
    assert(hourEnd is int);
    var minuteEnd = int.parse(tmpEndStr[1]);
    assert(minuteEnd is int);
    var secondEnd = int.parse(tmpEndStr[2].split(',')[0]);
    assert(secondEnd is int);

    return Subtitle(
      subtitle: sub,
      start: Duration(
          hours: hourStart, minutes: minuteStart, seconds: secondStart),
      end: Duration(hours: hourEnd, minutes: minuteEnd, seconds: secondEnd),
    );
  }
}
