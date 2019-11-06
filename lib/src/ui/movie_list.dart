import 'package:arquitetura_bloc/src/models/item_model.dart';
import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filmes Populares"),
      ),
      body: StreamBuilder(builder: (context, AsyncSnapshot<ItemModel> snapshot) {
        if (snapshot.hasData)
          return buildList(snapshot);
        else if (snapshot.hasError) return Text(snapshot.error.toString());
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );
  }

  Widget buildList(AsyncSnapshot<ItemModel> snapshot) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          return Image.network(
            'https://image.tmdb.org/t/p/w185${snapshot.data.results[index].posterPath}',
            fit: BoxFit.cover,
          );
        });
  }
}
