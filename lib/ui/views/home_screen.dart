import 'package:flutter/material.dart';
import 'package:tmdbapp/core/constants/route_paths.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/core/services/api.dart';
import 'package:tmdbapp/core/services/authentication.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAlertDialog(context),
        backgroundColor: kThirdColor,
        child: Icon(Icons.logout),
      ),
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

void logOut(BuildContext context) {
  Authentication.signOut()
      .then((value) => Navigator.popAndPushNamed(context, RoutePaths.Login));
}

showAlertDialog(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () => Navigator.pop(context),
  );

  Widget logOutButton = FlatButton(
    child: Text(
      "Log out",
      style: TextStyle(color: Colors.red),
    ),
    onPressed: () {
      Navigator.pop(context);
      logOut(context);
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Sign Out"),
    content: Text("Do you want to log out?"),
    actions: [
      cancelButton,
      logOutButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
