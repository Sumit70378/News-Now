import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:news_app/model/newsArt.dart';

class FetchNews {
  static const List<String> sourcesId = [
    "abc-news",
    "bbc-news",
    "bbc-sport",
    "business-insider",
    "entertainment-weekly",
    "espn",
    "financial-post",
    "fox-news",
    "fox-sports",
    "google-news",
    "google-news-in",
    "medical-news-today",
    "national-geographic",
    "news24",
    "new-scientist",
    "new-york-magazine",
    "next-big-future",
    "techcrunch",
    "techradar",
    "the-hindu",
    "the-wall-street-journal",
    "the-washington-times",
    "time",
    "usa-today",
  ];

  static Future<NewsArt> fetchnews() async {
    final random = Random();
    final sourceID = sourcesId[random.nextInt(sourcesId.length)];

    try {
      final response = await http.get(
        Uri.parse("https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=7e50ffc4040d4200a6eeec0010e19180"),
      );

      if (response.statusCode == 200) {
        final bodyData = jsonDecode(response.body) as Map<String, dynamic>;
        final articles = bodyData["articles"] as List<dynamic>;

        if (articles.isNotEmpty) {
          final myArticle = articles[random.nextInt(articles.length)];
          return NewsArt.fromAPItoApp(myArticle);
        } else {
          throw Exception("No articles found");
        }
      } else {
        throw Exception("Failed to fetch news: ${response.reasonPhrase}");
      }
    } catch (e) {
      throw Exception("Failed to fetch news: $e");
    }
  }
}
