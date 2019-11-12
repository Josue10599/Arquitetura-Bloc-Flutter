import 'package:arquitetura_bloc/src/blocs/movie_detail_bloc_provider.dart';
import 'package:arquitetura_bloc/src/blocs/movies_bloc.dart';
import 'package:arquitetura_bloc/src/models/item_model.dart';
import 'package:arquitetura_bloc/src/ui/movie_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  void initState() {
    bloc.fetchAllMovies();
    super.initState();
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        return _cardOfMovie(snapshot.data, index);
      },
    );
  }

  Widget _cardOfMovie(ItemModel item, int index) =>
      Padding(
        padding: const EdgeInsets.all(4.0),
        child: GridTile(
          footer: _nameMovie(item, index),
          child: Card(
            elevation: 8.0,
            color: Colors.black,
            child: InkResponse(
              onTap: () => _openDetailPage(item, index),
              enableFeedback: true,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[_imageMovie(item, index)],
              ),
            ),
          ),
        ),
      );

  Widget _nameMovie(ItemModel item, int index) =>
      Container(
        margin: EdgeInsets.all(4.0),
        color: Color(0x8F000000),
        child: Text(
          item.results[index].title,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14.0,
          ),
        ),
      );

  Widget _imageMovie(ItemModel item, int index) =>
      Image.network(
        'https://image.tmdb.org/t/p/w185${item.results[index].posterPath}',
        fit: BoxFit.fill,
        height: 155.0,
      );

  _openDetailPage(ItemModel item, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return MovieDetailBlocProvider(
          child: MovieDetail(
            title: item.results[index].title,
            posterUrl: item.results[index].posterPath,
            description: item.results[index].overview,
            releaseDate: item.results[index].releaseDate,
            voteAverage: item.results[index].voteAverage.toString(),
            movieId: item.results[index].id,
          ),
        );
      }),
    );
  }
}
