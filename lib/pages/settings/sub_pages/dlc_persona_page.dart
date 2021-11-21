import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectDlcPersona extends StatefulWidget {
  const SelectDlcPersona({Key? key}) : super(key: key);
  static const String routeName = '/select-dlc-persona';

  @override
  State<SelectDlcPersona> createState() => _SelectDlcPersonaState();
}

class _SelectDlcPersonaState extends State<SelectDlcPersona> {
  @override
  Widget build(BuildContext context) {
    List<DLCPersona> dlcPersonas = InstanceManager.instance
        .get<SharedPreferences>()
        .getStringList('dlc_persona')!
        .map((e) => DLCPersona.values[int.parse(e)])
        .toList();
    return WillPopScope(
      onWillPop: () async {
        InstanceManager.instance
            .get<PersonaRepository>()
            .updatePersonaList(dlcPersonas);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context)!.select_dlc_personas),
        ),
        body: ListView.builder(
          itemCount: DLCPersona.values.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(DLCPersona.values[index].name.fold("",
                    (previousValue, element) => previousValue + " " + element)),
                trailing: Switch(
                  value: dlcPersonas.contains(DLCPersona.values[index]),
                  onChanged: (value) {
                    setState(() {
                      if (value) {
                        dlcPersonas.add(DLCPersona.values[index]);
                      } else {
                        dlcPersonas.remove(DLCPersona.values[index]);
                      }
                      InstanceManager.instance
                          .get<SharedPreferences>()
                          .setStringList(
                              "dlc_persona",
                              dlcPersonas
                                  .map((e) => e.index.toString())
                                  .toList());
                    });
                  },
                ),
                onTap: () {
                  InstanceManager.instance
                      .get<SharedPreferences>()
                      .setStringList('dlc_persona', [
                    dlcPersonas[index].index.toString(),
                  ]);
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
