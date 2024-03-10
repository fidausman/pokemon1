part of 'favourites_bloc.dart';

sealed class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

final class FavouritesInitial extends FavouritesState {}

final class LoadingFavourites extends FavouritesState {}

final class FavouritesSuccess extends FavouritesState {
  final List<PokemonSummary> favPokemons;

  FavouritesSuccess({required this.favPokemons});
}

final class FavouritesError extends FavouritesState {}

final class RemoveFavouritesLoading extends FavouritesState {}

final class RemoveFavouritesSuccess extends FavouritesState {}

final class RemoveFavouritesError extends FavouritesState {}


final class AddFavouritesLoading extends FavouritesState {}

final class AddFavouritesSuccess extends FavouritesState {}

final class AddFavouritesError extends FavouritesState {}
