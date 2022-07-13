import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';
import 'package:urbetrack_sw/src/ui/utils/responsive.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    final CharactersController controller =
        Provider.of<CharactersController>(context, listen: false);
    return Stack(
      children: [
        Image.asset(
          "assets/fondo.jpg",
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Selector<CharactersController, bool>(
          selector: ((_, c) => c.swich),
          builder: (_, estado, child) {
            return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    border: Border.all(
                        color: estado ? Colors.red : Colors.grey, width: 0.5)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: responsive.hp(10)),
                    child!,
                    SizedBox(height: responsive.hp(10)),
                    const Text("State", style: MyStyle.state),
                    Text(estado ? "Connected" : "Disconnected",
                        style: estado
                            ? MyStyle.title
                            : MyStyle.title.copyWith(color: Colors.grey)),
                    Transform.scale(
                        scale: 1.5,
                        child: Switch.adaptive(
                            inactiveThumbColor: Colors.grey,
                            inactiveTrackColor: Colors.grey.withOpacity(0.5),
                            value: estado,
                            onChanged: (value) {
                              controller.swich = value;
                            })),
                  ],
                ));
          },
          child: Image.asset(
            "assets/logo.png",
            width: responsive.wp(25),
          ),
        ),
      ],
    );
  }
}
