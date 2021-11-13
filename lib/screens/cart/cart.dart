import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/cubit/address_information_cubit.dart';
import 'package:legiao_bebidas_app/cubit/cart.dart';
import 'package:legiao_bebidas_app/cubit/whatsapp.dart';
import 'package:legiao_bebidas_app/definitions/colors.dart';
import 'package:legiao_bebidas_app/definitions/extension.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/address/address_form.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/cart_item.dart';
import 'package:legiao_bebidas_app/screens/cart/widgets/payment/dropdown_payment.dart';
import 'package:legiao_bebidas_app/widgets/checkbox.dart';
import 'package:legiao_bebidas_app/widgets/logo.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  late TextEditingController streetController;
  late TextEditingController numberController;
  late TextEditingController complementController;
  late CartCubit cartCubit;
  late AddressInformationCubit addressInformationCubit;
  final _formKey = GlobalKey<FormState>();

  bool shouldSaveAddress = true;
  bool shouldDeliveryToAddress = true;

  @override
  void initState() {
    super.initState();
    streetController = TextEditingController();
    numberController = TextEditingController();
    complementController = TextEditingController();
    addressInformationCubit = BlocProvider.of<AddressInformationCubit>(context);
    cartCubit = BlocProvider.of<CartCubit>(context);

    if (addressInformationCubit.state.isValid) updateAddressValues();
  }

  void updateAddressValues() {
    streetController.text = addressInformationCubit.state.street;
    numberController.text = addressInformationCubit.state.number.toString();
    complementController.text = addressInformationCubit.state.complement;
  }

  @override
  void dispose() {
    streetController.dispose();
    numberController.dispose();
    complementController.dispose();
    super.dispose();
  }

  void onCheckedAddress(bool? value) {
    setState(() {
      shouldSaveAddress = value ?? true;
    });
  }

  void onCheckedDeliveryToAddress(bool? value) {
    setState(() {
      shouldDeliveryToAddress = value ?? true;
    });
  }

  String get formattedAddress =>
      '${streetController.text} - Nº ${numberController.text}\n${complementController.text}';

  void onPressedButton() {
    bool isValid =
        _formKey.currentState != null && _formKey.currentState!.validate();

    if (shouldDeliveryToAddress && isValid) {
      if (shouldSaveAddress) {
        addressInformationCubit.saveDataInStorage(
          complement: complementController.text.trim(),
          street: streetController.text.trim(),
          number: numberController.text.trim(),
        );
      } else {
        addressInformationCubit.removeFromStorage();
      }
    }
    if ((shouldDeliveryToAddress && isValid) || !shouldDeliveryToAddress) {
      BlocProvider.of<WhatsAppCubit>(context).sendMessage(
        address: formattedAddress,
        items: cartCubit.state.productsText,
        total: cartCubit.state.totalPrice,
        payment: cartCubit.state.payment,
        isDelivered: shouldDeliveryToAddress,
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Palette.lightBlack,
          elevation: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
            color: Palette.primary,
          ),
        ),
        body: SafeArea(
          child: Container(
            color: Palette.lightBlack,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: BlocBuilder<CartCubit, CartState>(
              bloc: cartCubit,
              builder: (context, state) => state.products.isEmpty
                  ? Column(
                      children: [
                        const LogoWidget(),
                        Center(
                          child: Text(
                            'Nenhum produto adicionado 🙁',
                            style: context.textTheme.headline6!
                                .copyWith(fontSize: 24.0),
                          ),
                        ),
                      ],
                    )
                  : CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Produtos',
                              style: context.textTheme.headline4!.copyWith(
                                fontSize: 24.0,
                                color: Palette.primary,
                              ),
                            ),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              final item = state.products.elementAt(index);
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: CartItem(
                                  imagePath: item.imagePath,
                                  product: item.title,
                                  price: item.price,
                                  quantity: item.quantity,
                                ),
                              );
                            },
                            childCount: state.products.length,
                          ),
                        ),
                        SliverToBoxAdapter(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Divider(color: Colors.white),
                              Text(
                                'Total: R\$ ${state.totalPrice.toStringAsFixed(2)}',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 36.0),
                              Row(
                                children: [
                                  CustomCheckBox(
                                    isChecked: shouldDeliveryToAddress,
                                    onChecked: onCheckedDeliveryToAddress,
                                  ),
                                  const SizedBox(width: 8.0),
                                  Text(
                                    'Quero que entregue no meu endereço.',
                                    style: context.textTheme.bodyText2,
                                  )
                                ],
                              ),
                              const SizedBox(height: 16.0),
                              if (shouldDeliveryToAddress) ...[
                                Text(
                                  'Endereço de entrega',
                                  style: context.textTheme.headline4!.copyWith(
                                    fontSize: 24.0,
                                    color: Palette.primary,
                                  ),
                                ),
                                const SizedBox(height: 12.0),
                                AddressForm(
                                  formKey: _formKey,
                                  streetController: streetController,
                                  numberController: numberController,
                                  complementController: complementController,
                                  onChecked: onCheckedAddress,
                                  isChecked: shouldSaveAddress,
                                ),
                              ],
                              const SizedBox(height: 48.0),
                              Text(
                                'Forma de pagamento',
                                style: context.textTheme.headline4!.copyWith(
                                  fontSize: 24.0,
                                  color: Palette.primary,
                                ),
                              ),
                              const SizedBox(height: 12.0),
                              const DropdownPayment(),
                              const SizedBox(height: 48.0),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child:
                                    BlocConsumer<WhatsAppCubit, WhatsAppState>(
                                  listener: (context, state) async {
                                    if (!state.success) {
                                      await Flushbar(
                                        message:
                                            'Não foi possível abrir o WhatsApp. Adicione o nosso número (43 99010203) e envie a mensagem manualmente.',
                                      ).show(context);
                                    }
                                  },
                                  builder: (context, state) => ElevatedButton(
                                    onPressed: onPressedButton,
                                    style: ElevatedButton.styleFrom(
                                        primary: Palette.primary,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 12.0),
                                        onPrimary: Colors.white,
                                        textStyle: context.textTheme.bodyText2!
                                            .copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                        shadowColor: Colors.transparent,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            18.0,
                                          ),
                                        )),
                                    child: state.isLoading
                                        ? CircularProgressIndicator()
                                        : Text(
                                            'Enviar pedido no WhatsApp',
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
      );
}
