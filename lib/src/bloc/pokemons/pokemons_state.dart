import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:poke_app/src/remote/models/pokemons_response.dart';

abstract class PokemonsState extends Equatable {
  const PokemonsState();
}

class WithoutPokemonsState extends PokemonsState {
  List<Results> pokemons = [];

  @override
  List<Object> get props => [pokemons];
}

class WithPokemonsState extends PokemonsState {
  List<Results> pokemons;
  int amount;


  WithPokemonsState({@required this.pokemons, @required this.amount});

  @override
  List<Object> get props => [this.pokemons, this.amount];
}
