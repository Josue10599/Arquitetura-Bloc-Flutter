import 'package:arquitetura_bloc/src/models/item_model.dart';
import 'package:arquitetura_bloc/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  final _repository = Repository();
  final _moviesFetcher = PublishSubject<ItemModel>();

  Observable<ItemModel> get allMovies => _moviesFetcher.stream;

  void fetchAllMovies() async {
    ItemModel itemModel = await _repository.fetchAllMovies();
    _moviesFetcher.sink.add(itemModel);
  }

  void dispose() {
    _moviesFetcher.close();
  }
}

final bloc = MovieBloc();
