import 'dart:convert';

import 'package:arquitetura_bloc/api.dart';
import 'package:arquitetura_bloc/src/models/item_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' show Client;

class MovieApiProvider {
  Client client = Client();
  final _apiKey = apiKey;

  Future<ItemModel> fetchMovieList() async {
    debugPrint('entered');
    final response = await client.get('http://api.themoviedb.org/3/movie/popular?api_key=$_apiKey');
    debugPrint(response.body.toString());
    if (response.statusCode == 200) {
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }
}
