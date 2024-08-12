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
//         "https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=391b8f6d3907483b9a303d1423d59313";
//     // String url =
//     //     "https://newsapi.org/v2/top-headlines?country=us&apiKey=391b8f6d3907483b9a303d1423d59313";
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

class NewsRepository {
  Future<NewsChannelHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String source) async {
    String url =
        "https://newsapi.org/v2/top-headlines?sources=$source&apiKey=391b8f6d3907483b9a303d1423d59313";
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      return NewsChannelHeadlinesModel.fromJson(body);
    }
    throw Exception('error');
  }

  Future<CategoriesNewModel> fetchCategoriesNewsApi(String category) async {
    String url =
        "https://newsapi.org/v2/everything?q=$category&apiKey=391b8f6d3907483b9a303d1423d59313";
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
