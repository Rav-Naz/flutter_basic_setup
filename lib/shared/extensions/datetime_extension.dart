import 'package:intl/intl.dart';

extension MyDateUtils on DateTime {
  DateTime copyWith({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
    int? millisecond,
    int? microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }
}

extension DateTimeUTC on DateTime? {
  static DateTime parseUtc(String formattedDate) => DateTime.parse(
        '${formattedDate.trim().replaceAll(" ", "T")}${formattedDate.trim().length > 10 && !formattedDate.trim().contains("Z") ? "Z" : ""}',
      );

  static DateTime? tryParseUtc(String? formattedDate) {
    if (formattedDate != null) {
      return DateTime.tryParse(
          '${formattedDate.trim().replaceAll(" ", "T")}${(formattedDate.trim().length > 10) && !formattedDate.trim().contains("Z") ? "Z" : ""}');
    }
    return null;
  }

  static DateTime parseUtcToLocal(String formattedDate) =>
      DateFormat("yyyy-MM-ddTHH:mm:ss.SSSZ").parse(formattedDate).toLocal();

  static DateTime? tryParseUtcToLocal(String? formattedDate) {
    if (formattedDate != null) {
      return tryParseUtc(formattedDate)?.toLocal();
    }
    return null;
  }

  String? toUTCString({bool isLocal = true}) {
    if (isLocal) {
      return this?.toUtc().toString().replaceAll(" ", "T");
    } else {
      return this?.toUtc().toString().substring(0, 19).replaceAll("Z", "");
    }
  }
}
