import 'package:flutter/material.dart';
import 'package:newsapp_ar/helper/data.dart';
import 'package:newsapp_ar/models/category.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Category> categories = List<Category>();

  @override
  void initState() {
    super.initState();
    categories = getCategoryData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("NewsApp"),
        ),
        body: Container(
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
              )
            ],
          ),
        ));
  }
}

class CategoryTile extends StatelessWidget {
  final String imgUrl, label;

  const CategoryTile({Key key, this.imgUrl, this.label}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imgUrl,
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
    );
  }
}
