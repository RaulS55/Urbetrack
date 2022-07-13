import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';
import 'package:urbetrack_sw/src/ui/utils/responsive.dart';

class CustomBox extends StatelessWidget {
  const CustomBox({
    Key? key,
    required this.kind,
  }) : super(key: key);
  final String kind;
  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final CharactersController controller =
        Provider.of<CharactersController>(context);
    bool exist = false;
    int length = 0;
    List<String> lista = [];
    if (kind == "vehicles") {
      exist = controller.characterSelect!.vehicles.isNotEmpty;
      length = controller.characterSelect!.vehicles.length;
      lista = controller.characterSelect!.vehicles;
    }
    if (kind == "starships") {
      exist = controller.characterSelect!.starships.isNotEmpty;
      length = controller.characterSelect!.starships.length;
      lista = controller.characterSelect!.starships;
    }
    return Container(
      width: responsive.wp(45),
      height: responsive.wp(45),
      decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.1),
          border: Border.all(color: Colors.red, width: 0.5)),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(kind.toUpperCase(), style: MyStyle.title.copyWith(fontSize: 21)),
          if (exist)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(
                  length,
                  (index) => FutureBuilder<String>(
                      future: controller.getElement(
                          lista[index].split("api/").last, kind),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final value = snapshot.data!;
                          return Text(value, style: MyStyle.subTitle);
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                ),
              ),
            ),
          if (!exist)
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("None", style: MyStyle.subTitle),
            ))
        ],
      ),
    );
  }
}
