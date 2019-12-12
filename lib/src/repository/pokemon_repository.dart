import 'package:poke_app/src/remote/api_provider.dart';
import 'package:poke_app/src/remote/models/pokemons_response.dart';

class PokemonRepository {
  ApiProvider apiProvider = ApiProvider();
  List<Results> pokemons = [];
  int count = 0;

  Future<List<Results>> fetchPokemons() async {
    if (count == 880) return this.pokemons;

    if (this.pokemons.isEmpty) {
      this.pokemons.addAll(await apiProvider.fetchPokemons());
      this.count = this.pokemons.length;
      return pokemons;
    }

    this.pokemons.addAll(await apiProvider.fetchPokemons(offset: this.count));
    this.count = this.pokemons.length;
    return pokemons;
  }
}
