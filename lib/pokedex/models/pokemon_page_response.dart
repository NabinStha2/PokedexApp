import 'dart:convert';

/*{
"count": 1118,
"next": "https://pokeapi.co/api/v2/pokemon?offset=100&limit=100",
"previous": null,
"results": [
{
"name": "bulbasaur",
"url": "https://pokeapi.co/api/v2/pokemon/1/"
},
{
"name": "ivysaur",
"url": "https://pokeapi.co/api/v2/pokemon/2/"
},
],
}*/
import 'package:flutter/material.dart';

class PokemonListing {
  final int id;
  final String name;

  String get imageUrl =>
      "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png";

  PokemonListing({required this.id, required this.name});

  factory PokemonListing.fromMap(Map<String, dynamic> map) {
    // print(map.values);
    final url = map['url'] as String;
    final name = map['name'];
    final id = int.parse(url.split("/")[6]);
    return PokemonListing(id: id, name: name);
  }

  factory PokemonListing.fromJson(String source) =>
      PokemonListing.fromMap(json.decode(source));
}

class PokemonPageResponse {
  final List<PokemonListing> pokemonListings;
  final bool canLoadNextPage;

  PokemonPageResponse({
    required this.pokemonListings,
    required this.canLoadNextPage,
  });

  factory PokemonPageResponse.fromMap(Map<String, dynamic> map) {
    final canLoadNextPage = map["next"] != null;
    final pokemonListings = (map['results'] as List)
        .map((listingJson) => PokemonListing.fromMap(listingJson))
        .toList();

    return PokemonPageResponse(
      canLoadNextPage: canLoadNextPage,
      pokemonListings: pokemonListings,
    );
  }

  factory PokemonPageResponse.fromJson(String source) {
    return PokemonPageResponse.fromMap(json.decode(source));
  }
}

class PokemonInfoResponse {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  PokemonInfoResponse({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
  });

  factory PokemonInfoResponse.fromMap(Map<String, dynamic> map) {
    final types = (map["types"] as List)
        .map((typeJson) => typeJson["type"]["name"].toString())
        .toList();
    // final types = map["types"][0]["type"]["name"].toString() as List;
    return PokemonInfoResponse(
      id: map['id'],
      name: map['name'],
      imageUrl: map['sprites']["front_default"],
      // types: List<String>.from(map['types']),
      types: types,
      height: map['height'],
      weight: map['weight'],
    );
  }

  factory PokemonInfoResponse.fromJson(String source) =>
      PokemonInfoResponse.fromMap(json.decode(source));
}

class PokemonSpeciesInfoResponse {
  final String description;
  PokemonSpeciesInfoResponse({
    required this.description,
  });

  factory PokemonSpeciesInfoResponse.fromMap(Map<String, dynamic> map) {
    // print(map);
    return PokemonSpeciesInfoResponse(
      description: map['flavor_text_entries'][0]['flavor_text'],
    );
  }

  factory PokemonSpeciesInfoResponse.fromJson(String source) =>
      PokemonSpeciesInfoResponse.fromMap(json.decode(source));
}

class PokemonDetails {
  final int id;
  final String name;
  final String imageUrl;
  final List<String> types;
  final int height;
  final int weight;
  final String description;

  PokemonDetails({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.types,
    required this.height,
    required this.weight,
    required this.description,
  });
}
