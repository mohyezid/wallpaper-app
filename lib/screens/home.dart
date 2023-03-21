import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_hub/data/data.dart';
import 'package:wallpaper_hub/model/categories_model.dart';
import 'package:wallpaper_hub/model/wallpaper_modal.dart';
import 'package:wallpaper_hub/screens/category.dart';
import 'package:wallpaper_hub/screens/search.dart';
import 'package:wallpaper_hub/widget/widget.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];
  TextEditingController search = TextEditingController();

  getTrandingWallpaper() async {
    var response = await http.get(
        Uri.parse('https://api.pexels.com/v1/curated'),
        headers: {"Authorization": apiK});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    print(response.body.toString());
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel =
          WallpaperModel(src: SrcModel.fromMap(element['src']));
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);
    });
    setState(() {});
    print(response.body.toString());
  }

  @override
  void initState() {
    categories = getCategories();
    getTrandingWallpaper();
    print(categories);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: brandName(),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    color: Color(0xfff5f8fd)),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: search,
                        cursorColor: Colors.red,
                        decoration: const InputDecoration(
                            hintText: "Search Wallpaper",
                            border: InputBorder.none),
                      ),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: ((context) {
                            return Search(
                              searchQuery: search.text,
                            );
                          })));
                        },
                        child: Icon(Icons.search))
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                height: 60,
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoriesTile(categories[index].categorieName,
                        categories[index].imgUrl);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child:
                      wallpapersList(wallpapers: wallpapers, context: context))
            ],
          ),
        ));
  }
}

class CategoriesTile extends StatelessWidget {
  final String? title;
  final String? imageUrl;
  CategoriesTile(this.title, this.imageUrl);
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Category(categoryname: title!.toLowerCase());
        }));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(children: [
          Container(
            height: 50,
            width: 100,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: 50,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.black12,
            ),
            alignment: Alignment.center,
            child: Text(
              title!,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 17),
            ),
          )
        ]),
      ),
    );
  }
}
