part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsState extends Equatable {
  const PokemonDetailsState();

  @override
  List<Object> get props => [];
}

class PokemonDetailsInitial extends PokemonDetailsState {}

class PokemonDetailsLoading extends PokemonDetailsState {}

class PokemonDetailsSuccess extends PokemonDetailsState {
  final PokemonDetails? pokemonDetails;
  const PokemonDetailsSuccess({
    @required this.pokemonDetails,
  });

  // @override
  // List<Object> get props => [pokemonDetails];
}

class PokemonDetailsError extends PokemonDetailsState {
  final String? error;
  const PokemonDetailsError({
    @required this.error,
  });
  // @override
  // List<Object> get props => [error];
}
