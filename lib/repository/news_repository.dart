// import 'dart:convert';

// import 'package:flutter/foundation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_appp/models/categories_new_model.dart';
// import 'package:news_appp/models/news_channel_headlines_model.dart';

// class NewsRepository {
//   Future<NewsChannelHeadlinesModel> fetchNewsChannelsHeadlinesApi() async {
//     String url =
//         "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$_newsApiKey";
//     // String url =
//     //     "https://newsapi.org/v2/top-headlines?country=us&apiKey=$_newsApiKey";
//     final response = await http.get(Uri.parse(url));
//     // if (kDebugMode) {
//     //   print(response.body);
//     // }
//     if (response.statusCode == 200) {
//       final body = jsonDecode(response.body);
//       return NewsChannelHeadlinesModel.fromJson(body);
//     }
//     throw Exception('error');
//   }
// }

import '../models/news_channel_headlines_model.dart';

// NewsAPI key is passed at build time, never committed:
// flutter run --dart-define=NEWS_API_KEY=your_key
const String _newsApiKey = String.fromEnvironment('NEWS_API_KEY');

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String source) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=$_newsApiKey";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<CategoriesNewModel> fetchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=$_newsApiKey";
    final response = await http.get(Uri.parse(url));
    if (kDebugMode) {
      print(response.body);
    }
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return CategoriesNewModel.fromJson(body);
    }
    throw Exception('Error fetching news');
  }
}
