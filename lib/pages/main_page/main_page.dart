import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/utils/bounce_back.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import './widgets/widgets.dart';

class MainPage extends StatelessWidget {
  MainPage({Key? key}) : super(key: key);
  static const String routeName = '/';
  final BounceBack _bounceBack = BounceBack();
  final ValueNotifier<List<Persona>> personas =
      ValueNotifier(InstanceManager.instance.get<PersonaRepository>().personas);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.title),
            actions: [
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
            ],
            bottom: searchBar(
              context: context,
              onChanged: (text) => _bounceBack.start(
                  onComplete: () => _onSearch(text, personas)),
            )),
        body: Center(
            child: ValueListenableBuilder<List<Persona>>(
          builder: (context, value, child) => PersonaList(
            personas: value,
          ),
          valueListenable: personas,
        )));
  }

  void _onSearch(String query, ValueNotifier<List<Persona>> personas) {
    if (query.isEmpty) {
      personas.value =
          InstanceManager.instance.get<PersonaRepository>().personas;
    } else {
      personas.value = InstanceManager.instance
          .get<PersonaRepository>()
          .searchPersonas(query);
    }
  }
}
