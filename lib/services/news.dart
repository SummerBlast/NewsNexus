import 'dart:convert';

import 'package:bdnews/model/Article.dart';
import 'package:http/http.dart' as http;
class News{
  List<Article> news=[];
  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&apiKey=a670179268564b399f853f74b6512c24";
    var response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            Article article = Article(
              urlToImage: element["urlToImage"],
              description: element["description"],
              title: element["title"],
              url: element["url"]
            );
            news.add(article);
          }
        });
      }
    } else {
      print("Failed to load news: ${response.statusCode}");
    }
  }

}