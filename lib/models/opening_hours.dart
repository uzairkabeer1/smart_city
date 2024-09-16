class OpeningHours {
  final bool? openNow;
  final List<OpeningHoursPeriod>? periods;
  final String? type;
  final List<String>? weekdayText;

  const OpeningHours({
    this.openNow,
    this.periods,
    this.type,
    this.weekdayText,
  });

  factory OpeningHours.fromJson(Map<String, dynamic> json) {
    return OpeningHours(
      openNow: json['open_now'],
      periods: (json['periods'] as List?)
          ?.map((i) => OpeningHoursPeriod.fromJson(i))
          .toList(),
      type: json['type'],
      weekdayText:
          (json['weekday_text'] as List?)?.map((e) => e as String).toList(),
    );
  }
}

class OpeningHoursPeriodDetail {
  final int day;
  final String time;
  final String? date;
  final bool? truncated;

  const OpeningHoursPeriodDetail({
    required this.day,
    required this.time,
    this.date,
    this.truncated,
  });

  factory OpeningHoursPeriodDetail.fromJson(Map<String, dynamic> json) {
    return OpeningHoursPeriodDetail(
      day: json['day'],
      time: json['time'],
      date: json['date'],
      truncated: json['truncated'],
    );
  }
}

class OpeningHoursPeriod {
  final OpeningHoursPeriodDetail open;
  final OpeningHoursPeriodDetail? close;

  const OpeningHoursPeriod({
    required this.open,
    this.close,
  });

  factory OpeningHoursPeriod.fromJson(Map<String, dynamic> json) {
    return OpeningHoursPeriod(
      open: OpeningHoursPeriodDetail.fromJson(json['open']),
      close: json['close'] != null
          ? OpeningHoursPeriodDetail.fromJson(json['close'])
          : null,
    );
  }
}
