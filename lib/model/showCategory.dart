class ShowCategorymodel {
  String? title;
  String? description;
  String? urlToImage;
  String? url;

  ShowCategorymodel({this.description, this.title, this.urlToImage,this.url});

  factory ShowCategorymodel.fromJson(Map<String, dynamic> json) {
    return ShowCategorymodel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      urlToImage: json['urlToImage'] ?? '',
    );
  }
}
