import 'dart:convert';
import 'dart:io';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

class Network {
  final url = 'https://6209f31f92946600171c5604.mockapi.io';

  // * Headers
  Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8',
  };

  // * Http Requests
  Future<String?> get(String api, Map<String, dynamic> params) async {
    final client = HttpClient();

    try {
      HttpClientRequest request = await client.getUrl(
        Uri.parse(url + api).replace(queryParameters: params),
      );

      request.setHeaders();

      HttpClientResponse response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        stringData.log();
        return stringData;
      }
    } finally {
      client.close();
    }

    return null;
  }

  Future<String?> post(String api, Map<String, dynamic> body) async {
    final client = HttpClient();

    try {
      final request = await client.postUrl(Uri.parse(url + api));

      request.setHeaders();
      request.write(jsonEncode(body));
      jsonEncode(body).log();

      final response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      if (response.statusCode == 201) {
        stringData.log();
        return stringData;
      }
    } finally {
      client.close();
    }

    return null;
  }

  Future<String?> put(String api, String id, Map<String, dynamic> body) async {
    final client = HttpClient();

    try {
      final request = await client.putUrl(Uri.parse(url + api + id));

      request.setHeaders();
      request.write(jsonEncode(body));
      jsonEncode(body).log();

      final response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        stringData.log();
        return stringData;
      }
    } finally {
      client.close();
    }

    return null;
  }

  Future<String?> delete(String api, String id) async {
    final client = HttpClient();

    try {
      final request = await client.deleteUrl(Uri.parse(url + api + id));

      request.setHeaders();

      final response = await request.close();
      final stringData = await response.transform(utf8.decoder).join();

      if (response.statusCode == 200) {
        stringData.log();
        return stringData;
      }
    } finally {
      client.close();
    }

    return null;
  }

  // * params
  Map<String, dynamic> paramsEmpty() => {};

  Map<String, dynamic> paramsGetSingleObject(String id) => {'id': id};
}

extension SetHeaders on HttpClientRequest {
  void setHeaders() {
    for (var i in Network().headers.entries) {
      headers.add(i.key, i.value);
    }
  }
}
