import 'package:test/test.dart';

import 'package:car_news_entities/car_news_entities.dart';
import 'package:date_utils/date_utils.dart';

void main() {
  final CarNews carNews = CarNews();

  group('Car News Entity |', () {
    test('Has a datetime, which defaults to now', () {
      expect(carNews.dateTime, isA<DateTime>());
      expect(DateUtils.diffToNowInSeconds(carNews.dateTime), lessThan(10));
    });

    test('Has a title, which defaults to blank', () {
      expect(carNews.title, isA<String>());
      expect(carNews.title, '');
    });

    test('Has a link, which defaults to blank', () {
      expect(carNews.link, isA<Uri>());
      expect(carNews.link, Uri());
    });
  });

  group('Serialization |', () {
    final String title = 'title1', link = 'linky';
    final int now = DateTime.now().toUtc().millisecondsSinceEpoch;
    final CarNews carNewsFromMap = CarNews.fromMap(<String, Object>{
      'dateTime': now,
      'title': title,
      'link': link,
    });

    test('To map', () {
      final Map<String, Object> carNewsAsMap = carNews.toMap();

      expect((carNewsAsMap['dateTime'] as int) - now, lessThan(10));
      expect(carNewsAsMap['title'], '');
      expect(carNewsAsMap['link'], '');
    });

    test('From map', () {
      expect(
          DateUtils.diffToNowInSeconds(carNewsFromMap.dateTime), lessThan(10));
      expect(carNewsFromMap.title, title);
      expect(carNewsFromMap.link, Uri.parse(link));
    });

    test('To String', () {
      expect(carNews.toString(), '<CarNews>' + carNews.toMap().toString());
    });
  });

  group('Different Formats |', () {
    test('Datetime as string', () {
      final CarNews carNews = CarNews(dateTime: DateTime(2020, 1, 1, 12, 0));

      expect(carNews.dateTimeAsString, '2020-01-01 12:00');
    });

    test(
        'Doesn\'t show the time if the link if it is 00:00 '
        '(originally nonexistent)', () {
      final CarNews carNews = CarNews(dateTime: DateTime(2020, 1, 1));

      expect(carNews.dateTimeAsString, '2020-01-01');
    });

    test('Link as String', () {
      final String link = 'http://johndoe.com';
      final CarNews carNews = CarNews(link: link);

      expect(carNews.linkAsString, link);
    });
  });

  group('Equality', () {
    final CarNews carNewsBlank1 = CarNews();
    final CarNews carNewsBlank2 = CarNews();
    final CarNews carNewsDummy = CarNews(
        dateTime: DateTime(2020, 1, 1),
        title: 'title',
        link: 'http://blah.com');

    test('Two different objects, same attributes', () {
      expect(carNewsBlank1, equals(carNewsBlank2));
    });

    test('Two different objects, different attributes', () {
      expect(carNewsBlank1, isNot(equals(carNewsDummy)));
    });
  });
}
