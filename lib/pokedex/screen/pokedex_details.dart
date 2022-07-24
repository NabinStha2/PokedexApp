

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokedexapp/pokedex/bloc/pokemon_details_bloc.dart';

class PokedexDetails extends StatefulWidget {
  final int pokemonId;
  const PokedexDetails({
    Key? key,
    required this.pokemonId,
  }) : super(key: key);
  @override
  _PokedexDetailsState createState() => _PokedexDetailsState();
}

class _PokedexDetailsState extends State<PokedexDetails> {
  @override
  void initState() {
    BlocProvider.of<PokemonDetailsBloc>(context).add(ClearPokemonDetails());
    BlocProvider.of<PokemonDetailsBloc>(context)
        .add(GetPokemonDetails(pokemonId: widget.pokemonId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      backgroundColor: Color(0xFFF2F2F2),
      body: BlocBuilder<PokemonDetailsBloc, PokemonDetailsState>(
        builder: (context, state) {
          return state is PokemonDetailsSuccess && state.pokemonDetails != null
              ? Center(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Card(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(state.pokemonDetails!.imageUrl),
                              Text(state.pokemonDetails!.name),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: state.pokemonDetails!.types
                                    .map((type) => _pokemonTypeView(type))
                                    .toList(),
                              ),
                              Text(
                                'ID: ${state.pokemonDetails!.id}  -  Weight: ${state.pokemonDetails!.weight}  -  Height: ${state.pokemonDetails!.height}',
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: SizedBox(
                          width: double.infinity,
                          child: Card(
                            elevation: 5.0,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                state.pokemonDetails!.description,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: GoogleFonts.ubuntu().fontFamily,
                                  fontSize: 20.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Widget _pokemonTypeView(String type) {
    Color color;

    switch (type) {
      case 'normal':
        color = Color(0xFFbdbeb0);
        break;
      case 'poison':
        color = Color(0xFF995E98);
        break;
      case 'psychic':
        color = Color(0xFFE96EB0);
        break;
      case 'grass':
        color = Color(0xFF9CD363);
        break;
      case 'ground':
        color = Color(0xFFE3C969);
        break;
      case 'ice':
        color = Color(0xFFAFF4FD);
        break;
      case 'fire':
        color = Color(0xFFE7614D);
        break;
      case 'rock':
        color = Color(0xFFCBBD7C);
        break;
      case 'dragon':
        color = Color(0xFF8475F7);
        break;
      case 'water':
        color = Color(0xFF6DACF8);
        break;
      case 'bug':
        color = Color(0xFFC5D24A);
        break;
      case 'dark':
        color = Color(0xFF886958);
        break;
      case 'fighting':
        color = Color(0xFF9E5A4A);
        break;
      case 'ghost':
        color = Color(0xFF7774CF);
        break;
      case 'steel':
        color = Color(0xFFC3C3D9);
        break;
      case 'flying':
        color = Color(0xFF81A2F8);
        break;
      case 'normal':
        color = Color(0xFFF9E65E);
        break;
      case 'fairy':
        color = Color(0xFFEEB0FA);
        break;
      default:
        color = Colors.black;
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Text(
          type.toUpperCase(),
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
