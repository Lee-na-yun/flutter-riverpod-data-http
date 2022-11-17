import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final httpConnector = Provider<HttpConnector>((ref) {
  return HttpConnector();
});

class HttpConnector {
  final host = "http://localhost:5000";
  final headers = {"Content-Type": "application/json; charset=utf-8"};
  final Client _client = Client();

  Future<Response> get(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.get(uri);
    return response;
  }

  Future<Response> post(String path, String body) async {
    // path=주소만들기 & body데이터 필요하니까 넣기
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.post(uri,
        body: body, headers: headers); // 무조건 headers를 넣고 content type 넣어야함
    return response;
  }

  Future<Response> delete(String path) async {
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.delete(uri);
    return response;
  }

  Future<Response> put(String path, String body) async {
    // path=주소만들기 & body데이터 필요하니까 넣기
    Uri uri = Uri.parse("${host}${path}");
    Response response = await _client.put(uri,
        body: body, headers: headers); // 무조건 headers를 넣고 content type 넣어야함
    return response;
  }
}
