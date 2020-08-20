import 'package:html/dom.dart';
import 'package:intl/intl.dart';

import '../parser_interface.dart';

class IhsParser extends Parser {
  IhsParser(String input) : super(input);

  Uri get baseLink => Uri.parse('https://news.ihsmarkit.com/'
      'INFO/press_releases_iframe?template=ihsmarkit');

  Element get _latestNews => document.querySelector('div.hq-cols-3-span-2');
  Element get _latestNewsCompleteLink => _latestNews.querySelector('span > a');
  String get _latestNewsCompleteDate =>
      _latestNews.querySelector('div.views-field-teaser > div > p').text;

  DateTime get latestNewsDateTime =>
      DateFormat.yMMMMd('en_US').parse(_formatDateTime());
  String get latestNewsLink => _latestNewsCompleteLink.attributes['href'];
  String get latestNewsTitle => _latestNewsCompleteLink.text;

  String _formatDateTime() {
    final String date = _latestNewsCompleteDate
        .replaceAll(' ', '')
        .replaceAll('\n', '')
        .replaceAll('\t', '');
    final List<String> splitDate = date.split(',');
    final String month = splitDate[1],
        day = int.parse(splitDate[2]).toString(),
        year = splitDate[3];
    return '$month $day, $year';
  }
}
