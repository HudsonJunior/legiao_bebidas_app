import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/widgets/logo.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Palette.lightBlack,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const LogoWidget(),
          Center(
            child: Column(
              children: [
                Text(
                  'Atendimento em Marilândia do Sul',
                  style: context.textTheme.headline6!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Rua 123 123 123',
                  style: context.textTheme.headline6!
                      .copyWith(color: Colors.white),
                ),
                Text(
                  'Perto do estabelicemento abc',
                  style: context.textTheme.headline6!
                      .copyWith(color: Colors.white),
                ),
                const SizedBox(height: 48.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
                    const SizedBox(width: 16.0),
                    Text(
                      '43 99010203',
                      style: context.textTheme.headline6!
                          .copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
