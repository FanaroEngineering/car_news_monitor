import 'dart:io';

import 'package:test/test.dart';
import 'package:path/path.dart' as p;

import 'package:car_news_scraper/car_news_scraper.dart';
import 'package:path_utils/path_utils.dart';

void main() {
  final String projectPrefix = PathUtils.projectPrefix();
  final String pathToTheseTests = p.join(
    projectPrefix,
    'fanaroEngineering',
    'packages',
    'domain',
    'scrapers',
    'car_news_scraper',
    'test',
  );

  PathUtils.temporarilyResetCurrentDir(pathToTheseTests);

  String extractFixtureHtml(String fileName) {
    final File file = File(p.join(pathToTheseTests, 'fixtures', fileName));
    return file.readAsStringSync();
  }

  group('Anfavea Parsing |', () {
    final String anfavea = extractFixtureHtml('anfavea.html');
    final Parser anfaveaParser = ParserFactory.getParser(
        website: CarNewsWebsite.anfavea, input: anfavea);

    test('Obtains the most recent news\' datetime', () {
      expect(anfaveaParser.latestNewsDateTime, DateTime(2020, 6, 5));
    });

    test('Obtains the most recent news\' link', () {
      expect(
          anfaveaParser.latestNewsLink,
          'http://www.anfavea.com.br/docs/'
          'release_afavea_aponta_cenario_recuo40.pdf');
    });

    test('Obtains the most recent news\' title', () {
      expect(
          anfaveaParser.latestNewsTitle,
          ' ANFAVEA aponta cenário que prevê recuo de 40% nas '
          'vendas de autoveículos novos em 2020');
    });
  });

  group('Automotive Business Parsing |', () {
    final String automotiveBusiness =
        extractFixtureHtml('automotive_business_noticias.html');
    final Parser automotiveBusinessParser = ParserFactory.getParser(
        website: CarNewsWebsite.automotiveBusiness, input: automotiveBusiness);

    test('Obtains the most recent news\' datetime', () {
      final DateTime latestNewsDateTime =
          automotiveBusinessParser.latestNewsDateTime;

      expect(latestNewsDateTime, DateTime(2020, 6, 18, 21, 0));
    });

    test('Obtains the most recent news\' link', () {
      final String link = automotiveBusinessParser.latestNewsLink;

      expect(
          link,
          'http://www.automotivebusiness.com.br/noticia/31279/'
          'agronegocio-suaviza-mas-nao-detem-queda-na-venda-de-pesados');
    });

    test('Obtains the most recent news\' title', () {
      final String title = automotiveBusinessParser.latestNewsTitle;

      expect(
          title, 'Agronegócio suaviza mas não detém queda na venda de pesados');
    });
  });

  group('Sindipecas Parsing |', () {
    final String sindipecas = extractFixtureHtml('sindipecas.html');
    final Parser sindipecasParser = ParserFactory.getParser(
        website: CarNewsWebsite.sindipecas, input: sindipecas);

    test('Obtains the most recent news\' datetime', () {
      expect(sindipecasParser.latestNewsDateTime, DateTime(2020, 7, 6));
    });

    test('Obtains the most recent news\' link', () {
      expect(
          sindipecasParser.latestNewsLink,
          'https://www.sindipecas.org.br/noticias/'
          'detalhes.php?a=institucional&cod=476');
    });

    test('Obtains the most recent news\' title', () {
      expect(sindipecasParser.latestNewsTitle, 'Autopeças contra a covid-19');
    });
  });

  group('UOL Parsing |', () {
    final String uol = extractFixtureHtml('uol.html');
    final Parser uolParser =
        ParserFactory.getParser(website: CarNewsWebsite.uol, input: uol);

    test('Obtains the most recent news\' datetime', () {
      final DateTime now = DateTime.now();
      expect(
          uolParser.latestNewsDateTime, DateTime(now.year, now.month, now.day));
    });

    test('Obtains the most recent news\' link', () {
      expect(
          uolParser.latestNewsLink,
          'https://www.uol.com.br/carros/avaliacao/'
          'nova-fiat-strada-ganha-motor-agil'
          '-cabine-dupla-decente-e-mais-conteudo.htm');
    });

    test('Obtains the most recent news\' title', () {
      expect(
          uolParser.latestNewsTitle,
          'Fiat Strada Freedom tem motor ágil, '
          'cabine dupla decente e mais conteúdo ');
    });
  });

  group('IHS Parsing |', () {
    final String ihs = extractFixtureHtml('ihs.html');
    final Parser ihsParser =
        ParserFactory.getParser(website: CarNewsWebsite.ihs, input: ihs);

    test('Obtains the most recent news\' datetime', () {
      expect(ihsParser.latestNewsDateTime, DateTime(2020, 06, 30));
    });

    test('Obtains the most recent news\' link', () {
      expect(
          ihsParser.latestNewsLink,
          'https://news.ihsmarkit.com/prviewer/release_only/slug/'
          'bizwire-2020-6-30-saudi-aramco-ceo-amin-h-nasser-says-the-'
          'worst-is-behind-us-in-oil-markets-why-he-is-optimistic-about-the-'
          'second-half-of-2020-his-thoughts-on-becoming-a-publicly-traded-'
          'company-and-saudi-aramcos-long-term-role-in-the-energy-transition');
    });

    test('Obtains the most recent news\' title', () {
      expect(
          ihsParser.latestNewsTitle,
          'Saudi Aramco CEO Amin H. Nasser Says the “Worst is Behind Us” in '
          'Oil Markets; Why He is “Optimistic” About the Second Half of 2020; '
          'His Thoughts on Becoming a Publicly Traded Company and Saudi '
          'Aramco’s Long-Term Role in the Energy Transition');
    });
  });

  group('Afac Parsing |', () {
    final String adefa = extractFixtureHtml('afac.html');
    final Parser afacParser =
        ParserFactory.getParser(website: CarNewsWebsite.afac, input: adefa);

    test('Obtains the most recent news\' datetime', () {
      expect(afacParser.latestNewsDateTime, DateTime(2020, 6, 25));
    });

    test('Obtains the most recent news\' link', () {
      expect(afacParser.latestNewsLink,
          'http://afac.org.ar/paginas/noticia.php?id=4094');
    });

    test('Obtains the most recent news\' title', () {
      expect(
          afacParser.latestNewsTitle,
          'SEGUNDA EVALUACIÓN DEL IMPACTO DEL AISLAMIENTO OBLIGATORIO SOBRE EL '
          'SECTOR AUTOPARTISTA');
    });
  });

  group('Autoblog Parsing |', () {
    final String autoblog = extractFixtureHtml('autoblog.html');
    final Parser autoblogParser = ParserFactory.getParser(
        website: CarNewsWebsite.autoblog, input: autoblog);

    test('Obtains the most recent news\' datetime', () {
      expect(autoblogParser.latestNewsDateTime, DateTime(2020, 7, 1));
    });

    test('Obtains the most recent news\' link', () {
      expect(
          autoblogParser.latestNewsLink,
          'https://autoblog.com.ar/2020/07/01/los-slow-sellers-del-primer-'
          'semestre-de-2020/');
    });

    test('Obtains the most recent news\' title', () {
      expect(autoblogParser.latestNewsTitle,
          'Los Slow-Sellers del primer semestre de 2020');
    });
  });
}
