import 'package:flutter/material.dart';
import 'package:p5_fusion_dart/p5_fusion_dart.dart';

class FusionPage extends InheritedWidget {
  static const String routeName = '/fusion';

  final List<Fusion> fusions;

  FusionPage({
    Key? key,
    required FusionPageArgs args,
  })  : fusions = args.fusions,
        super(key: key, child: const _FusionPage());

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false;
  }

  static FusionPage of(BuildContext context) {
    final FusionPage? result =
        context.dependOnInheritedWidgetOfExactType<FusionPage>();
    assert(result != null, 'No FusionPage found in context');
    return result!;
  }
}

class FusionPageArgs {
  final List<Fusion> fusions;

  const FusionPageArgs({
    required this.fusions,
  });
}

class _FusionPage extends StatelessWidget {
  const _FusionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Fusions'),
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final Fusion fusion = FusionPage.of(context).fusions[index];
            String fusionString = "";
            for (int i = 0; i < fusion.source.length; i++) {
              fusionString += fusion.source[i].toString();
              if (i != fusion.source.length - 1) {
                fusionString += " + ";
              }
            }

            return Card(
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(fusionString),
                    const Icon(Icons.arrow_forward),
                    Text(
                      fusion.target.toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                subtitle: Text("${fusion.cost} ¥"),
              ),
            );
          },
          itemCount: FusionPage.of(context).fusions.length,
          itemExtent: 80,
        ));
  }
}
