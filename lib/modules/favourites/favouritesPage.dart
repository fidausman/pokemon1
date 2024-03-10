import 'package:app/modules/favourites/bloc/favourites_bloc.dart';
import 'package:app/modules/pokemon_grid/widgets/poke_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavouritesList extends StatefulWidget {
  const FavouritesList({super.key});

  @override
  State<FavouritesList> createState() => _FavouritesListState();
}

class _FavouritesListState extends State<FavouritesList> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesBloc>().add(LoadFavourites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Pokemons')),
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is RemoveFavouritesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favourite Removed')));
          } else if (state is RemoveFavouritesError) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Favourite not removed')));
          }
        },
        builder: (context, state) {
          if (state is LoadingFavourites) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouritesSuccess) {
            if (state.favPokemons.isEmpty) {
              return const Center(child: Text('No Favourite Pokemons'));
            } else {
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: state.favPokemons.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      children: [
                        PokeItemWidget(
                          pokemon: state.favPokemons[index],
                        ),
                        IconButton(
                            onPressed: () async {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              context.read<FavouritesBloc>().add(
                                    RemoveFavourites(
                                        email: pref.getString('email')!,
                                        PokemonNo:
                                            state.favPokemons[index].number),
                                  );
                            },
                            icon: const Icon(Icons.close))
                      ],
                    );
                  });
            }
          }
          return const Center(child: Text('Loading Favourites failed'));
        },
      ),
    );
  }
}
