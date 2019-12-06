import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_bloc.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_event.dart';
import 'package:poke_app/src/bloc/pokemons/pokemons_state.dart';
import 'package:poke_app/src/remote/api_provider.dart';
import 'package:poke_app/src/remote/models/pokemons_response.dart';

class HomePage extends StatelessWidget {
  ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Poke App'),
      ),
      body: _list(context),
    );
  }

  Widget _list(BuildContext context) {
    final pokeBloc = BlocProvider.of<PokemonsBloc>(context);
    scrollController = ScrollController();
    bool scrollSwitch = true;

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          scrollSwitch == true) {
        scrollSwitch = false;
        pokeBloc.add(AddMorePokemons());

      }
    });

    
    return BlocBuilder<PokemonsBloc, PokemonsState>(
      bloc: pokeBloc,
      builder: (context, state) {
        if (state is WithoutPokemonsState) {
          pokeBloc.add(AddMorePokemons());
          return Center(child: CircularProgressIndicator());
        }

        if (state is WithPokemonsState) {
          scrollSwitch = true;
          return ListView.builder(
            
            controller: scrollController,
            itemCount: state.pokemons.length,
            itemBuilder: (BuildContext context, int index) {
              return _listTile(state.pokemons, index);
            },
          );
        }
        return Container();
      },
    );
  }

  Widget _listTile(List<Results> pokemons, int index) {
    return ListTile(
      title: Text(pokemons[index].name),
      trailing: Image(
        image: NetworkImage(
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${index + 1}.png'),
      ),
    );
  }
}
