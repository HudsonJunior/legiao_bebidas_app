import 'package:flutter/material.dart';

import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';

class AddressField extends StatelessWidget {
  const AddressField({
    Key? key,
    required this.hintText,
    required this.controller,
    this.type,
    this.shoudHaveValidator = true,
  }) : super(key: key);

  final String hintText;
  final TextEditingController controller;
  final TextInputType? type;
  final bool shoudHaveValidator;

  @override
  Widget build(BuildContext context) => TextFormField(
        keyboardType: type,
        cursorColor: Colors.white,
        controller: controller,
        validator: shoudHaveValidator
            ? (value) {
                if (value == null || value.isEmpty) {
                  return 'Obrigatório';
                }
              }
            : null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Palette.primary),
            borderRadius: BorderRadius.circular(18.0),
          ),
          errorStyle: context.textTheme.bodyText2!.copyWith(
            color: Colors.red,
            fontSize: 14.0,
          ),
          hintText: hintText,
          hintStyle: context.textTheme.bodyText2,
        ),
      );
}
