part of 'pokemon_bloc.dart';

abstract class PokemonState extends Equatable {
  @override
  List<Object> get props => [];
}

class InitialPokemon extends PokemonState {}

class LoadingPokemon extends PokemonState {}

class LoadedPokemonSuccess extends PokemonState {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;
  LoadedPokemonSuccess({
    required this.pokemonListings,
    required this.canLoadNextPage,
  });

  @override
  List<Object> get props => [pokemonListings, canLoadNextPage];
}

class LoadedPokemonError extends PokemonState {
  final String error;
  LoadedPokemonError({
    required this.error,
  });
  @override
  List<Object> get props => [error];
}
