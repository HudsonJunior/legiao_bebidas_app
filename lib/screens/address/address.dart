import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/constraints.dart';
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
                  'Atendimento somente em\n Marilândia do Sul',
                  style: context.textTheme.headline6!
                      .copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  'Rua São Sebastião, 770',
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
                      Constraints.whatsappNumber,
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
