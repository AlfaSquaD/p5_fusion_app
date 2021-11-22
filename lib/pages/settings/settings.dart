import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/pages/settings/sub_pages/dlc_persona_page.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);
  static const String routeName = '/settings';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _SettingTile(
                  title: AppLocalizations.of(context)!.select_dlc_personas,
                  subtitle:
                      AppLocalizations.of(context)!.select_dlc_personas_desc,
                  routeName: SelectDlcPersona.routeName),
              _SettingTile(
                title: AppLocalizations.of(context)!.about_app,
                subtitle: "",
                onTap: () => showAboutDialog(
                    context: context,
                    applicationName: AppLocalizations.of(context)!.title,
                    applicationVersion: AppLocalizations.of(context)!.version,
                    applicationLegalese: AppLocalizations.of(context)!.build_by,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 23, top: 10),
                        child: RichText(
                            text: TextSpan(
                                text: "Github",
                                style: const TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () =>
                                      launch("https://github.com/AlfaSquaD"))),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile(
      {Key? key,
      required this.title,
      required this.subtitle,
      this.routeName,
      this.onTap})
      : assert((routeName != null && onTap == null) ||
            (routeName == null && onTap != null)),
        super(key: key);
  final String title;
  final String subtitle;
  final String? routeName;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          if (routeName != null) {
            Navigator.of(context).pushNamed(routeName!);
          } else {
            onTap!();
          }
        },
        child: Card(
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: const Icon(Icons.chevron_right),
          ),
        ));
  }
}
