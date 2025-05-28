import 'package:bdnews/model/Article.dart';
import 'package:bdnews/model/showCategory.dart';
import 'package:bdnews/pages/article.dart';
import 'package:bdnews/services/showCategory.dart';
import 'package:flutter/material.dart';

class CategoryNews extends StatefulWidget {
  final String name;

  const CategoryNews({required this.name, Key? key}) : super(key: key);

  @override
  State<CategoryNews> createState() => _CategoryNewsState();
}

class _CategoryNewsState extends State<CategoryNews> {
  List<ShowCategorymodel> categories = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    ShowCategory showCategory = ShowCategory();
    await showCategory.getCategory(widget.name.toLowerCase());
    setState(() {
      categories = showCategory.categories;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff3280ef),
      body: Container(
        margin: const EdgeInsets.only(top: 50.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                children: [
                   GestureDetector(
                       onTap: (){
                         Navigator.pop(context);
                       },
                       child: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white)),
                  SizedBox(width: MediaQuery.of(context).size.width / 3.5),
                  Text(
                    widget.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 35,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20.0),
            const SizedBox(height: 20.0), // for horizontal ListView space

            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,

                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                      title: categories[index].title,
                      description: categories[index].description,
                      image: categories[index].urlToImage,
                      url: categories[index].url,
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final image, title, description,url;

  CategoryTile({this.image, this.title, this.description,this.url});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl:url)));
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 20,right: 20,top: 20),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(image ??''), // default if null
                ),
                const SizedBox(height: 12.0),
                Text(
                  title ?? '',
                  maxLines: 2,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.only(left: 5.0,right: 5.0),
          width: MediaQuery.of(context).size.width,
          child: Text(
            description ?? '',
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,

              fontWeight: FontWeight.w400,

            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
