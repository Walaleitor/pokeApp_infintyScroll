import 'package:poke_app/src/remote/api_provider.dart';
import 'package:poke_app/src/remote/models/pokemons_response.dart';

class PokemonRepository {
  ApiProvider apiProvider = ApiProvider();
  List<Results> pokemons = [];
  int count = 0;

  Future<List<Results>> fetchPokemons({int offset = 0}) async {
    if (this.pokemons.isEmpty) {
      this.pokemons.addAll(await apiProvider.fetchPokemons());
      count += pokemons.length;
      return pokemons;
    }
    
    this.pokemons.addAll(await apiProvider.fetchPokemons( offset: this.count));
    count += pokemons.length;
    return pokemons;

  }
}
