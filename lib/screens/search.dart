import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_hub/model/wallpaper_modal.dart';

import '../data/data.dart';
import '../widget/widget.dart';

class Search extends StatefulWidget {
  final String searchQuery;
  Search({super.key, required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController search = TextEditingController();

  List<WallpaperModel> wallpaper = [];
  getSearchWallpaper(String query) async {
    var response = await http.get(
        Uri.parse('https://api.pexels.com/v1/search?query=$query&per_page=15"'),
        headers: {"Authorization": apiK});
    Map<String, dynamic> jsonData = jsonDecode(response.body);
    print(response.body.toString());
    jsonData['photos'].forEach((element) {
      WallpaperModel wallpaperModel =
          WallpaperModel(src: SrcModel.fromMap(element['src']));
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpaper.add(wallpaperModel);
    });
    setState(() {});
    print(response.body.toString());
  }

  @override
  void initState() {
    search.text = widget.searchQuery;
    getSearchWallpaper(widget.searchQuery);
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
      body: Container(
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
                        hintText: "Search Wallpaper", border: InputBorder.none),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      getSearchWallpaper(search.text);

                      print(search.value.text);
                    },
                    child: Icon(Icons.search))
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: wallpapersList(wallpapers: wallpaper, context: context))
        ],
      )),
    );
  }
}
