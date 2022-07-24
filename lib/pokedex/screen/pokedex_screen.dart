
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedexapp/pokedex/bloc/pokemon_bloc.dart';

class PokedexScreen extends StatefulWidget {
  @override
  _PokedexScreenState createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  // @override
  // void initState() {
  //   BlocProvider.of<PokemonBloc>(context).add(PokemonPageRequest(page: 0));
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pokedex"),
        centerTitle: true,
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(
        builder: (context, state) {
          if (state is LoadingPokemon) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LoadedPokemonSuccess) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(Duration(seconds: 2));
                BlocProvider.of<PokemonBloc>(context)
                    .add(PokemonPageRequest(page: 0));
              },
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                ),
                itemCount: state.pokemonListings.length,
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        "/pokedexDetails",
                        arguments: state.pokemonListings[index].id,
                      );
                    },
                    child: Card(
                      elevation: 8.0,
                      child: GridTile(
                        child: Column(
                          children: [
                            Image.network(
                                state.pokemonListings[index].imageUrl),
                            Text(state.pokemonListings[index].name),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (state is LoadedPokemonError) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Container();
        },
      ),
    );
  }
}
