import 'package:flutter/material.dart';

import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/address/address_field.dart';
import 'package:legiao_bebidas_app/widgets/checkbox.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({
    Key? key,
    required this.streetController,
    required this.numberController,
    required this.complementController,
    required this.formKey,
    required this.onChecked,
    required this.isChecked,
  }) : super(key: key);

  final TextEditingController streetController;
  final TextEditingController numberController;
  final TextEditingController complementController;
  final GlobalKey<FormState> formKey;
  final Function(bool?) onChecked;
  final bool isChecked;

  @override
  _AddressFormState createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) => Form(
        key: widget.formKey,
        child: Column(
          children: [
            AddressField(
              hintText: 'Rua',
              controller: widget.streetController,
            ),
            const SizedBox(height: 24.0),
            Row(
              children: [
                Expanded(
                  child: AddressField(
                    hintText: 'Número',
                    controller: widget.numberController,
                    type: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: AddressField(
                    hintText: 'Complemento',
                    controller: widget.complementController,
                    shoudHaveValidator: false,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12.0),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomCheckBox(
                    isChecked: widget.isChecked,
                    onChecked: widget.onChecked,
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Text(
                      'Salvar endereço para compras futuras',
                      style: context.textTheme.bodyText2,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
}
