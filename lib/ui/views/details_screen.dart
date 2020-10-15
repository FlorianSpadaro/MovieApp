import 'package:flutter/material.dart';
import 'package:tmdbapp/core/models/movie.dart';
import 'package:tmdbapp/core/services/api.dart';
import 'package:tmdbapp/ui/shared/app_colors.dart';
import 'package:tmdbapp/ui/shared/app_styles.dart';
import 'package:tmdbapp/ui/widgets/loading_widget.dart';

class DetailsScreen extends StatefulWidget {
  final Movie movie;

  DetailsScreen({@required this.movie});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  Api api;

  @override
  void initState() {
    super.initState();
    api = Api();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Movie>(
      future: api.getFullDetailsMovie(widget.movie.id, widget.movie.isTvShow),
      builder: (_, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Movie movie = snapshot.data;
          return Stack(
            children: [
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(movie.image),
                  ))),
              Scaffold(
                backgroundColor: Colors.transparent,
                appBar: AppBar(
                  backgroundColor: Colors.transparent.withOpacity(0.3),
                ),
                body: ListView(
                  children: [
                    Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                kMainColor,
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0, 0.17])),
                      constraints: BoxConstraints(
                          minHeight: MediaQuery.of(context).size.height * 0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kMainTitleTextStyle,
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    movie == null ? '' : movie.age ?? '10+',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text("-",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15.0)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(movie.date.year.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900,
                                          fontSize: 15.0)),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 15.0),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Icon(
                                    Icons.grade,
                                    color: Colors.orangeAccent,
                                    size: 15.0,
                                  ),
                                ),
                                Text(
                                  movie.rate.toString(),
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15.0),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Wrap(
                                spacing: 8.0,
                                runSpacing: 8.0,
                                children: List<Widget>.generate(
                                    movie.genres.length,
                                    (index) =>
                                        GenreMovie(title: movie.genres[index])),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 17.0),
                                          children: [
                                        TextSpan(
                                            text: "Cast: ",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold)),
                                        TextSpan(
                                            text: movie != null
                                                ? movie.displayCasting()
                                                : '',
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ])),
                                ),
                                Container(
                                  child: Text(
                                    "Summary",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17.0),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 10.0),
                                  child: Text(
                                    movie.overview,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 15.0),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        } else if (snapshot.hasError) {
          return ErrorWidget(snapshot.error);
        }
        return LoadingWidget();
      },
    );
  }
}

class GenreMovie extends StatelessWidget {
  final String title;

  GenreMovie({@required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Color(0XFFFEFEFF),
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      child: Text(
        title,
        style: TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
      ),
    );
  }
}
