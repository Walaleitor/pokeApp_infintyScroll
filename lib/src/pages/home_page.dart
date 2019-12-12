import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_bloc.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_event.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_state.dart';
import 'package:poke_app/src/remote/models/pokemons_response.dart';

class HomePage extends StatelessWidget {
  PokemonsBloc pokeBloc;
  bool scrollSwitch = true;

  @override
  Widget build(BuildContext context) {
    pokeBloc = BlocProvider.of<PokemonsBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Poke App'),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return BlocBuilder<PokemonsBloc, PokemonsState>(
      bloc: pokeBloc,
      builder: (context, state) {
        if (state is WithoutPokemonsState) {
          pokeBloc.add(AddMorePokemons());
          return Center(child: CircularProgressIndicator());
        }

        if (state is WithPokemonsState) {
          scrollSwitch = true;
          return _lista(state);
        }
      },
    );
  }

  Widget _lista(WithPokemonsState state) {
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          scrollSwitch == true) {
        scrollSwitch = false;
        pokeBloc.add(AddMorePokemons());
      }
    });

    return ListView.builder(
      controller: scrollController,
      itemCount: state.pokemons.length,
      itemBuilder: (BuildContext context, int index) {
        return _listTile(state.pokemons, index);
      },
    );
  }

  Widget _listTile(List<Results> pokemons, int index) {
    final chunks = pokemons[index].url.split('/');
    var id = chunks[6];
    return ListTile(
      leading: Text(id),
      title: Text(pokemons[index].name),
      trailing: Image(
        image: NetworkImage(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${id}.png'),
      ),
    );
  }
}
