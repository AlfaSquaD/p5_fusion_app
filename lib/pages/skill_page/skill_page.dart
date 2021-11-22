import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:p5_fusion_app/pages/persona_page/persona_page.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_app/widgets/attribute_tile.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/utils/extensions.dart';

class SkillPage extends InheritedWidget {
  SkillPage({Key? key, required SkillPageArgs args})
      : skillData = args.skillData,
        super(key: key, child: _SkillPage(key: key));

  static const String routeName = '/skill';

  final SkillData skillData;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static SkillPage of(BuildContext context) {
    final SkillPage? result =
        context.dependOnInheritedWidgetOfExactType<SkillPage>();
    assert(result != null, 'No SkillPage found in context');
    return result!;
  }
}

class SkillPageArgs {
  const SkillPageArgs(this.skillData);
  final SkillData skillData;
}

class _SkillPage extends StatelessWidget {
  const _SkillPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SkillData skillData = SkillPage.of(context).skillData;
    return Scaffold(
      appBar: AppBar(
        title: Text(skillData.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              AttributeTile(
                  title: AppLocalizations.of(context)!.effect,
                  value: Text(skillData.effect)),
              AttributeTile(
                  title: AppLocalizations.of(context)!.type,
                  value: Text(skillData.element.name.capitalize)),
              if (skillData.note != null)
                AttributeTile(
                    title: AppLocalizations.of(context)!.note,
                    value: Text(skillData.note!)),
              AttributeTile(
                  title: AppLocalizations.of(context)!.cost,
                  value: Text(skillData.calculateCost())),
              AttributeTile(
                  title: AppLocalizations.of(context)!.personas,
                  value: Column(
                    children: [
                      if (skillData.personas.isEmpty)
                        Text(AppLocalizations.of(context)!.none)
                      else
                        for (final String persona in skillData.personas.keys)
                          InkWell(
                            onTap: () => Navigator.pushNamed(
                                context, PersonaPage.routeName,
                                arguments: PersonaPageArgs(
                                    persona: InstanceManager.instance
                                        .get<PersonaRepository>()
                                        .getPersonaByName(persona))),
                            child: AttributeTile(
                                title: persona,
                                value: Text(
                                    "At level ${skillData.personas[persona]}")),
                          )
                    ],
                  )),
              AttributeTile(
                  title: AppLocalizations.of(context)!.unique,
                  value: Text(
                      skillData.unique ?? AppLocalizations.of(context)!.no)),
              AttributeTile(
                  title: AppLocalizations.of(context)!.skill_card_negotiation,
                  value: Text(skillData.negotiations ??
                      AppLocalizations.of(context)!.none)),
              AttributeTile(
                  title: AppLocalizations.of(context)!.skill_card_fusion,
                  value: Text(skillData.fusion?.fold<String>(
                          "",
                          (previousValue, element) =>
                              previousValue + ", " + element) ??
                      AppLocalizations.of(context)!.none)),
            ],
          ),
        ),
      ),
    );
  }
}
