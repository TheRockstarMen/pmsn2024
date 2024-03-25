import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pmsn2024/network/api_details.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pmsn2024/model/favorite_model.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';

import '../database/database_movies.dart';

class DetailMovieScreen extends StatefulWidget {
  const DetailMovieScreen({super.key, required this.id});
  final int id;

  @override
  State<DetailMovieScreen> createState() => _DetailMovieScreenState();
}

class _DetailMovieScreenState extends State<DetailMovieScreen> {
  ApiDetails apiDetails = ApiDetails();
  DatabaseMovies databaseHelper = DatabaseMovies();
  var response;
  late bool isFav;
  var controller;

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
              return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setState) {
                return Scaffold(
                  backgroundColor: Colors.black87,
                  body: NestedScrollView(
                    floatHeaderSlivers: true,
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          pinned: true,
                          expandedHeight: 400,
                          flexibleSpace: FlexibleSpaceBar(
                            background: Container(
                                width: 100,
                                height: 400,
                               
                                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(20),
                                      bottomRight: Radius.circular(20)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500${response['poster_path']}"),
                                      fit: BoxFit.fill),
                                ),
                                child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        gradient: LinearGradient(
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                            colors: [
                                              Colors.transparent,
                                              Colors.black
                                            ])),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            response['original_title'],
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                                fontSize: 22),
                                          ),
                                          getGenres(response["genres"]),
                                          Container(
                                              margin: const EdgeInsets.fromLTRB(
                                                  25, 8, 25, 8),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      if (isFav) {
                                                        databaseHelper
                                                                .DeleMovie(
                                                                    widget.id)
                                                            .then((value) {
                                                          var msg = value > 0
                                                              ? 'Delete to favorites'
                                                              : 'Ocurrió un error';
                                                          if (value > 0) {
                                                            setState(() {
                                                              isFav = !isFav;
                                                            });
                                                          } else {}
                                                          var snackBar =
                                                              SnackBar(
                                                                  content: Text(
                                                                      msg));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        });
                                                      } else {
                                                        databaseHelper.INSERT(
                                                            'tblFav', {
                                                          'id_movie': widget.id,
                                                          'posterPath':
                                                              response[
                                                                  'poster_path']
                                                        }).then((value) {
                                                          var msg = value > 0
                                                              ? 'Add to favorites'
                                                              : 'Ocurrió un error';
                                                          if (value > 0) {
                                                            setState(() {
                                                              isFav = !isFav;
                                                            });
                                                          } else {}
                                                          var snackBar =
                                                              SnackBar(
                                                                  content: Text(
                                                                      msg));
                                                          ScaffoldMessenger.of(
                                                                  context)
                                                              .showSnackBar(
                                                                  snackBar);
                                                        });
                                                      }
                                                    },
                                                    icon: Icon(
                                                      Icons.favorite,
                                                      color: isFav
                                                          ? Colors.pink
                                                          : Colors.white,
                                                    ),
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(),
                                                      onPressed: () {
                                                        launch(
                                                            "https://www.youtube.com/watch?v=${response['videos']['results'][0]['key']}");
                                                      },
                                                      child: const Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                          ),
                                                          Text(
                                                            "Watch now",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ],
                                                      )),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await showInfo();
                                                    },
                                                    icon: const Icon(
                                                      Icons.info,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ))
                                        ]))),
                          ),
                          backgroundColor: Colors.transparent,
                          floating: true,
                          snap: true,
                        )
                      ];
                    },
                    body: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              getRaking(response["vote_average"],
                                  response["vote_count"]),
                              getDesc(response["overview"]),
                              getActors(),
                              getLanguage(response["original_language"]),
                              getReleaseDate(response["release_date"]),
                              getTrailer()
                            ]),
                      ),
                    ),
                  ),
                );
              });
          }
        });
  }

  Widget getTrailer() {
    return YoutubePlayer(
      controller: controller,
      aspectRatio: 16 / 9,
    );
  }

  Widget getTrailers(var videos) {
    List<Widget> ListVideos = List.empty(growable: true);
    for (var item in videos) {
      if (item["site"] == "YouTube") {
        ListVideos.add(Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SimpleHtmlYoutubeIframe(
              youtubeCode: item["key"],
            )));
      }
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return ListVideos[index];
      },
      itemCount: 1,
    );
  }

  initData() async {
    response = await apiDetails.getDetails(widget.id.toString());
    List<FavoriteModel> b = await databaseHelper.GETONEFAV(widget.id);
    isFav = b.isEmpty ? false : true;

    controller = YoutubePlayerController.fromVideoId(
      videoId: response["videos"]["results"][0]["key"],
      autoPlay: true,
      params: const YoutubePlayerParams(
          showFullscreenButton: false,
          mute: true,
          enableCaption: false,
          showControls: false,
          showVideoAnnotations: false),
    );
  }

  Widget getActors() {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: ListView.builder(
         
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return getActor(response["credits"]["cast"][index]["profile_path"],
                response["credits"]["cast"][index]["name"]);
          },
          itemCount: response["credits"]["cast"].length),
    );
  }

  Widget getDesc(String desc) {
    return Row(children: [
      Expanded(
          child: Text(
        desc,
        style: const TextStyle(color: Colors.white),
      ))
    ]);
  }

  Widget getRaking(double voteAverage, int voteCount) {
    int stars = voteAverage * 5 ~/ 10;
    return Row(
      children: [
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.star,
              color: stars >= 1 ? Colors.amber : Colors.grey,
            )),
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.star,
              color: stars >= 2 ? Colors.amber : Colors.grey,
            )),
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.star,
              color: stars >= 3 ? Colors.amber : Colors.grey,
            )),
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.star,
              color: stars >= 4 ? Colors.amber : Colors.grey,
            )),
        Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Icon(
              Icons.star,
              color: stars >= 5 ? Colors.amber : Colors.grey,
            )),
        Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Text(
              "Media: $voteAverage ($voteCount)",
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Widget getLanguage(String lang) {
    String langName = "other";
    if (lang == "en") {
      langName = "en";
    } else if (lang == "es") {
      langName = "es";
    } else if (lang == "fr") {
      langName = "fr";
    } else if (lang == "ja") {
      langName = "ja";
    } else if (lang == "de") {
      langName = "de";
    } else if (lang == "ko") {
      langName = "ko";
    }

    return SizedBox(
      width: 250,
      child: ListTile(
        leading: const Icon(
          Icons.translate,
          color: Colors.white,
        ),
        title: const Text(
          "Original language",
          style: TextStyle(color: Colors.white),
        ),
        trailing: Image.asset("assets/images/lang/$langName.png"),
      ),
    );
  }

  Widget getReleaseDate(String date) {
    return SizedBox(
      width: 250,
      child: ListTile(
        leading: const Icon(
          Icons.event,
          color: Colors.white,
        ),
        title: const Text(
          "Release date",
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          date,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget getGenres(var genders) {
    String strGenders = "";
    for (var item in genders) {
      String aux = item['name'];
      strGenders += "$aux ";
    }
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Expanded(
              child: Icon(
            Icons.movie,
            color: Colors.white,
          )),
          const Expanded(
              child: Text(
            "Genres",
            style: TextStyle(color: Colors.white),
          )),
          Expanded(
              child: Text(
            strGenders,
            style: const TextStyle(color: Colors.white),
          ))
        ],
      ),
    );
  }

  Widget getPopularity(double popu) {
    return SizedBox(
      width: 250,
      child: ListTile(
        leading: const Icon(Icons.event),
        title: const Text(
          "Release date",
          style: TextStyle(color: Colors.white),
        ),
        trailing: Text(
          popu.toString(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget getActor(var img, String name) {
    return Container(
        width: 150,
        height: 170,
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Container(
                margin: const EdgeInsets.all(5),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(img == null
                            ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                            : 'https://image.tmdb.org/t/p/w500$img'),
                        fit: BoxFit.cover)),
                child: null),
            Text(
              name,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white),
            )
          ],
        ));
  }

  Future<bool?> showInfo() => showDialog<bool>(
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => AlertDialog(
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                "Info",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white),
              ),
              content: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(20)),
                      //padding: EdgeInsets.all(0),
                      height: 400,
                      width: 300,
                      child: ListView(
                        padding: const EdgeInsets.all(10),
                        children: [
                          const Text(
                            "Homepage",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            response["homepage"],
                            style: const TextStyle(color: Colors.white),
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            "Status",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(response["status"],
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 20),
                          const Text(
                            "Tag Line",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(response["tagline"],
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 20),
                          const Text(
                            "Run time",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(response["runtime"].toString(),
                              style: const TextStyle(color: Colors.white)),
                          const SizedBox(height: 20),
                          const Text(
                            "Production companies",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return Text(
                                  response["production_companies"][index]
                                      ["name"],
                                  style: const TextStyle(color: Colors.white));
                            },
                            itemCount: response["production_companies"].length,
                          )
                        ],
                      )),
                ),
              ),
            ),
          ));
}

class SimpleHtmlYoutubeIframe extends StatelessWidget {
  final String youtubeCode;

  const SimpleHtmlYoutubeIframe({
    required this.youtubeCode,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String content =
        '<iframe src="https://www.youtube.com/embed/$youtubeCode"></iframe>';

    return SizedBox(
      // height: height,
      // width: width,
      child: HtmlWidget(
        content,
        factoryBuilder: () => _YoutubeIframeWidgetFactory(),
      ),
    );
  }
}

class _YoutubeIframeWidgetFactory extends WidgetFactory with WebViewFactory {
  @override
  bool get webViewMediaPlaybackAlwaysAllow => true;
  @override
  String? get webViewUserAgent => 'Lang Learning';
}



