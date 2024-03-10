import 'dart:async';

import 'package:app/modules/favourites/bloc/favourites_bloc.dart';
import 'package:app/shared/models/pokemon_summary.dart';
import 'package:app/shared/repositories/favourites_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'favourites_event.dart';
part 'favourites_state.dart';

class FavouritesBloc extends Bloc<FavouritesEvent, FavouritesState> {
  FavouritesBloc() : super(FavouritesInitial()) {
    on<LoadFavourites>(fetchFavourites);

    on<AddFavourites>(addFavourites);

    on<RemoveFavourites>(removeFavourites);
  }

  FutureOr<void> fetchFavourites(
      LoadFavourites event, Emitter<FavouritesState> emit) async {
    emit(LoadingFavourites());
    try {
      final List<PokemonSummary> pokemons =
          await FavouritesService.instance.getFavourites();
      emit(FavouritesSuccess(favPokemons: pokemons));
    } catch (e) {
      emit(FavouritesError());
    }
  }

  FutureOr<void> removeFavourites(
      RemoveFavourites event, Emitter<FavouritesState> emit) async {
    emit(RemoveFavouritesLoading());
    try {
      final result =
          await FavouritesService.instance.removeFavourite(event.PokemonNo);
      if (result) {
        emit(RemoveFavouritesSuccess());
      } else {
        emit(RemoveFavouritesError());
      }
    } catch (e) {
      emit(RemoveFavouritesError());
    }
  }

  FutureOr<void> addFavourites(
      AddFavourites event, Emitter<FavouritesState> emit) async {
    emit(AddFavouritesLoading());
    try {
      final result =
          await FavouritesService.instance.addFavourite(event.PokemonNo);
      if (result) {
        emit(AddFavouritesSuccess());
      } else {
        emit(AddFavouritesError());
      }
    } catch (e) {
      emit(AddFavouritesError());
    }
  }
}
