import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:p5_fusion_app/pages/main_page/main_page.dart';
import 'package:p5_fusion_app/pages/persona_page/persona_page.dart';
import 'package:p5_fusion_app/utils/instance_manager.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  InstanceManager.instance.set(PersonaRepository());
  InstanceManager.instance
      .set(PersonaService(InstanceManager.instance.get<PersonaRepository>()));
  InstanceManager.instance.set(SkillRepository());
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
        MainPage.routeName: (context) =>  MainPage(),
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
          default:
            return MaterialPageRoute(
              builder: (context) =>  MainPage(),
            );
        }
      },
    );
  }
}
