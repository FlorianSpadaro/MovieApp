import 'dart:convert' as convert;

import 'package:http/http.dart' as http;
import 'package:tmdbapp/core/constants/api_constants.dart';
import 'package:tmdbapp/core/models/movie.dart';

class Api {
  Future _getData(String url) async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return null;
  }

  Future<List<Movie>> _getMovies(String url, bool isTvShow) async {
    List<Movie> movies = [];
    var data = await _getData(url);
    if (data != null) {
      try {
        data['results']
            .forEach((result) => movies.add(Movie.fromJSON(result, isTvShow)));
      } catch (e) {
        print("Error: " + e.toString());
      }
    }
    return movies;
  }

  Future<List<Movie>> getPopularMovies() async {
    String url =
        '${ApiConstants.url}/discover/movie?sort_by=popularity.desc&api_key=${ApiConstants.key}';
    return await _getMovies(url, false);
  }

  Future<List<Movie>> getBestMovies() async {
    String url =
        '${ApiConstants.url}/movie/top_rated?api_key=${ApiConstants.key}';
    return await _getMovies(url, false);
  }

  Future<List<Movie>> getPopularTvShows() async {
    String url = '${ApiConstants.url}/tv/popular?api_key=${ApiConstants.key}';
    return await _getMovies(url, true);
  }

  Future<Movie> getDetailsMovie(int movieId, bool isTvShow) async {
    String url =
        '${ApiConstants.url}/${isTvShow ? 'tv' : 'movie'}/${movieId.toString()}?api_key=${ApiConstants.key}';
    Movie movie;
    var data = await _getData(url);
    if (data != null) {
      movie = Movie.fromJSON(data, isTvShow);
    }
    return movie;
  }

  Future<Movie> getCastingMovie(Movie movie) async {
    String url =
        '${ApiConstants.url}/movie/${movie.id}/credits?api_key=${ApiConstants.key}';
    var data = await _getData(url);
    if (data != null) {
      data['cast'].forEach((cast) => movie.casting.add(cast['name']));
    }
    return movie;
  }

  Future<Movie> getAgeCertificationMovie(Movie movie) async {
    String url =
        '${ApiConstants.url}/movie/${movie.id}/release_dates?api_key=${ApiConstants.key}';
    var data = await _getData(url);
    if (data != null) {
      //J'initialise l'âge à '0+' au cas où il n'y ait pas de spécification d'âge
      movie.age = '0+';

      data['results'].forEach((result) {
        if (result['iso_3166_1'] == 'US') {
          result['release_dates'].forEach((releaseDate) {
            if (releaseDate['certification'] != '') {
              releaseDate['certification'].split('-').forEach((certification) {
                try {
                  if (int.parse(certification) is int) {
                    movie.age = certification.toString() + '+';
                  }
                } catch (e) {}
              });
            }
          });
        }
      });
    }
    return movie;
  }

  Future<Movie> getFullDetailsMovie(int movieId, bool isTvShow) async {
    Movie movie = await getDetailsMovie(movieId, isTvShow);
    movie = await getCastingMovie(movie); //On récupère le casting du film
    movie = await getAgeCertificationMovie(
        movie); //On récupère l'âge requis du film
    return movie;
  }

  Future<Movie> getMostPopularMovie() async {
    List<Movie> popularMovies = await getPopularMovies();
    await Future.delayed(Duration(seconds: 2));
    return popularMovies[0];
  }
}
