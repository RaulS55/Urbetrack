import 'package:flutter/material.dart';
import 'package:urbetrack_sw/src/ui/utils/responsive.dart';

class NeonButtom extends StatefulWidget {
  const NeonButtom({
    Key? key,
    required this.text,
    required this.onPressed,
    this.active = true,
  }) : super(key: key);
  final String text;
  final Function() onPressed;
  final bool active;

  @override
  State<NeonButtom> createState() => _NeonButtomState();
}

class _NeonButtomState extends State<NeonButtom> {
  bool isPressed = false;
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive(context);
    Color shadowColor = widget.active ? Colors.red : Colors.grey;
    return Listener(
      onPointerDown: (_) => setState(() {
        isPressed = true;
      }),
      onPointerUp: (_) => setState(() {
        isPressed = false;
      }),
      child: Container(
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(10), boxShadow: [
          for (double i = 1; i < 3; i++)
            BoxShadow(
                color: shadowColor,
                blurRadius: (isPressed ? 5 : 3) * i,
                blurStyle: BlurStyle.outer)
        ]),
        child: TextButton(
          onHover: (hovered) => setState(() {
            isPressed = hovered;
          }),
          style: TextButton.styleFrom(
              side: const BorderSide(color: Colors.transparent, width: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: widget.onPressed,
          child: Text(
            widget.text,
            style: TextStyle(
                fontSize: responsive.dp(5),
                color: Colors.white,
                shadows: [
                  for (double i = 1; i < (isPressed ? 8 : 4); i++)
                    Shadow(color: shadowColor, blurRadius: 3 * i)
                ]),
          ),
        ),
      ),
    );
  }
}
