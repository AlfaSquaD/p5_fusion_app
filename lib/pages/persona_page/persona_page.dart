import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:p5_fusion_app/pages/fusion_page/fusion_page.dart';
import 'package:p5_fusion_app/pages/skill_page/skill_page.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_app/widgets/attribute_tile.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonaPage extends InheritedWidget {
  PersonaPage({Key? key, required PersonaPageArgs args})
      : persona = args.persona,
        super(key: Key(args.persona.name), child: _PersonaPage(key: key));
  static const String routeName = '/persona';

  final Persona persona;

  static PersonaPage of(BuildContext context) {
    final PersonaPage? result =
        context.dependOnInheritedWidgetOfExactType<PersonaPage>();
    assert(result != null, 'No PersonaPage found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }
}

class PersonaPageArgs with EquatableMixin {
  final Persona persona;
  PersonaPageArgs({required this.persona});

  @override
  List<Object?> get props => [persona];
}

class _PersonaPage extends StatelessWidget {
  const _PersonaPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Persona persona = PersonaPage.of(context).persona;
    return Scaffold(
        appBar: AppBar(
          title: Text(PersonaPage.of(context).persona.name),
        ),
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            AttributeTile(
                title: AppLocalizations.of(context)!.arcana,
                value: Text(persona.arcana.name)),
            AttributeTile(
                title: AppLocalizations.of(context)!.level,
                value: Text(persona.level.toString())),
            AttributeTile(
                title: AppLocalizations.of(context)!.rare,
                value: persona.rare
                    ? Text(AppLocalizations.of(context)!.yes)
                    : Text(AppLocalizations.of(context)!.no)),
            AttributeTile(
              title: AppLocalizations.of(context)!.dlc,
              value: persona.dlc
                  ? Text(AppLocalizations.of(context)!.yes)
                  : Text(AppLocalizations.of(context)!.no),
            ),
            AttributeTile(
              title: AppLocalizations.of(context)!.special,
              value: persona.special
                  ? Text(AppLocalizations.of(context)!.yes)
                  : Text(AppLocalizations.of(context)!.no),
            ),
            AttributeTile(
              title: AppLocalizations.of(context)!.stats,
              value: _TableCreator(
                  rowBuilder: (context, index) {
                    final Stat stat = Stat.values[index];
                    final int statValue = persona.stats[stat]!;
                    return [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(stat.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(statValue.toString()),
                      ),
                    ];
                  },
                  rowCount: persona.stats.length),
            ),
            AttributeTile(
                title: AppLocalizations.of(context)!.elements,
                value: _TableCreator(
                  rowBuilder: (context, index) {
                    final Elements element = Elements.values[index];
                    final Resistance resistance = persona.elements[element]!;
                    return [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(element.name),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(resistance.name),
                      ),
                    ];
                  },
                  rowCount: persona.elements.length,
                )),
            AttributeTile(
                title: AppLocalizations.of(context)!.skills,
                value: Builder(builder: (context) {
                  final Map skillsMap = persona.skills;
                  final List skills = skillsMap.keys.toList()
                    ..sort((first, second) =>
                        skillsMap[first]!.compareTo(skillsMap[second]!));

                  return Column(
                    children: [
                      for (final String skill in skills)
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, SkillPage.routeName,
                                arguments: SkillPageArgs(InstanceManager
                                    .instance
                                    .get<SkillRepository>()
                                    .getSkill(skill)!));
                          },
                          child: AttributeTile(
                              title: persona.skills[skill] == 0
                                  ? skill
                                  : "$skill - At level ${skillsMap[skill]}",
                              value: Text(InstanceManager.instance
                                  .get<SkillRepository>()
                                  .getSkill(skill)!
                                  .effect)),
                        )
                    ],
                  );
                })),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {
                      final List<Fusion> fusionList = InstanceManager.instance
                          .get<PersonaService>()
                          .getFusionsFrom(persona);
                      Navigator.of(context).pushNamed(
                        FusionPage.routeName,
                        arguments: FusionPageArgs(fusions: fusionList),
                      );
                    },
                    child: Text(AppLocalizations.of(context)!
                        .fusion_from_this_persona)),
                ElevatedButton(
                    onPressed: () {
                      final List<Fusion> fusionList = InstanceManager.instance
                          .get<PersonaService>()
                          .getFusionsTo(persona);
                      Navigator.of(context).pushNamed(
                        FusionPage.routeName,
                        arguments: FusionPageArgs(fusions: fusionList),
                      );
                    },
                    child: Text(
                        AppLocalizations.of(context)!.fusion_to_this_persona)),
              ],
            )
          ]),
        )));
  }
}

typedef _TableCreatorRowBuilder = List<Widget> Function(
    BuildContext context, int index);

class _TableCreator extends StatelessWidget {
  const _TableCreator(
      {Key? key, required this.rowBuilder, required this.rowCount})
      : super(key: key);

  final _TableCreatorRowBuilder rowBuilder;

  final int rowCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Table(
        defaultColumnWidth: const IntrinsicColumnWidth(),
        border: TableBorder.symmetric(
          inside: const BorderSide(
            color: Colors.black,
            width: 1.0,
          ),
        ),
        children: [
          for (int i = 0; i < rowCount; i++)
            TableRow(
              children: rowBuilder(context, i),
            )
        ],
      ),
    );
  }
}
