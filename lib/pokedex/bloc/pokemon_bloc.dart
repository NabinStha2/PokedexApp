import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:pokedexapp/pokedex/models/pokemon_page_response.dart';
import 'package:pokedexapp/pokedex/repo/pokemon_repo.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepo = PokemonRepo();
  PokemonBloc() : super(InitialPokemon());

  @override
  Stream<PokemonState> mapEventToState(
    PokemonEvent event,
  ) async* {
    if (event is PokemonPageRequest) {
      yield LoadingPokemon();
      try {
        final pokemonPageResponse =
            await _pokemonRepo.getPokemonPage(event.page);
        print(pokemonPageResponse.pokemonListings.map((e) => e.id));
        yield LoadedPokemonSuccess(
          canLoadNextPage: pokemonPageResponse.canLoadNextPage,
          pokemonListings: pokemonPageResponse.pokemonListings,
        );
      } catch (e) {
        yield LoadedPokemonError(error: e.toString());
      }
    }
  }
}
