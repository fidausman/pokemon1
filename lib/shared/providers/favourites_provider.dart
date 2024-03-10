import 'dart:developer';

import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/repositories/auth_interceptor.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

enum FavouritesState { init, loading, loaded, error }

class FavouritesProvider extends ChangeNotifier {
  FavouritesProvider(BuildContext context) {
    _dio = favService.getDio();
    _dio.interceptors.add(AuthInterceptor(
      dio: _dio,
    ));
  }

  late Dio _dio;

  late bool _isFav = false;
  late List<PokemonSummary> _favourites = [];
  late FavouritesState _state = FavouritesState.init;

  FavouritesService favService = FavouritesService.instance;

  void changeState(FavouritesState newState) {
    _state = newState;
    notifyListeners();
  }

  void checkIfCurrentIsFavourite(
      BuildContext context, PokemonSummary currentPokemon) {
    log(_favourites.toString());
    if (_favourites.contains(currentPokemon)) {
      _isFav = true;
      log(_isFav.toString());
    } else {
      _isFav = false;
      log(_isFav.toString());
    }
    notifyListeners();
  }

  bool check(PokemonSummary pokemon) {
    log(_favourites.contains(pokemon).toString());
    return _favourites.contains(pokemon);
  }

  Future<bool> addFavourite(
    BuildContext context,
    String favourite,
  ) async {
    changeState(FavouritesState.loading);

    final bool result = await favService.addFavourite(favourite);
    _isFav = result;
    notifyListeners();
    changeState(FavouritesState.loaded);
    return result;
  }

  Future<bool> removeFavourite(
    BuildContext context,
    String favourite,
  ) async {
    changeState(FavouritesState.loading);

    final bool result = await favService.removeFavourite(favourite);
    _isFav = !result;
    _favourites.removeWhere((element) => element.number == favourite);

    changeState(FavouritesState.loaded);
    notifyListeners();

    return result;
  }

  Future<List<PokemonSummary>> fetchFavourites(BuildContext context) async {
    changeState(FavouritesState.loading);

    try {
      final List<PokemonSummary> result = await favService.getFavourites();
      _favourites = result;

      changeState(FavouritesState.loaded);
      notifyListeners();
      log(_favourites.toString());
      return _favourites;
    } catch (e) {
      changeState(FavouritesState.error);
      notifyListeners();
      return [];
    }
  }

  void clearFavourites() {
    _favourites.clear();
    changeState(FavouritesState.init);
    changeState(FavouritesState.loading);
    notifyListeners();
  }

  @override
  void dispose() {
    _dio.interceptors.clear();
    super.dispose();
  }

  List<PokemonSummary> get favourites {
    _favourites
        .sort((a, b) => int.parse(a.number).compareTo(int.parse(b.number)));
    return _favourites;
  }

  FavouritesState get state => _state;
  bool get isFavourite => _isFav;
}
