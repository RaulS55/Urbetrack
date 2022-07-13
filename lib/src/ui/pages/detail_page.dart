import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/data/api/sw_api.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/pages/primary_screen_page.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';
import 'package:urbetrack_sw/src/ui/widgets/custom_box.dart';
import 'package:urbetrack_sw/src/ui/widgets/detail_item.dart';
import 'package:urbetrack_sw/src/ui/widgets/neon_buttom.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Provider.of<CharactersController>(context, listen: false);
    return WillPopScope(
      onWillPop: () async => false,
      child: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 25),
              Text(controller.characterSelect!.name,
                  style: MyStyle.title.copyWith(fontSize: 28)),
              const SizedBox(height: 10),
              DetailItem(
                  element: "Birth Year:",
                  detail: controller.characterSelect!.birthYear),
              DetailItem(
                  element: "Eye Color:",
                  detail: controller.characterSelect!.eyeColor),
              DetailItem(
                  element: "Gender:",
                  detail: controller.characterSelect!.gender),
              DetailItem(
                  element: "Hair Color:",
                  detail: controller.characterSelect!.hairColor),
              DetailItem(
                  element: "Height:",
                  detail: controller.characterSelect!.height),
              FutureBuilder<String>(
                  future: controller.getElement(
                      controller.characterSelect!.homeworld.split("api/").last,
                      "planet"),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final planet = snapshot.data!;
                      return DetailItem(element: "Planet:", detail: planet);
                    } else {
                      return Text("Loading...", style: MyStyle.subTitle);
                    }
                  }),
              DetailItem(
                  element: "Mass:", detail: controller.characterSelect!.mass),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: const [
                  CustomBox(kind: "vehicles"),
                  CustomBox(kind: "starships"),
                ],
              ),
              const SizedBox(height: 20),
              Selector<CharactersController, bool>(
                selector: (_, c) => c.swich,
                builder: (_, swich, __) {
                  return NeonButtom(
                      text: "REPORT",
                      active: controller.swich ? true : false,
                      onPressed: () =>
                          controller.swich ? _onPressed(context) : () {});
                },
              ),
              TextButton(
                onPressed: () => controller.screen = const PrimaryScreen(),
                style: TextButton.styleFrom(),
                child: Text("Back",
                    style: MyStyle.subTitle.copyWith(fontSize: 23)),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressed(BuildContext context) async {
    final controller =
        Provider.of<CharactersController>(context, listen: false);
    final id = controller.characterSelect!.url.split("people/").last;
    final idInt = int.parse(id.split("/").first);
    final api = GetIt.instance<PostApi>();
    await api
        .postCharacter(
            idInt, DateTime.now().toString(), controller.characterSelect!.name)
        .whenComplete(() {
      const snackBar = SnackBar(content: Text('Successfully reported'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }
}
