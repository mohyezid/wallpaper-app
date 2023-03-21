import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../data/data.dart';
import '../model/wallpaper_modal.dart';
import '../widget/widget.dart';

class Category extends StatefulWidget {
  final String categoryname;
  const Category({super.key, required this.categoryname});

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  List<WallpaperModel> wallpapers = [];
  getQsearchWallpaper(String cata) async {
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$cata&per_page=15"),
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
  }

  @override
  void initState() {
    getQsearchWallpaper(widget.categoryname);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: brandName(),
          elevation: 0,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            wallpapers.isEmpty
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: wallpapersList(
                        wallpapers: wallpapers, context: context))
          ],
        ));
  }
}
