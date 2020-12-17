import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:newsapp_ar/helper/data.dart';
import 'package:newsapp_ar/helper/news.dart';
import 'package:newsapp_ar/models/category.dart';
import 'package:newsapp_ar/models/article.dart';
import 'package:newsapp_ar/views/article_view.dart';
import 'package:newsapp_ar/views/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = List<Category>();
  List<Article> articles = List<Article>();

  News news = News();

  getAndSetNews() async {
    await news.getNewsHeadlines("in");
    articles = news.articles;
    setState(() {});
  }

  @override
  void initState() {
    categories = getCategoryData();
    getAndSetNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewsApp"),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 80,
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12,
                    ),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return CategoryTile(
                        imgUrl: categories[index].imgUrl,
                        label: categories[index].label,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: articles.length,
                  itemBuilder: (context, index) {
                    return NewsTile(
                      imageUrl: articles[index].urlToImage,
                      title: articles[index].title,
                      description: articles[index].description,
                      url: articles[index].url,
                    );
                  },
                ),
              ],
            ),
          ),
        ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, label;

  const CategoryTile({Key key, this.imgUrl, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(category: label)));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: imgUrl,
                height: 60,
                width: 120,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.black26,
              ),
              alignment: Alignment.center,
              height: 60,
              width: 120,
              child: Text(
                label,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewsTile extends StatelessWidget {
  final String imageUrl, title, description, url, source;
  NewsTile(
      {this.imageUrl, this.title, this.description, this.url, this.source});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(
                url: url,
                source: source,
              ),
            ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        padding: EdgeInsets.symmetric(horizontal: 14),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 180,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              description,
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}
