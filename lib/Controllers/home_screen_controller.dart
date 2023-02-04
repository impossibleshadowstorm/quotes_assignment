import 'package:aim2excel/Screens/author_quote_screen.dart';
import 'package:aim2excel/Screens/favourite_quote_screen.dart';
import 'package:aim2excel/Screens/search_quote_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeScreenController extends GetxController {
  var currentIndex = 0.obs;
  var searchLoading = false.obs;

  var bottomBarScreenList = [
    const AuthorQuoteScreen(),
    const SearchQuoteScreen(),
    const FavoriteQuoteScreen(),
  ];

  var likeTapped = false.obs;

  final localData = Hive.box("fav_quotes").obs;

  void addFavorite(String id, String author, String content) {
    localData.value.put(id, {"id": id, "author": author, "content": content});
  }

  void deleteFavorite(String id) {
    localData.value.delete(id);
  }

  final favItems = [].obs;

  loadFav() {
    final data = localData.value.keys.map((key) {
      final value = localData.value.get(key);
      return {
        "id": key,
        "content": value["content"],
        "author": value['author']
      };
    }).toList();
    favItems.value = data.reversed.toList();
  }

  TextEditingController searchField = TextEditingController();
}
