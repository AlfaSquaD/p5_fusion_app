part of 'widgets.dart';

typedef _SearchBarChanged = void Function(String text);

PreferredSize searchBar(
        {required BuildContext context, _SearchBarChanged? onChanged}) =>
    PreferredSize(
      preferredSize: const Size.fromHeight(60),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
        child: TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            border: const UnderlineInputBorder(),
          ),
          cursorColor:
              MediaQuery.of(context).platformBrightness == Brightness.light
                  ? Colors.black.withOpacity(0.5)
                  : null,
        ),
      ),
    );
