import 'package:firebase/firebase_io.dart';
import 'package:flutter/material.dart';

import 'package:car_news_entities/car_news_entities.dart';

import 'widgets/news_tile.dart';

void main() => runApp(const CarNewsUserUi());

class CarNewsUserUi extends StatelessWidget {
  const CarNewsUserUi();

  Future<Map<String, Object>> _getMostRecentNews({int limit = 10}) async {
    const String projectPath = 'https://car-news-monitor.firebaseio.com';
    const String collection = '/car-news.json';
    final String limitQuery = '?orderBy="dateTime"&limitToLast=$limit';
    final String completeUrl = projectPath + collection + limitQuery;

    final FirebaseClient firebaseClient = FirebaseClient.anonymous();

    return (await firebaseClient.get(completeUrl)) as Map<String, Object>;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Automotive News Monitor',
            style: TextStyle(
              color: Colors.grey.shade600,
            ),
          ),
          backgroundColor: Colors.transparent,
        ),
        body: Container(
          padding: const EdgeInsets.only(
            left: 100,
            right: 100,
            top: 30,
          ),
          child: FutureBuilder<Map<String, Object>>(
            future: _getMostRecentNews(),
            builder:
                (BuildContext _, AsyncSnapshot<Map<String, Object>> snapshot) {
              List<CarNews> carNewsList = <CarNews>[];
              try {
                final Map<String, Object> carNewsMaps = snapshot.data;

                carNewsMaps.forEach((String key, Object carNewsAsMap) =>
                    carNewsList.add(CarNews.fromMap(carNewsAsMap)));
                carNewsList = carNewsList.reversed.toList();
              } catch (_) {
                rethrow;
              } finally {
                return ListView.builder(
                  itemCount: carNewsList.length,
                  itemBuilder: (BuildContext _, int index) =>
                      NewsTile(carNews: carNewsList[index]),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
