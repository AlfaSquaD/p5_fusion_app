part of 'widgets.dart';

class SkillsList extends StatelessWidget {
  const SkillsList({Key? key, required this.skills}) : super(key: key);

  final List<SkillData> skills;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 700),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child,
      ),
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemExtent: 80,
          itemBuilder: (context, index) {
            final SkillData skill = skills[index];
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(SkillPage.routeName,
                    arguments: SkillPageArgs(skill));
              },
              child: Card(
                child: ListTile(
                  title: Text(skill.name),
                  subtitle: Text(skill.effect),
                  trailing: const Icon(
                    Icons.keyboard_arrow_right_rounded,
                  ),
                ),
              ),
            );
          },
          itemCount: skills.length),
    );
  }
}
