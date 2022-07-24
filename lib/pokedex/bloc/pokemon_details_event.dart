part of 'pokemon_details_bloc.dart';

abstract class PokemonDetailsEvent extends Equatable {
  const PokemonDetailsEvent();

  @override
  List<Object> get props => [];
}

class GetPokemonDetails extends PokemonDetailsEvent {
  final int pokemonId;

  GetPokemonDetails({required this.pokemonId});

  @override
  List<Object> get props => [pokemonId];
}

class ClearPokemonDetails extends PokemonDetailsEvent {}
