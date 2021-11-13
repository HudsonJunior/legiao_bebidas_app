import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/cart.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/models/payment.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/payment/payment_form.dart';

class DropdownPayment extends StatelessWidget {
  const DropdownPayment();

  @override
  Widget build(BuildContext context) => BlocBuilder<CartCubit, CartState>(
        builder: (context, state) => DropdownButton<PaymentFormEnum>(
          onTap: () => FocusScope.of(context).unfocus(),
          onChanged: (newPayment) {
            newPayment ??= PaymentFormEnum.money;
            BlocProvider.of<CartCubit>(context).updatePayment(newPayment);
          },
          dropdownColor: Palette.lightBlack,
          isExpanded: true,
          value: state.payment,
          underline: const SizedBox.shrink(),
          iconEnabledColor: Palette.primary,
          items: PaymentFormEnum.values
              .map(
                (payment) => DropdownMenuItem(
                  value: payment,
                  child: PaymentForm(
                    icon: payment.icon,
                    title: payment.value,
                    isPix: payment == PaymentFormEnum.pix,
                  ),
                ),
              )
              .toList(),
        ),
      );
}
