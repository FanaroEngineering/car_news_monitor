import 'package:html/dom.dart';
import 'package:meta/meta.dart';

import '../parser_interface.dart';

@immutable
class UolParser extends Parser {
  UolParser(String input) : super(input);

  Uri get baseLink => Uri.parse('https://www.uol.com.br/carros/');

  Element get _latestSuperNews =>
      document.querySelector('div.destaque-super > div');
  Element get _latestNewsCompleteLink => _latestSuperNews.querySelector('a');
  String get _latestNewsTitle =>
      _latestNewsCompleteLink.querySelector('div > h2').text;

  /// Taking the runtime DateTime will probably be more accurate than the time
  /// the website posts the article actually.
  DateTime get latestNewsDateTime {
    final DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  String get latestNewsLink => _latestNewsCompleteLink.attributes['href'];

  String get latestNewsTitle => _latestNewsTitle.replaceFirst(' ', '');
}
