import 'package:http/http.dart' as http;
import 'package:pokedexapp/pokedex/models/pokemon_page_response.dart';

class PokemonRepo {
  final baseUrl = "pokeapi.co";
  Future<PokemonPageResponse> getPokemonPage(int pageIndex) async {
    final queryParameters = {
      "limit": "200",
      "offset": (pageIndex * 200).toString(),
    };

    final uri = Uri.https(baseUrl, "/api/v2/pokemon", queryParameters);
    final response = await http.get(uri);
    // print(PokemonPageResponse.fromJson(response.body));

    return PokemonPageResponse.fromJson(response.body);
  }

  Future<PokemonInfoResponse?> getPokemonInfo(int pokemonId) async {
    try {
      final uri = Uri.https(baseUrl, "/api/v2/pokemon/$pokemonId");
      final response = await http.get(uri);
      // print(jsonDecode(response.body));
      return PokemonInfoResponse.fromJson(response.body);
    } catch (e) {
      print("Error in pokemoninfo = $e");
      return null;
    }
  }

  Future<PokemonSpeciesInfoResponse?> getPokemonSpeciesInfo(
      int pokemonId) async {
    try {
      final uri = Uri.https(baseUrl, "/api/v2/pokemon-species/$pokemonId");
      final response = await http.get(uri);
      // print(jsonDecode(response.body));
      return PokemonSpeciesInfoResponse.fromJson(response.body);
    } catch (e) {
      print("Error in pokemonspeciesinfo = $e");
      return null;
    }
  }
}
