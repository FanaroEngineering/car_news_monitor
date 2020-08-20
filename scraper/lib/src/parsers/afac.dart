import 'package:html/dom.dart';
import 'package:meta/meta.dart';

import '../parser_interface.dart';

@immutable
class AfacParser extends Parser {
  static const String _rootLink = 'http://afac.org.ar/paginas/';

  AfacParser(String input) : super(input);

  Uri get baseLink =>
      Uri.parse('${_rootLink}listar_noticias.php?id=2');

  Element get _latestNewsCompleteLink => document.querySelector('td.padding5x20x5x20 > a');
  Element get _latestNewsCompleteTitle => _latestNewsCompleteLink.querySelector('strong');
  List<String> get _splitTitle => _latestNewsCompleteTitle.text.split(' - ');

  DateTime get latestNewsDateTime {
    final List<String> splitDate = _splitTitle[0].split('-');
    final int day = int.parse(splitDate[0]), month = int.parse(splitDate[1]), year = int.parse(splitDate[2]);
    return DateTime(year, month, day);
  }
  String get latestNewsLink => prependIfNotFullLink(link: _latestNewsCompleteLink.attributes['href'], baseLink: _rootLink);
  String get latestNewsTitle => _splitTitle[1];
}
