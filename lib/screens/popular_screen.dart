import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../model/popular_model.dart';
import '../network/api_popular.dart';
import '../widgets/item_popular.dart';
import 'package:pmsn2024/responsive.dart';

class PopularScreen extends StatefulWidget {
  const PopularScreen({super.key});

  @override
  State<PopularScreen> createState() => _PopularScreenState();
}

class _PopularScreenState extends State<PopularScreen> {
  ApiPopular? apiPopular;
  List<PopularModel>? listPopu;
  List<PopularModel>? listTopRanked;
  List<PopularModel>? listNowPlaying;
  List<PopularModel>? listUpcoming;
  Random random = Random();
  @override
  void initState() {
    super.initState();
    apiPopular = ApiPopular();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

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
            return Responsive(
              desktop: getBody(true),
              tablet: getBody(true),
              mobile: getBody(false),
            );
        }
      },
    );
  }

  Widget getBody(bool isDesktop) {
    return ListView(
        padding: const EdgeInsets.only(top: 0, bottom: 105),
        children: [
          banner(isDesktop),
          getPopular(),
          getTopRanked(),
          const Text(
            "Recommended",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          getRecomend(listPopu![random.nextInt(20)], isDesktop),
          getNowPlaying(),
          getUpcoming(),
          const Text(
            "Top Ranked",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          ),
          getRecomend(listTopRanked![random.nextInt(20)], isDesktop),
        ]);
  }

  Widget banner(bool isDesktop) {
    return Container(
      height: 400,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20)),
          image: DecorationImage(
              image: NetworkImage(isDesktop
                  ? 'https://image.tmdb.org/t/p/w500${listPopu![0].backdropPath!}'
                  : 'https://image.tmdb.org/t/p/w500${listPopu![0].posterPath!}'),
              fit: BoxFit.cover)),
      child: Container(
        padding: const EdgeInsets.only(left: 20, bottom: 10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black])),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                listPopu![0].title!,
                style: const TextStyle(color: Colors.white, fontSize: 22),
              ),
              Container(
                height: 60,
                margin: const EdgeInsets.all(8),
                child: Text(
                  listPopu![0].overview!,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                ),
              ),
              Container(
                  margin: const EdgeInsets.fromLTRB(25, 8, 25, 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.white,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () {},
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                              ),
                              Text(
                                "Watch now",
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          )),
                      const Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                    ],
                  ))
            ]),
      ),
    );
  }

  Widget getPopular() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Popular",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ItemPopular(popularModel: listPopu![index]),
                  );
                },
                itemCount: listPopu!.length))
      ]),
    );
  }

  Widget getTopRanked() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Top ranked",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ItemPopular(popularModel: listTopRanked![index]),
                  );
                },
                itemCount: listTopRanked!.length))
      ]),
    );
  }

  Widget getNowPlaying() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Now Playing",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ItemPopular(popularModel: listNowPlaying![index]),
                  );
                },
                itemCount: listNowPlaying!.length))
      ]),
    );
  }

  Widget getUpcoming() {
    return Container(
      width: double.infinity,
      height: 300,
      margin: const EdgeInsets.all(10),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            "Up coming",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
        Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: ItemPopular(popularModel: listUpcoming![index]),
                  );
                },
                itemCount: listUpcoming!.length))
      ]),
    );
  }

  Widget getRecomend(PopularModel popularModel, bool isDesktop) {
    return SizedBox(
      height: 300,
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(isDesktop
                        ? 'https://image.tmdb.org/t/p/w500${popularModel.backdropPath}'
                        : 'https://image.tmdb.org/t/p/w500${popularModel.posterPath}'),
                    fit: BoxFit.fill)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        Text(
                          "Watch now",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )),
                const Icon(
                  Icons.info,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  initData() async {
    listPopu = await apiPopular!.getAllPopular();
    listTopRanked = await apiPopular!.getTopRated();
    listNowPlaying = await apiPopular!.getNowPlaying();
    listUpcoming = await apiPopular!.getUpcoming();
  }
}
