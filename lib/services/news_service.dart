import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsapppage/models/articles.dart';
import 'package:newsapppage/models/news.dart';


class NewsService {
  Future<List<Articles>> fetchNews(String category) async {
    String url =
        'https://newsapi.org/v2/everything?q=tesla&from=2024-07-16&sortBy=publishedAt&apiKey=d7a468c4be4c4c82ab5698a393c1a8ac';
    Uri uri = Uri.parse(url);
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      News news = News.fromJson(result);
      return news.articles ?? [];
    }
    throw Exception('Bad Request');
  }
}