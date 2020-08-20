import 'package:html/dom.dart';
import 'package:meta/meta.dart';

import '../parser_interface.dart';

@immutable
class AutomotiveBusinessParser extends Parser {
  AutomotiveBusinessParser(String input) : super(input);

  Uri get baseLink => Uri.parse('http://www.automotivebusiness.com.br');

  Element get _content => document.querySelector('div.conteudo');
  Element get _latestDate => _content.querySelector('dt');
  Element get _latestNews => _content.querySelector('dl > dd');
  Element get _latestNewsTime => _latestNews.querySelector('span');

  @override
  DateTime get latestNewsDateTime =>
      _parsedlatestDate.add(_parsedlatestTime.difference(DateTime(0, 0, 0)));

  DateTime get _parsedlatestDate {
    final String latestDateAsString = _latestDate.text;
    final List<String> splitDate = latestDateAsString.split('/');
    final int day = int.parse(splitDate[0]),
        month = int.parse(splitDate[1]),
        year = int.parse(splitDate[2]);

    return DateTime(year, month, day);
  }

  DateTime get _parsedlatestTime {
    final String latestNewsTimeAsString = _latestNewsTime.text;
    final List<String> splitTime = latestNewsTimeAsString.split('h');
    final int hours = int.parse(splitTime[0]),
        minutes = int.parse(splitTime[1]);

    return DateTime(0, 0, 0, hours, minutes);
  }

  String get latestNewsLink => prependIfNotFullLink(
      link: _latestNewsCompleteLink.attributes['href'],
      baseLink: baseLink.toString());

  String get latestNewsTitle => _latestNewsCompleteLink.attributes['title'];

  Element get _latestNewsCompleteLink => _latestNews.querySelectorAll('a').last;
}
