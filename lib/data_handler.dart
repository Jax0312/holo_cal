import 'package:http/http.dart' as http;

class DataHandler {
  static http.Response? response;

  static Future<http.Response> get({bool refresh = false}) async {
    // Request and return latest data if refresh

    if (response != null && !refresh) {
      return response!;
    }

    return http
        .get(Uri.https(
      'api.holotools.app',
      '/v1/live',
      {'hide_channel_desc': '1', 'max_upcoming_hours': '48'},
    ))
        .then((_response) {
      response = _response;
      return _response;
    });
  }
}
