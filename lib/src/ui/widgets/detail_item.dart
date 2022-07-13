import 'package:flutter/material.dart';
import 'package:urbetrack_sw/src/ui/utils/font_style.dart';

class DetailItem extends StatelessWidget {
  const DetailItem({
    Key? key,
    required this.element,
    required this.detail,
  }) : super(key: key);
  final String element;
  final String detail;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.red, width: 0.2))),
        child: Row(
          children: [
            Text(
              element,
              style: MyStyle.state.copyWith(color: Colors.redAccent),
            ),
            const Spacer(),
            Text(detail, style: MyStyle.subTitle),
          ],
        ),
      ),
    );
  }
}
