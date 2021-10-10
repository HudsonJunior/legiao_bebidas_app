import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';

class PaymentForm extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isPix;

  const PaymentForm({
    Key? key,
    required this.title,
    required this.icon,
    this.isPix = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 30,
            height: 30,
            child: !isPix
                ? FaIcon(
                    icon,
                    color: Palette.primary,
                    size: 25,
                  )
                : Image.asset(
                    'assets/images/pix_icon.png',
                    width: 25,
                    height: 25,
                    color: Palette.primary,
                  ),
          ),
          const SizedBox(width: 12.0),
          Flexible(
            child: Text(
              title,
              style: context.textTheme.bodyText2,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      );
}
