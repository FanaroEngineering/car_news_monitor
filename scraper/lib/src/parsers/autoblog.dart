import 'package:html/dom.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/date_symbols.dart';

import '../parser_interface.dart';

class AutoblogParser extends Parser {
  AutoblogParser(String input) : super(input);

  Uri get baseLink =>
      Uri.parse('https://autoblog.com.ar/category/mercado-automotor/');

  Element get _latestNewsCompleteLink => document.querySelector('h2.post-title > a');

  /// Consult `intl` library for more info, more specifically, the 
  /// [`date_symbol_data_local.dart`](https://github.com/dart-lang/intl/blob/abb648585e8557594a7cb93903bbee9f6a95ff6f/lib/date_symbol_data_local.dart#L5160-L5172) file.
  DateTime get latestNewsDateTime {
    final String dateAsString = document.querySelector('p.post-date').text.replaceAll(',', '');
    final List<String> splitDate =  dateAsString.split(' ');
    final String day = splitDate[0], month = splitDate[1].toLowerCase() + '.', year = splitDate[2];
    final DateSymbols symbolsMap  = dateTimeSymbolMap()['es_ES'];
    final List<String> shortMonths = symbolsMap.SHORTMONTHS;
    final int monthAsInt = shortMonths.indexOf(month) + 1;
    return DateTime(int.parse(year), monthAsInt, int.parse(day));
  }
  String get latestNewsLink => _latestNewsCompleteLink.attributes['href'];
  String get latestNewsTitle => _latestNewsCompleteLink.text;
}
