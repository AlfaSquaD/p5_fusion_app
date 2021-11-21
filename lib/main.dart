import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:p5_fusion_app/pages/fusion_page/fusion_page.dart';
import 'package:p5_fusion_app/pages/main_page/main_page.dart';
import 'package:p5_fusion_app/pages/persona_page/persona_page.dart';
import 'package:p5_fusion_app/pages/settings/settings.dart';
import 'package:p5_fusion_app/pages/settings/sub_pages/dlc_persona_page.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences instance = await SharedPreferences.getInstance();
  List<DLCPersona> dlcPersonas;
  if (!instance.containsKey("dlc_persona")) {
    instance.setStringList("dlc_persona", []);
  }
  dlcPersonas = instance
      .getStringList("dlc_persona")!
      .map((e) => DLCPersona.values[int.parse(e)])
      .toList();
  InstanceManager.instance
      .set(PersonaRepository(selectedDlcPersonas: dlcPersonas));
  InstanceManager.instance
      .set(PersonaService(InstanceManager.instance.get<PersonaRepository>()));
  InstanceManager.instance.set(SkillRepository());
  InstanceManager.instance.set(instance);
  runApp(const Persona5FusionCalculator());
}

class Persona5FusionCalculator extends StatelessWidget {
  const Persona5FusionCalculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor: SystemUiOverlayStyle.dark.statusBarColor,
    ));

    return MaterialApp(
      theme:
          ThemeData(brightness: Brightness.light, primarySwatch: Colors.teal),
      darkTheme:
          ThemeData(brightness: Brightness.dark, primarySwatch: Colors.teal),
      initialRoute: '/',
      routes: {
        MainPage.routeName: (context) => MainPage(),
        SettingsPage.routeName: (context) => const SettingsPage(),
        SelectDlcPersona.routeName: (context) => const SelectDlcPersona(),
      },
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("en", ""),
      ],
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case PersonaPage.routeName:
            return MaterialPageRoute(
              builder: (context) => PersonaPage(
                args: settings.arguments as PersonaPageArgs,
              ),
            );
          case FusionPage.routeName:
            return MaterialPageRoute(
              builder: (context) => FusionPage(
                args: settings.arguments as FusionPageArgs,
              ),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => MainPage(),
            );
        }
      },
    );
  }
}
