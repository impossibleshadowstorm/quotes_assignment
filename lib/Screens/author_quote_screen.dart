import 'dart:convert';

import 'package:aim2excel/Controllers/home_screen_controller.dart';
import 'package:aim2excel/Models/quotes.dart';
import 'package:aim2excel/constants.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class AuthorQuoteScreen extends StatefulWidget {
  const AuthorQuoteScreen({Key? key}) : super(key: key);

  @override
  State<AuthorQuoteScreen> createState() => _AuthorQuoteScreenState();
}

class _AuthorQuoteScreenState extends State<AuthorQuoteScreen> {
  HomeScreenController homeScreenController = Get.find();
  List<Quotes> quotesList = [];
  int currentPage = 1;

  Future<List<Quotes>> fetchQuotes() async {
    final response = await http
        .get(Uri.parse('https://api.quotable.io/quotes?page=$currentPage'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map<String, dynamic> index in data["results"]) {
        quotesList.add(Quotes.fromJson(index));
      }

      setState(() {});

      return quotesList;
    } else {
      throw Exception('Failed to load Authors');
    }
  }

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
                        // color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Text(
                        "Famous Quotes",
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: fetchQuotes(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          itemCount: quotesList.length,
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
                                          quotesList[index].author,
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
                                            if (homeScreenController
                                                    .localData.value
                                                    .get(
                                                        quotesList[index].id) ==
                                                null) {
                                              homeScreenController.addFavorite(
                                                  quotesList[index].id,
                                                  quotesList[index].author,
                                                  quotesList[index].content);
                                              homeScreenController.loadFav();
                                              setState(() {});
                                            } else {
                                              homeScreenController
                                                  .deleteFavorite(
                                                      quotesList[index].id);
                                              homeScreenController.loadFav();
                                              setState(() {});
                                            }
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
                                        quotesList[index].content,
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
                      );
                    } else {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Constants.violetColor,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
