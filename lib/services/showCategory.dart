import 'dart:convert';

import 'package:bdnews/model/showCategory.dart';
import 'package:http/http.dart' as http;
class ShowCategory{
  List<ShowCategorymodel> categories=[];

  Future<void> getCategory(String category)async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=${category.toLowerCase()}&apiKey=a670179268564b399f853f74b6512c24";

    var response=await http.get(Uri.parse(url));

    var jsonData=jsonDecode(response.body);
    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      if (jsonData['status'] == 'ok') {
        jsonData["articles"].forEach((element) {
          if (element["urlToImage"] != null && element["description"] != null) {
            ShowCategorymodel showCategoryModel = ShowCategorymodel(
              urlToImage: element["urlToImage"],
              description: element["description"],
              title: element["title"],
              url: element["url"]
            );
            categories.add(showCategoryModel);
          }
        });
      }
    } else {
      print("Failed to load news: ${response.statusCode}");
    }

  }
}
