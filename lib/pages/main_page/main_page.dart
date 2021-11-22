import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/utils/bounce_back.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import './widgets/widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  static const String routeName = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final BounceBack _bounceBack = BounceBack();

  bool search_by_name = true;

  String _search_text = '';
  final ValueNotifier<List<Persona>> personas =
      ValueNotifier(InstanceManager.instance.get<PersonaRepository>().personas);

  final ValueNotifier<List<SkillData>> skills = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    final Widget persona_search = Card(
        key: const Key('persona_search'),
        child: SizedBox(
          width: 100,
          child: TextButton(
              onPressed: () {
                setState(() {
                  search_by_name = !search_by_name;
                  _onSearch(_search_text, personas);
                });
              },
              child: Text(AppLocalizations.of(context)!.search_name)),
        ));
    final Widget skill_search = Card(
        key: const Key('skill_search'),
        child: SizedBox(
          width: 100,
          child: TextButton(
              onPressed: () {
                setState(() {
                  search_by_name = !search_by_name;
                  _onSearch(_search_text, personas);
                });
              },
              child: Text(AppLocalizations.of(context)!.search_skill)),
        ));

    return Scaffold(
        appBar: AppBar(
            title: Text(AppLocalizations.of(context)!.title),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SizedBox(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder:
                        (Widget child, Animation<double> animation) {
                      return ScaleTransition(child: child, scale: animation);
                    },
                    child: search_by_name ? persona_search : skill_search,
                  ),
                ),
              ),
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
            child: search_by_name
                ? ValueListenableBuilder<List<Persona>>(
                    builder: (context, value, child) => PersonaList(
                      personas: value,
                    ),
                    valueListenable: personas,
                  )
                : ValueListenableBuilder<List<SkillData>>(
                    valueListenable: skills,
                    builder: (context, value, child) =>
                        SkillsList(skills: value),
                  )));
  }

  void _onSearch(String query, ValueNotifier<List<Persona>> personas) {
    _search_text = query;
    personas.value = InstanceManager.instance.get<PersonaRepository>().personas;
    skills.value = InstanceManager.instance.get<SkillRepository>().skills;
    if (search_by_name && query.isNotEmpty) {
      personas.value = InstanceManager.instance
          .get<PersonaRepository>()
          .searchPersonas(query);
    } else if (query.isNotEmpty) {
      skills.value = InstanceManager.instance
          .get<SkillRepository>()
          .skills
          .where((element) =>
              element.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
