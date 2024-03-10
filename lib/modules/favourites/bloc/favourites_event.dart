part of 'favourites_bloc.dart';

sealed class FavouritesEvent extends Equatable {
  const FavouritesEvent();

  @override
  List<Object> get props => [];
}

class LoadFavourites extends FavouritesEvent {}

class RemoveFavourites extends FavouritesEvent {
  final String email;
  final String PokemonNo;

  RemoveFavourites({required this.email, required this.PokemonNo});
}

class AddFavourites extends FavouritesEvent {
  final String email;
  final String PokemonNo;

  AddFavourites({required this.email, required this.PokemonNo});
}
