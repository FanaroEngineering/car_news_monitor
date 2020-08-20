import 'dart:html' as html;

import 'package:flutter/material.dart';

import 'package:car_news_entities/car_news_entities.dart';

class NewsTile extends StatelessWidget {
  final CarNews _carNews;

  const NewsTile({
    Key key,
    @required CarNews carNews,
  })  : _carNews = carNews,
        super(key: key);

  String get _link => _carNews.link.toString();

  String get _imageName {
    if (_link.contains('anfavea')) {
      return 'anfavea.jpg';
    } else if (_link.contains('automotivebusiness')) {
      return 'automotive_business.jpg';
    } else if (_link.contains('ihs')) {
      return 'ihs_markit.png';
    } else if (_link.contains('sindipecas')) {
      return 'sindipecas.jpg';
    } else if (_link.contains('uol')) {
      return 'uol_carros.png';
    } else if (_link.contains('afac')) {
      return 'afac.jpg';
    } else if (_link.contains('autoblog')) {
      return 'autoblog.jpg';
    } else {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        child: ListTile(
          leading: Image.asset(
            _imageName,
          ),
          title: Text(
            _carNews.title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          subtitle: Row(
            children: <Widget>[
              Text(
                _carNews.dateTimeAsString,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  strutStyle: StrutStyle(fontSize: 14),
                  text: TextSpan(
                    style: TextStyle(color: Colors.grey),
                    text: _link.toString(),
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () => html.window.open(_carNews.linkAsString, 'new tab'),
      ),
    );
  }
}
