import 'package:flutter/material.dart';
import 'package:wallpaper_hub/screens/image_view.dart';

import '../model/wallpaper_modal.dart';

Widget brandName() {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: const [
      Text(
        'Wallpaper',
        style: TextStyle(color: Colors.black),
      ),
      Text(
        'Hub',
        style: TextStyle(color: Colors.blue),
      ),
    ],
  );
}

Widget wallpapersList({required List<WallpaperModel> wallpapers, context}) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      physics: ClampingScrollPhysics(),
      childAspectRatio: 0.6,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      children: wallpapers.map((e) {
        return Hero(
          tag: e.src.portrait!,
          child: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return ImageView(
                  imgPath: e.src.portrait!,
                );
              }));
            },
            child: GridTile(
                child: Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  e.src.portrait!,
                  fit: BoxFit.cover,
                ),
              ),
            )),
          ),
        );
      }).toList(),
    ),
  );
}
