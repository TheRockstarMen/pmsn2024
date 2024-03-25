class FavoriteModel {
  int? id;
  String? posterPath;

  FavoriteModel({this.id, this.posterPath});

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id_movie'],
      posterPath: map['posterPath'],
    );
  }
}