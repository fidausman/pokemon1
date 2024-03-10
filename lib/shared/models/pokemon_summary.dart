import 'dart:convert';

import 'package:app/shared/models/pokemon.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

List<PokemonSummary> pokemonSummaryFromJson(String str) =>
    List<PokemonSummary>.from(
        json.decode(str).map((x) => PokemonSummary.fromJson(x)));

class PokemonSummary extends Equatable {
  final String number;
  final String name;
  final String imageUrl;
  final String thumbnailUrl;
  final Sprites sprites;
  final List<String> types;
  final String specie;
  final Generation generation;

  const PokemonSummary(
      {required this.number,
      required this.name,
      required this.imageUrl,
      required this.thumbnailUrl,
      required this.sprites,
      required this.types,
      required this.specie,
      required this.generation});

  factory PokemonSummary.fromJson(Map<String, dynamic> json) => PokemonSummary(
        number: json['number'],
        name: json['name'],
        imageUrl: json['imageUrl'],
        thumbnailUrl: json['thumbnailUrl'],
        sprites: Sprites.fromJson(json['sprites']),
        types: json['types'].cast<String>(),
        specie: json['specie'],
        generation: Generation.values
            .where((it) => it.toString().endsWith(json['generation']))
            .first,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [number, name];
}
