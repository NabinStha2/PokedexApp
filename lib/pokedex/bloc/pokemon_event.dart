part of 'pokemon_bloc.dart';

@immutable
abstract class PokemonEvent extends Equatable {}

class PokemonPageRequest extends PokemonEvent {
  final int page;

  PokemonPageRequest({required this.page});

  @override
  List<Object> get props => [page];
}
