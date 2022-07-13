import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/data/models/people.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';
import 'package:urbetrack_sw/src/ui/utils/responsive.dart';
import 'package:urbetrack_sw/src/ui/widgets/character_item.dart';
import 'package:urbetrack_sw/src/ui/widgets/neon_buttom.dart';

class PrimaryScreen extends StatelessWidget {
  const PrimaryScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final CharactersController controller = Provider.of(context, listen: false);
    return Center(
      child: SizedBox(
        width: responsive.wp(80),
        height: responsive.hp(80),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Selector<CharactersController, String>(
              selector: (_, c) => c.selectPage,
              builder: (_, select, __) {
                return Container(
                  width: responsive.wp(80),
                  height: responsive.hp(60),
                  decoration: BoxDecoration(
                      color: Colors.redAccent.withOpacity(0.1),
                      border: Border.all(color: Colors.red, width: 0.5)),
                  child: FutureBuilder<List<People>>(
                    future: controller.getPeoplesList(select),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final List<People> peoples = snapshot.data!;
                        return ListView.builder(
                          padding: const EdgeInsets.all(10),
                          shrinkWrap: true,
                          itemCount: peoples.length,
                          itemBuilder: (BuildContext context, int index) {
                            return CharacterItem(
                              peoples: peoples,
                              index: index,
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text(
                            Random().nextInt(2) == 1
                                ? " Loading..."
                                : " Destroying the Death Star...",
                            style: MyStyle.subTitle.copyWith(fontSize: 25),
                          ),
                        );
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(height: responsive.hp(3)),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeonButtom(
                  text: "<",
                  onPressed: () {
                    if (controller.currentPage > 1) {
                      controller.previous();
                    }
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsive.wp(5)),
                  child: Consumer<CharactersController>(
                    builder: ((_, c, __) => Text("${c.currentPage}",
                        style: MyStyle.subTitle
                            .copyWith(fontSize: responsive.dp(5)))),
                  ),
                ),
                NeonButtom(
                  text: ">",
                  onPressed: () {
                    if (controller.nextPage != null) {
                      controller.next();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
