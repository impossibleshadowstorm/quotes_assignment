import 'dart:convert';

import 'package:aim2excel/Controllers/home_screen_controller.dart';
import 'package:aim2excel/Models/searched_quotes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SearchQuoteScreen extends StatefulWidget {
  const SearchQuoteScreen({Key? key}) : super(key: key);

  @override
  State<SearchQuoteScreen> createState() => _SearchQuoteScreenState();
}

class _SearchQuoteScreenState extends State<SearchQuoteScreen> {
  HomeScreenController homeScreenController = Get.find();
  List<AuthorBasedSearchQuotes> quotesList = [];
  int currentPage = 1;
  bool allLoaded = false;

  List<AuthorBasedSearchQuotes> foundQuotesList = [];

  // Future<void> fetchQuotes() async {
  //   var response = await http
  //       .get(Uri.parse('https://api.quotable.io/quotes?page=$currentPage'));
  //   var data = jsonDecode(response.body.toString());
  //   if (response.statusCode == 200) {
  //     int totalP = data["totalPages"];
  //
  //     for (int i = 1; i <= totalP; i++) {
  //       if (i == (totalP / 2).floor()) {
  //         setState(() {
  //           allLoaded = true;
  //         });
  //       }
  //       response = await http
  //           .get(Uri.parse('https://api.quotable.io/quotes?page=$currentPage'));
  //       var data = jsonDecode(response.body.toString());
  //       if (response.statusCode == 200) {
  //         for (Map<String, dynamic> index in data["results"]) {
  //           quotesList.add(Quotes.fromJson(index));
  //         }
  //
  //         setState(() {
  //           foundQuotesList = quotesList;
  //         });
  //       }
  //
  //       // if (response.statusCode == 200) {
  //       //   for (Map<String, dynamic> index in data["results"]) {
  //       //     quotesList.add(Quotes.fromJson(index));
  //       //   }
  //       //
  //       //   setState(() {
  //       //     foundQuotesList = quotesList;
  //       //   });
  //
  //       // return quotesList;
  //       else {
  //         throw Exception('Failed to load Authors');
  //       }
  //     }
  //     print(foundQuotesList.length);
  //   }
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchQuotes();
  }

  runSearch(value) async {
    var response = await http
        .get(Uri.parse('https://api.quotable.io/search/quotes?query=$value'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data["results"]) {
        quotesList.add(AuthorBasedSearchQuotes.fromJson(index));
      }

      setState(() {
        foundQuotesList = quotesList;
        allLoaded = true;
      });
    } else {
      throw Exception('Failed to load Authors');
    }
  }

  // void _runFilter(String value) {
  //   List<Quotes> results = [];
  //
  //   if (value.isEmpty) {
  //     results = quotesList;
  //   } else {
  //     results = quotesList
  //         .where((quote) =>
  //             quote.author.toLowerCase().contains(value.toLowerCase()))
  //         .toList();
  //   }
  //   setState(() {
  //     foundQuotesList = results;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            Container(
              height: AppBar().preferredSize.height,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: size.width,
              child: Row(
                children: [
                  Container(
                    height: 24,
                    width: 24,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/hexagons.png"),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: TextFormField(
                        onFieldSubmitted: (value) {
                          setState(() {
                            allLoaded = false;
                            quotesList = [];
                            foundQuotesList = [];
                          });
                          runSearch(value);
                        },
                        // onChanged: (v) {
                        //   // _runFilter(v);
                        // },
                        controller: homeScreenController.searchField,
                        decoration: const InputDecoration(
                          hintText: "Search",
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black54,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            allLoaded
                ? Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: foundQuotesList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              color: Color(0xffF4981D),
                            ),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1160&q=80"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      child: Text(
                                        foundQuotesList[index].author,
                                        style: GoogleFonts.roboto(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Obx(() {
                                      return InkWell(
                                        onTap: () {
                                          // homeScreenController
                                          //     .likeTapped.value = false;
                                          setState(() {
                                            if (homeScreenController
                                                    .localData.value
                                                    .get(
                                                        quotesList[index].id) ==
                                                null) {
                                              homeScreenController.addFavorite(
                                                  quotesList[index].id,
                                                  foundQuotesList[index].author,
                                                  foundQuotesList[index]
                                                      .content);
                                              homeScreenController.loadFav();
                                              setState(() {});
                                            } else {
                                              homeScreenController
                                                  .deleteFavorite(
                                                      quotesList[index].id);
                                              homeScreenController.loadFav();
                                              setState(() {});
                                            }
                                          });
                                        },
                                        child: Container(
                                          height: 40,
                                          width: 40,
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          child: Icon(
                                            Icons.favorite,
                                            color: homeScreenController
                                                        .localData.value
                                                        .get(quotesList[index]
                                                            .id) !=
                                                    null
                                                ? Colors.red
                                                : Colors.grey,
                                          ),
                                        ),
                                      );
                                    })
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10)),
                                  ),
                                  width: size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 20),
                                  child: Center(
                                    child: Text(
                                      foundQuotesList[index].content,
                                      textAlign: TextAlign.justify,
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
          ],
        ),
      ),
    );
  }
}
