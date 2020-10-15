import 'package:flutter/material.dart';
import 'package:tmdbapp/core/constants/route_paths.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/shared/app_styles.dart';
import 'package:tmdbapp/ui/widgets/loading_widget.dart';

class MoviesWidget extends StatefulWidget {
  final String title;
  final Future<List<Movie>> moviesFuture;
  final bool isTvShow;

  MoviesWidget(
      {@required this.title,
      @required this.moviesFuture,
      @required this.isTvShow});

  @override
  _MoviesWidgetState createState() => _MoviesWidgetState();
}

class _MoviesWidgetState extends State<MoviesWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: kMainTitleTextStyle,
        ),
        Expanded(
          child: FutureBuilder<List<Movie>>(
            future: widget.moviesFuture,
            builder: (_, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<Movie> movies = snapshot.data;

                return ListView.builder(
                  itemCount: movies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, index) {
                    var movie = movies[index];
                    return InkWell(
                      onTap: () => Navigator.pushNamed(
                          context, RoutePaths.Details,
                          arguments: movie),
                      child: Container(
                          margin: const EdgeInsets.all(8.0),
                          width: 100.0,
                          decoration: movie.image == null
                              ? BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: kSecondaryColor,
                                )
                              : BoxDecoration(
                                  borderRadius: BorderRadius.circular(5.0),
                                  color: kSecondaryColor,
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(movie.image),
                                  ))),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return ErrorWidget(snapshot.error);
              }
              return LoadingWidget();
            },
          ),
        ),
      ],
    );
  }
}
