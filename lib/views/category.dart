import 'package:flutter/material.dart';
import 'package:newsapp_ar/helper/news.dart';
import 'package:newsapp_ar/models/article.dart';
import 'package:newsapp_ar/views/home.dart';

class CategoryScreen extends StatefulWidget {
  final String category;

  const CategoryScreen({Key key, this.category}) : super(key: key);
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<Article> articles = List<Article>();
  News news = News();

  getAndSetNews() async {
    await news.getNewsByCategory(widget.category.toLowerCase());
    articles = news.articles;
    setState(() {});
  }

  @override
  void initState() {
    getAndSetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.category} News"),
      ),
      body: Container(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10),
          itemCount: articles.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return NewsTile(
              title: articles[index].title,
              description: articles[index].description,
              imageUrl: articles[index].urlToImage,
              url: articles[index].url,
            );
          },
        ),
      ),
    );
  }
}
