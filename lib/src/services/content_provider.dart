import 'package:beanknowledge/src/models/main_content.dart';
import 'package:beanknowledge/src/resources/contentAPI.dart';

class ContentProvider {
  //_apiKey可以看成此provider类的主要用处，此provider类的主要目的是从服务器端获得今日份内容(contentsOfToday)
  final String _apiKey = '/contentsOfToday';
  ContentAPI _contentAPI = ContentAPI();

  Future<List<MainContent>> fetchContentToday() async {
    try {
      final response = await _contentAPI.get(_apiKey);
      return MainContentResponse.fromJson(response).result;
    } catch (e) {
      return null;
    }
  }
}
