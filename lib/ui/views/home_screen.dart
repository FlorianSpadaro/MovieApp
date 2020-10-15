import 'package:flutter/material.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/core/services/api.dart';
import 'package:tmdbapp/ui/widgets/movies_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Api api;

  @override
  void initState() {
    super.initState();
    api = Api();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            MoviesListWidget(
                moviesFuture: api.getPopularMovies(),
                title: 'Popular Movies',
                isTvShow: false),
            MoviesListWidget(
                moviesFuture: api.getPopularTvShows(),
                title: 'Popular TV Shows',
                isTvShow: true),
            MoviesListWidget(
                moviesFuture: api.getBestMovies(),
                title: 'Best Movies',
                isTvShow: false),
          ],
        ),
      ),
    );
  }
}

class MoviesListWidget extends StatelessWidget {
  final Future<List<Movie>> moviesFuture;
  final String title;
  final bool isTvShow;

  MoviesListWidget(
      {@required this.moviesFuture,
      @required this.title,
      @required this.isTvShow});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.31,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(8.0),
      child: MoviesWidget(
        moviesFuture: moviesFuture,
        isTvShow: isTvShow,
        title: title,
      ),
    );
  }
}
