import 'package:tmdbapp/core/constants/api_constants.dart';

class Movie {
  int id;
  String image;
  String backdropImage;
  String title;
  String age;
  DateTime date;
  double rate;
  List<String> genres;
  String overview;
  List<String> casting;
  bool isTvShow;

  Movie(
      {this.id,
      this.image,
      this.backdropImage,
      this.title,
      this.age,
      this.date,
      this.rate,
      this.genres,
      this.overview,
      this.casting,
      this.isTvShow});

  Movie.fromJSON(json, bool isTvShow) {
    this.id = json['id'];
    this.image = ApiConstants.imageUrl + json['poster_path'];
    this.backdropImage = ApiConstants.imageUrl + json['backdrop_path'];
    this.title = isTvShow ? json['original_name'] : json['original_title'];
    this.date = isTvShow
        ? DateTime.parse(json['first_air_date'])
        : DateTime.parse(json['release_date']);
    this.isTvShow = isTvShow;
    this.rate = json['vote_average'].toDouble();
    this.overview = json['overview'];
    this.casting = [];
    this.genres = [];
    json['genres']?.forEach(
      (genre) => this.genres.add(genre['name']),
    );
  }

  String displayCasting() {
    int maxLength = 4; //Nombre de personnes du casting à afficher au maximum
    String casting = '';
    maxLength =
        this.casting.length > maxLength ? maxLength : this.casting.length;
    for (int i = 0; i < maxLength; i++) {
      casting += this.casting[i];
      if (i < maxLength - 1) {
        casting += ', ';
      }
    }
    return casting;
  }
}
