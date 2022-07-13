import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:urbetrack_sw/src/ui/Provider/characters_controller.dart';
import 'package:urbetrack_sw/src/ui/utils/responsive.dart';
import 'package:urbetrack_sw/src/ui/widgets/custom_drawer.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    final height = AppBar().preferredSize.height;
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Image.asset(
            "assets/logo.png",
            width: height,
          ),
        ),
        backgroundColor: Colors.black,
        actions: [
          Selector<CharactersController, bool>(
              selector: ((_, c) => c.swich),
              builder: (_, estado, __) {
                return Icon(
                  Icons.mode_standby_sharp,
                  color: estado ? Colors.red : Colors.grey,
                  size: 35,
                );
              })
        ],
      ),
      drawer: Drawer(
        width: responsive.wp(60),
        child: const CustomDrawer(),
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/fondo.jpg",
            fit: BoxFit.fitHeight,
            height: double.infinity,
          ),
          Selector<CharactersController, Widget>(
            selector: (_, c) => c.screen,
            builder: (_, body, __) => body,
          )
        ],
      ),
    );
  }
}
