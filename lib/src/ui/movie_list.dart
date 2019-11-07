import 'package:arquitetura_bloc/src/blocs/movies_bloc.dart';
import 'package:arquitetura_bloc/src/models/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bloc.fetchAllMovies();
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Populares"),
      ),
      body: StreamBuilder(
        stream: bloc.allMovies,
        builder: (context, AsyncSnapshot<ItemModel> snapshot) {
          if (snapshot.hasData)
            return buildList(snapshot);
          else if (snapshot.hasError) return Text(snapshot.error.toString());
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
      itemCount: snapshot.data.results.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return _cardOfMovie(snapshot.data.results[index].title,
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}');
      },
    );
  }

  Widget _cardOfMovie(String name, String urlImage) =>
      Card(
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _imageMovie(urlImage),
            _nameMovie(name),
          ],
        ),
      );

  Widget _nameMovie(String name) =>
      Container(
        margin: EdgeInsets.all(4.0),
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      );

  Widget _imageMovie(String url) =>
      AspectRatio(
        aspectRatio: 3 / 2,
        child: Image.network(
          url,
          fit: BoxFit.fitHeight,
        ),
      );
}
