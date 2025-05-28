

import 'package:bdnews/model/Article.dart';
import 'package:bdnews/model/category.dart';
import 'package:bdnews/pages/article.dart';
import 'package:bdnews/pages/categoryNews.dart';
import 'package:bdnews/services/data.dart';
import 'package:bdnews/services/news.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Category>categories = [];
  List<Article>article=[];
  bool loading=true;

  @override
  void initState() {
    categories = getCategory();
    getNews();
    super.initState();
  }
getNews()async{
    News newsclass=News();
    await newsclass.getNews();
    article=newsclass.news;
    setState(() {
        loading=false;
    });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Container(
        margin: EdgeInsets.only(top: 40.0, left: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("NEWS", style: TextStyle(color: Color(0xff3280ef),
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),),
                Text(" NEXUS", style: TextStyle(color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold),),
              ],),
            SizedBox(height: 20.0,),
            Text("Hottest News", style: TextStyle(color: Colors.black,
                fontSize: 25.0,
                fontWeight: FontWeight.bold),),
            SizedBox(height: 10.0,),
            Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2.49,
              child: ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: article.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index)
                {
                  return GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ArticleView(blogUrl: article[index].url!)));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 3.0, left: 5.0,right: 12.0),
                      child: Material(
                        elevation: 2.0,
                        borderRadius: BorderRadius.circular(10),
                        child: Container(

                          decoration: BoxDecoration(color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.network(
                                  article[index].urlToImage!
                                  , width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.8,
                                    fit: BoxFit.cover,
                                    height: 150,)),
                            ),
                            SizedBox(height: 10.0,),
                            Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.8,
                                child: Text(
                                  maxLines: 2,
                                  article[index].title!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold),)),

                            SizedBox(height: 20.0,),
                            Container(

                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width / 1.8,
                                child: Text(
                                  maxLines: 2,
                                  article[index].description!,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.black54,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w500),)),
                            Spacer(),
                            Container(
                              width: 80,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: Color(0xff3280ef),
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),

                                  )

                              ),
                              margin: EdgeInsets.only(left: 160),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                                size: 30.0,
                              ),
                            )
                          ],

                          ),),
                      ),
                    ),
                  );
                },


                ),
            ),
            SizedBox(height: 20.0,),
            Center(
              child: Text(
                "Explore",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 30,),
            Container(
              height: 150,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryTile(
                        categoryname: categories[index].categoryName,
                        image:categories[index].image);


                  }),
            )


          ],),),
    );
  }
}
class CategoryTile extends StatelessWidget {
  final image,categoryname;
  CategoryTile({this.categoryname,this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>CategoryNews(name: categoryname)));
      },
      child: Container(
        margin: EdgeInsets.only(right: 20.0),
      child: Stack(
        children: [
      ClipRRect(
          borderRadius: BorderRadius.circular(80),
          child: Image.asset(image,
            height: 150,
            width: 150,
            fit: BoxFit.cover,)),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(80)),
      
          ),
          Container(
            height: 150,
            width: 150,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(80)),
            child: Center(
              child: Text(categoryname,
                style:TextStyle(fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),),
            ),
          )
        ],
      ),
      ),
    );
  }
}


