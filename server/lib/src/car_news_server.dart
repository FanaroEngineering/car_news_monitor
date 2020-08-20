import 'dart:convert';
import 'dart:io';

import 'package:meta/meta.dart';

class CarNewsClient {
  static final HttpClient _client = HttpClient();

  final Uri _url;
  int _statusCode;
  String _decodedResponse;

  CarNewsClient({@required Uri url}) : _url = url;

  int get statusCode => _statusCode;
  String get decodedResponse => _decodedResponse;

  Future<HttpClientResponse> getUrl() async {
    final HttpClientRequest request = await _client.getUrl(_url);
    final HttpClientResponse response = await request.close();
    _statusCode = response.statusCode;
    final List<String> decodedResponseAsList =
        await utf8.decoder.bind(response).toList();
    _decodedResponse = decodedResponseAsList.join('');
    return response;
  }
}
