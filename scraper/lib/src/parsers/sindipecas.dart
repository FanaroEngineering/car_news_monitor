import 'package:html/dom.dart';
import 'package:meta/meta.dart';

import '../parser_interface.dart';

@immutable
class SindipecasParser extends Parser {
  Uri get baseLink => Uri.parse('https://www.sindipecas.org.br/');

  SindipecasParser(String input) : super(input);

  Element get _latestNews => document.querySelector('a.news-item');
  Element get _latestNewsDate => _latestNews.querySelector('span.date');

  DateTime get latestNewsDateTime {
    final List<String> splitDate = _latestNewsDate.text.split('/');
    final int day = int.parse(splitDate[0]),
        month = int.parse(splitDate[1]),
        year = int.parse(splitDate[2]);

    return DateTime(year, month, day);
  }

  String get latestNewsLink => prependIfNotFullLink(
      link: _latestNews.attributes['href'], baseLink: baseLink.toString() + 'noticias/');
  String get latestNewsTitle => _latestNews.querySelector('strong').text;
}
