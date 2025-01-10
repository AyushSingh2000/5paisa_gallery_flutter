import 'dart:convert';

import 'package:http/http.dart' as http;

class ImageRepository {
  Future<List<dynamic>> fetchImages(int page, int limit) async {
    final url =
        Uri.parse('https://picsum.photos/v2/list?page=$page&limit=$limit');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body) as List<dynamic>;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
