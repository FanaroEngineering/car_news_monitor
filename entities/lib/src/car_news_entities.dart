import 'package:quiver/core.dart';

class CarNews {
  final DateTime _dateTime;
  final String _title;
  final Uri _link;

  /// DateTime, if `null`, defaults to `DateTime.now()`.
  CarNews({
    DateTime dateTime,
    String title = '',
    String link = '',
  })  : _dateTime = dateTime ?? DateTime.now(),
        _title = title,
        _link = Uri.parse(link);

  DateTime get dateTime => _dateTime;
  String get title => _title;
  Uri get link => _link;

  String get dateTimeAsString => '${_dateTime.year.toString()}-'
      '${_dateTime.month.toString().padLeft(2, '0')}-'
      '${_dateTime.day.toString().padLeft(2, '0')}'
      '$_timeAsString';

  String get _timeAsString => _timeIsNonexistent
      ? ''
      : ' ${_dateTime.hour.toString().padLeft(2, '0')}:'
          '${dateTime.minute.toString().padLeft(2, '0')}';
  bool get _timeIsNonexistent => _dateTime.hour == 0 && _dateTime.minute == 0;

  String get linkAsString => '${link.toString()}';

  Map<String, Object> toMap() => <String, Object>{
        'dateTime': _dateTime.toUtc().millisecondsSinceEpoch,
        'title': _title,
        'link': _link.toString(),
      };

  factory CarNews.fromMap(Map<String, Object> map) => CarNews(
        dateTime: DateTime.fromMillisecondsSinceEpoch(
          map['dateTime'] as int,
          isUtc: true,
        ),
        title: map['title'] as String,
        link: map['link'] as String,
      );

  @override
  String toString() => '<CarNews>' + toMap().toString();

  @override
  int get hashCode =>
      hash3(_dateTime.hashCode, _title.hashCode, _link.hashCode);

  @override
  bool operator ==(Object otherObject) =>
      otherObject is CarNews &&
      _dateTime == otherObject.dateTime &&
      _title == otherObject.title &&
      _link == otherObject.link;
}
