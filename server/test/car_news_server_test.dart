import 'dart:io';

import 'package:test/test.dart';
import 'package:mock_web_server/mock_web_server.dart';
import 'package:path/path.dart' as p;

import 'package:car_news_server/car_news_server.dart';
import 'package:path_utils/path_utils.dart';

void main() {
  final String projectPrefix = PathUtils.projectPrefix();
  final String pathToDomain = p.join(
    projectPrefix,
    'fanaroEngineering',
    'packages',
    'domain',
  );
  final String pathToTheseTests = p.join(
    pathToDomain,
    'servers',
    'car_news_server',
    'test',
  );

  PathUtils.temporarilyResetCurrentDir(pathToTheseTests);

  String extractFixtureHtml(String fileName) {
    final pathToFixtures = p.join(
      pathToDomain,
      'scrapers',
      'car_news_scraper',
      'test',
      'fixtures',
    );
    final File file = File(p.join(pathToFixtures, fileName));
    return file.readAsStringSync();
  }

  group('Car News Server', () {
    final String anfavea = extractFixtureHtml('anfavea.html');
    final MockWebServer mockWebServer = MockWebServer(port: 8080);

    Future<void> setUpServer() async {
      final Dispatcher dispatcher = (HttpRequest req) async => MockResponse()
        ..httpCode = 200
        ..body = anfavea;
      mockWebServer.dispatcher = dispatcher;
      await mockWebServer.start();
    }

    setUpAll(() async => await setUpServer());

    test(
        'Makes a request to the mocked server and receives '
        'the Anfavea HTML page', () async {
      final CarNewsClient carNewsClient =
          CarNewsClient(url: Uri.parse('http://localhost:8080'));

      await carNewsClient.getUrl();

      expect(carNewsClient.statusCode, 200);
      expect(carNewsClient.decodedResponse, anfavea);
    });
  });
}
