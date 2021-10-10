import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/home.dart';

class InitialScreen extends StatefulWidget {
  const InitialScreen({Key? key}) : super(key: key);

  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Palette.lightBlack,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                'assets/logo/new_how_branco.svg',
                width: MediaQuery.of(context).size.height * 0.4,
              ),
              Center(
                child: DefaultTextStyle(
                  style: context.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TyperAnimatedText(
                        'NA SUA CASA, QUALQUER HORA',
                        speed: const Duration(milliseconds: 150),
                        textAlign: TextAlign.center,
                      ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 2000),
                  ),
                ),
              ),
              const SizedBox(height: 48.0),
              Center(
                child: Text(
                  'TEMOS DE TUDO!',
                  style: context.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Center(
                child: DefaultTextStyle(
                  style: context.textTheme.headline6!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      RotateAnimatedText(
                        'CERVEJA',
                        textAlign: TextAlign.center,
                      ),
                      RotateAnimatedText(
                        'VINHO',
                        textAlign: TextAlign.center,
                      ),
                      RotateAnimatedText(
                        'REFRIGERANTE',
                        textAlign: TextAlign.center,
                      ),
                      RotateAnimatedText(
                        'CIGARROS',
                        textAlign: TextAlign.center,
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 300),
                  ),
                ),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const HomeScreen(),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                    primary: Palette.primary,
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    onPrimary: Colors.white,
                    textStyle: context.textTheme.bodyText2!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        18.0,
                      ),
                    )),
                child: Text(
                  'Vem conferir!',
                ),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      );
}
