import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_event.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_state.dart';
import 'package:poke_app/src/repository/pokemon_repository.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonRepository pokemonRepository;

  PokemonsBloc({@required this.pokemonRepository})
      : assert(pokemonRepository != null);

  @override
  PokemonsState get initialState => WithoutPokemonsState();

  @override
  Stream<PokemonsState> mapEventToState(
    PokemonsEvent event,
  ) async* {
    if (event is AddMorePokemons) {
      try {
        final pokemons = await this.pokemonRepository.fetchPokemons();
        yield (WithPokemonsState(pokemons: pokemons, amount: pokemons.length));
      } catch (error) {}
    }
  }
}
