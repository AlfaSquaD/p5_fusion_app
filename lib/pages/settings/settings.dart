import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:p5_fusion_app/pages/settings/sub_pages/dlc_persona_page.dart';

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
                  routeName: routeName),
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
      required this.routeName})
      : super(key: key);
  final String title;
  final String subtitle;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(routeName);
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
