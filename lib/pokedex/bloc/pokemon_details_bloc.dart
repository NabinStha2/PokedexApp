import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pokedexapp/pokedex/models/pokemon_page_response.dart';
import 'package:pokedexapp/pokedex/repo/pokemon_repo.dart';

part 'pokemon_details_event.dart';
part 'pokemon_details_state.dart';

class PokemonDetailsBloc
    extends Bloc<PokemonDetailsEvent, PokemonDetailsState> {
  final _pokemonRepo = PokemonRepo();

  PokemonDetailsBloc() : super(PokemonDetailsInitial());

  @override
  Stream<PokemonDetailsState> mapEventToState(
    PokemonDetailsEvent event,
  ) async* {
    yield PokemonDetailsLoading();

    if (event is GetPokemonDetails) {
      // print("hey--- ${event.pokemonId}");
      try {
        final responses = await Future.wait([
          _pokemonRepo.getPokemonInfo(event.pokemonId),
          _pokemonRepo.getPokemonSpeciesInfo(event.pokemonId),
        ]);
        final pokemonInfo = responses[0] as PokemonInfoResponse;
        final pokemonSpeciesInfo = responses[1] as PokemonSpeciesInfoResponse;

        final PokemonDetails res = PokemonDetails(
          id: pokemonInfo.id,
          name: pokemonInfo.name,
          imageUrl: pokemonInfo.imageUrl,
          types: pokemonInfo.types,
          height: pokemonInfo.height,
          weight: pokemonInfo.weight,
          description: pokemonSpeciesInfo.description,
        );

        yield PokemonDetailsSuccess(pokemonDetails: res);
      } catch (e) {
        yield PokemonDetailsError(error: e.toString());
        // print("Err = ${e.message}");
      }
    } else if (event is ClearPokemonDetails) {
      yield const PokemonDetailsSuccess(pokemonDetails: null);
    }
  }
}
