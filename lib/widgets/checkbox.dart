import 'package:flutter/material.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';

class CustomCheckBox extends StatelessWidget {
  const CustomCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChecked,
  }) : super(key: key);

  final bool isChecked;
  final Function(bool?) onChecked;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 24,
        width: 24,
        child: Checkbox(
          value: isChecked,
          splashRadius: 0.0,
          onChanged: onChecked,
          side: const BorderSide(color: Colors.white),
          activeColor: Palette.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.0),
          ),
          checkColor: Colors.white,
        ),
      );
}
