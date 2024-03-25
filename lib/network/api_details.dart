import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiDetails {
  String link = "https://api.themoviedb.org/3/movie/";

  Future<Map<String, dynamic>> getDetails(String id) async {
    Uri url = Uri.parse(
        "$link$id?api_key=360b4479be6b1d954960e8b402a886c8&append_to_response=videos,credits");
    var result = await http.get(url);
    if (result.statusCode == 200) {
      var datos = json.decode(result.body);
      print(datos);
      return datos;
    }
    return {'error': "Error inesperado"};
  }
}