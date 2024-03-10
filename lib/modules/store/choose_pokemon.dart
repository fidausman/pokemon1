import 'package:app/modules/favourites/bloc/favourites_bloc.dart';
import 'package:app/modules/pokemon_grid/widgets/poke_item.dart';
import 'package:app/modules/store/store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChoosePokemon extends StatefulWidget {
  const ChoosePokemon({super.key});

  @override
  State<ChoosePokemon> createState() => _ChoosePokemonState();
}

class _ChoosePokemonState extends State<ChoosePokemon> {
  @override
  void initState() {
    super.initState();
    context.read<FavouritesBloc>().add(LoadFavourites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Pokemon from favourites')),
      body: BlocConsumer<FavouritesBloc, FavouritesState>(
        listener: (context, state) {
          if (state is RemoveFavouritesSuccess) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Favourite Removed')));
          } else if (state is RemoveFavouritesError) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text('Favourite not removed')));
          }
        },
        builder: (context, state) {
          if (state is LoadingFavourites) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavouritesSuccess) {
            if (state.favPokemons.isEmpty) {
              return const Center(
                  child: Text(
                      'No Favourite Pokemons Add Favourite pokemons first'));
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
                            String imageUrl = state.favPokemons[index].imageUrl;
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TShirtPage(
                                        ImageUrl: imageUrl,
                                      )),
                            );
                          },
                          icon: const Icon(Icons.check))
                    ],
                  );
                },
              );
            }
          }
          return const Center(child: Text('Loading Favourites failed'));
        },
      ),
    );
  }
}
