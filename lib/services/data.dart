import 'package:bdnews/model/category.dart';

List<Category>getCategory(){
  List<Category>Categories=[];
  Category category=new Category();

  category.categoryName="Science";
  category.image="images/science.jpg";
  Categories.add(category);
  category=new Category();

  category.categoryName="Sport";
  category.image="images/sport.jpg";
  Categories.add(category);
  category=new Category();

  category.categoryName="Entertainment";
  category.image="images/enter.jpg";
  Categories.add(category);
  category=new Category();

  category.categoryName="Business";
  category.image="images/business.jpg";
  Categories.add(category);
  category=new Category();

  category.categoryName="Health";
  category.image="images/health.jpg";
  Categories.add(category);
  category=new Category();

  return Categories;
}