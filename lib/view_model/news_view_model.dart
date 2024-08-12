import 'package:news_appp/models/categories_new_model.dart';
import 'package:news_appp/repository/news_repository.dart';
import '../models/news_channel_headlines_model.dart';

class NewsViewModel {
  final _rep = NewsRepository();

  Future<NewsChannelHeadlinesModel> fetchNewsChannelsHeadlinesApi(
      String source) async {
    final response = _rep.fetchNewsChannelsHeadlinesApi(source);
    return response;
  }

  Future<CategoriesNewModel> fetchCategoriesNewsApi(String category) async {
    final response = _rep.fetchCategoriesNewsApi(category);
    return response;
  }
}
