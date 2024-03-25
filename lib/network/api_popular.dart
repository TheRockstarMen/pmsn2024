import 'dart:convert';
import '../model/popular_model.dart';
import 'package:http/http.dart' as http;

class ApiPopular {
  Future<List<PopularModel>?> getAllPopular() async {
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=360b4479be6b1d954960e8b402a886c8&page=1');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }

  Future<List<PopularModel>?> getTopRated() async {
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=360b4479be6b1d954960e8b402a886c8&page=1');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }

  Future<List<PopularModel>?> getNowPlaying() async {
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=360b4479be6b1d954960e8b402a886c8&page=1');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }

  Future<List<PopularModel>?> getUpcoming() async {
    Uri link = Uri.parse(
        'https://api.themoviedb.org/3/movie/upcoming?api_key=360b4479be6b1d954960e8b402a886c8&page=1');
    var result = await http.get(link);
    var listJSON = jsonDecode(result.body)['results'] as List;
    if (result.statusCode == 200) {
      return listJSON.map((popular) => PopularModel.fromMap(popular)).toList();
    }
    return null;
  }
}