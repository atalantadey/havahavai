import 'package:http/http.dart' as http;

class NetworkClient {
  final String baseUrl = 'https://dummyjson.com';

  Future<http.Response> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl$endpoint'));
    return response;
  }
}
