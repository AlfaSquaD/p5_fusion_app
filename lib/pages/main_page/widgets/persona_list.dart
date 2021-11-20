part of 'widgets.dart';

class PersonaList extends StatelessWidget {
  const PersonaList({Key? key, required this.personas}) : super(key: key);

  final List<Persona> personas;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemExtent: 80,
        itemBuilder: (context, index) {
          final Persona persona = personas[index];
          return Card(
            child: ListTile(
              title: Text(persona.name),
              subtitle: Text(persona.arcana.name),
              trailing: IconButton(
                icon: const Icon(Icons.keyboard_arrow_right_rounded),
                onPressed: () {
                  Navigator.of(context).pushNamed(PersonaPage.routeName,
                      arguments: PersonaPageArgs(persona: persona));
                },
              ),
            ),
          );
        },
        itemCount: personas.length);
  }
}
