import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/data/models/people.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/pages/detail_page.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';

class CharacterItem extends StatelessWidget {
  const CharacterItem({
    Key? key,
    required this.peoples,
    required this.index,
  }) : super(key: key);

  final List<People> peoples;
  final int index;
  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<CharactersController>(context);
    return GestureDetector(
      onTap: () {
        controller.characterSelect = peoples[index];
        controller.screen = const DetailPage();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.red, width: 0.2))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(peoples[index].name, style: MyStyle.title),
            Text(peoples[index].gender, style: MyStyle.subTitle)
          ],
        ),
      ),
    );
  }
}
