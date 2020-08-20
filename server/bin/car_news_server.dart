import 'dart:async';

import 'package:firebase/firebase_io.dart';

import 'package:car_news_entities/car_news_entities.dart';
import 'package:car_news_scraper/car_news_scraper.dart';
import 'package:car_news_server/car_news_server.dart';

Future<void> main(List<String> args) async {
  final String collection = args.isEmpty ? 'car-news' : 'test';

  final Map<CarNewsWebsite, Uri> websiteByNewsUri = <CarNewsWebsite, Uri>{
    CarNewsWebsite.anfavea: Uri.parse('http://www.anfavea.com.br/imprensa'),
    CarNewsWebsite.automotiveBusiness:
        Uri.parse('http://www.automotivebusiness.com.br/noticias'),
    CarNewsWebsite.sindipecas:
        Uri.parse('https://www.sindipecas.org.br/noticias/listar.php'),
    CarNewsWebsite.uol: Uri.parse('https://www.uol.com.br/carros/'),
    CarNewsWebsite.ihs: Uri.parse('https://news.ihsmarkit.com/'
        'INFO/press_releases_iframe?template=ihsmarkit'),
    CarNewsWebsite.afac: Uri.parse('http://afac.org.ar/paginas/listar_noticias.php?id=2'),
    CarNewsWebsite.autoblog:
        Uri.parse('https://autoblog.com.ar/category/mercado-automotor/'),
  };

  final Map<CarNewsWebsite, CarNews> websiteByCarNews =
      <CarNewsWebsite, CarNews>{};
  websiteByNewsUri.forEach(
      (CarNewsWebsite website, Uri uri) => websiteByCarNews[website] = null);

  /// Don't have the timer cycle be too short (<= ~5s), otherwise the cycles 
  /// may collide and weird behavior may arise. Around 10s seems to be a good
  /// minimum.
  Timer.periodic(const Duration(minutes: 5), (Timer timer) async {
    await Future.forEach(websiteByNewsUri.entries, (MapEntry entry) async {
      try {
        final CarNewsWebsite website = entry.key;
        final Uri url = entry.value;

        final CarNewsClient carNewsClient = CarNewsClient(url: url);
        await carNewsClient.getUrl();

        final Parser parser = ParserFactory.getParser(
          website: website,
          input: carNewsClient.decodedResponse,
        );

        final CarNews carNews = CarNews(
          dateTime: parser.latestNewsDateTime,
          title: parser.latestNewsTitle,
          link: parser.latestNewsLink,
        );

        if (parsedNewsIsDifferentFromCachedNews(
            carNews, websiteByCarNews[website])) {
          await postCarNews(carNews, collection);
        }

        websiteByCarNews[website] = carNews;
      } catch (e) {
        print(e);
      }
    });
  });
}

bool parsedNewsIsDifferentFromCachedNews(CarNews parsed, CarNews cached) =>
    parsed != cached;

Future<void> postCarNews(CarNews carNews,
    [String collection = 'car-news']) async {
  const String credential = 'qokLYGGVFyX0vVK75qFVkN9OU7BAuDCeYpmaAIYI';
  final FirebaseClient firebaseClient = FirebaseClient(credential);

  const String projectPath = 'https://car-news-monitor.firebaseio.com';
  final String collectionRef = '/${collection}.json';
  final String auth = '?auth=$credential';
  final String completeUrl = projectPath + collectionRef + auth;

  await firebaseClient.post(completeUrl, carNews.toMap());
}
