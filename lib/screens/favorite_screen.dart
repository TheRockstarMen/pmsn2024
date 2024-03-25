import 'package:flutter/material.dart';
import 'package:pmsn2024/database/database_movies.dart';
import 'package:pmsn2024/model/favorite_model.dart';
import 'package:pmsn2024/widgets/item_favorite.dart';

class FavoriteWidget extends StatefulWidget {
  FavoriteWidget({super.key});
  DatabaseMovies databaseHelper = DatabaseMovies();

  @override
  State<FavoriteWidget> createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  late List<FavoriteModel> listFav;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initData(),
        builder: (context, AsyncSnapshot<dynamic> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              {
                return const Center(
                    child: Center(
                        child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                )));
              }
            case ConnectionState.done:
              {
                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(10),
                  child: ListView(children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Tu lista de favoritos",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                    listFav.isEmpty
                        ? Center(
                            child: Column(children: [
                              const Text(
                                "no tienes peliculas favoritas y porque no haz agregau una?",
                                style: TextStyle(color: Colors.white),
                              ),
                              Image.asset(
                                "assets/images/nothing.gif",
                                width: 400,
                                height: 400,
                                fit: BoxFit.fill,
                              )
                            ]),
                          )
                        : GridView.builder(
                            shrinkWrap: true,
                            padding: const EdgeInsets.all(10),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                        (MediaQuery.of(context).size.width ~/
                                                170)
                                            .toInt(),
                                    childAspectRatio: .9,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10),
                            itemCount: listFav.length,
                            itemBuilder: (context, index) {
                              return ItemFavorite(
                                  favoriteModel: listFav[index]);
                            },
                          )
                  ]),
                );
              }
          }
        });
  }

  Widget getFavorite() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      child: ListView(children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Tu lista de favoritos",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        listFav.isEmpty
            ? Center(
                child: Column(children: [
                  const Text(
                    "No tienes favoritos mi loko",
                    style: TextStyle(color: Colors.white),
                  ),
                  Image.asset(
                    "assets/images/nothing.gif",
                    width: 400,
                    height: 400,
                    fit: BoxFit.fill,
                  )
                ]),
              )
            : GridView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .9,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: listFav.length,
                itemBuilder: (context, index) {
                  return ItemFavorite(favoriteModel: listFav[index]);
                },
              )
      ]),
    );
  }

  initData() async {
    listFav = await widget.databaseHelper.GETFAV();
 
  }
}
