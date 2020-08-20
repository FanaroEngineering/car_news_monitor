import 'package:html/dom.dart';
import 'package:meta/meta.dart';

import '../parser_interface.dart';

@immutable
class AnfaveaParser extends Parser {
  AnfaveaParser(String input) : super(input);

  Uri get baseLink => Uri.parse('http://www.anfavea.com.br/imprensa');

  Element get _latestNews => document.querySelectorAll('div.colelem > p')[1];
  Element get _latestDate => _latestNews.querySelector('span.Data---noticias');
  Element get _latestNewsCompleteLink => _latestDate.parent;

  DateTime get latestNewsDateTime {
    try {
      final List<String> splitDate = _latestDate.text.split('.');
      final int day = int.parse(splitDate[0]),
          month = int.parse(splitDate[1]),
          year = int.parse(splitDate[2]) + 2000;
      return DateTime(year, month, day);
    } catch (_) {
      final DateTime now = DateTime.now();
      return DateTime(now.year, now.month, now.day);
    }
  }

  String get latestNewsLink => _latestNewsCompleteLink.attributes['href'];
  String get latestNewsTitle =>
      _latestNewsCompleteLink.querySelector('span.Estilo-de-caractere').text;
}
