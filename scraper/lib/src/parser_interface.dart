import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:meta/meta.dart';

import 'parsers/afac.dart';
import 'parsers/anfavea.dart';
import 'parsers/autoblog.dart';
import 'parsers/automotive_business.dart';
import 'parsers/ihs.dart';
import 'parsers/sindipecas.dart';
import 'parsers/uol.dart';

enum CarNewsWebsite {
  anfavea,
  automotiveBusiness,
  sindipecas,
  uol,
  ihs,
  afac,
  autoblog,
}

@immutable
abstract class ParserFactory {
  static Parser getParser({
    @required CarNewsWebsite website,
    @required String input,
  }) {
    switch (website) {
      case CarNewsWebsite.anfavea:
        return AnfaveaParser(input);
      case CarNewsWebsite.automotiveBusiness:
        return AutomotiveBusinessParser(input);
      case CarNewsWebsite.sindipecas:
        return SindipecasParser(input);
      case CarNewsWebsite.uol:
        return UolParser(input);
      case CarNewsWebsite.ihs:
        return IhsParser(input);
      case CarNewsWebsite.afac:
        return AfacParser(input);
      case CarNewsWebsite.autoblog:
        return AutoblogParser(input);
      default:
        throw Exception('No parser implementation for this website.');
    }
  }
}

@immutable
abstract class Parser {
  final Document _document;

  Parser(String input) : _document = parse(input);

  Document get document => _document;
  Uri get baseLink;
  DateTime get latestNewsDateTime;
  String get latestNewsLink;
  String get latestNewsTitle;
}

extension Prepend on Parser {
  String prependIfNotFullLink({
    @required String link,
    @required String baseLink,
  }) {
    final String filteredLink = _nonRelativeLink(link);
    return link.startsWith('http') ? filteredLink : baseLink + filteredLink;
  }

  String _nonRelativeLink(String link) => link.replaceAll('..', '');
}
