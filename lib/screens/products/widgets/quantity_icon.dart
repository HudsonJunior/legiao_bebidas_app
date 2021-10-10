import 'package:flutter/material.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';

class QuantityIcon extends StatelessWidget {
  const QuantityIcon({
    required this.onTap,
    required this.icon,
  });

  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Palette.primary,
          ),
          child: Icon(icon, color: Colors.white),
        ),
      );
}
