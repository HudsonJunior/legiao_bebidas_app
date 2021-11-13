import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legiao_bebidas_app/definitions/constraints.dart';
import 'package:legiao_bebidas_app/models/payment.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class WhatsAppState {
  final bool isLoading;
  final bool success;

  WhatsAppState({
    required this.isLoading,
    required this.success,
  });

  WhatsAppState copyWith({
    bool? isLoading,
    bool? success,
  }) {
    return WhatsAppState(
      isLoading: isLoading ?? false,
      success: success ?? this.success,
    );
  }

  factory WhatsAppState.empty() =>
      WhatsAppState(isLoading: false, success: true);
}

class WhatsAppCubit extends Cubit<WhatsAppState> {
  WhatsAppCubit() : super(WhatsAppState.empty());

  void sendMessage({
    required String address,
    required String items,
    required double total,
    required PaymentFormEnum payment,
    required bool isDelivered,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));

      final addressText = !isDelivered
          ? 'Pode deixar que eu vou buscar ai!'
          : 'Entregar no seguinte endereço:\n$address';

      final link = WhatsAppUnilink(
        phoneNumber: '+55 ${Constraints.whatsappNumber}',
        text:
            "Olá, tudo bem? 😁\n\nGostaria de comprar os seguintes produtos:\n\n$items\n\nNo valor total de R\$ ${total.toStringAsFixed(2)}\n\n$addressText\n\nPretendo pagar com: ${payment.value}",
      );
      await launch('$link');
      emit(state.copyWith(success: true));
    } catch (_) {
      emit(state.copyWith(success: false));
    }
  }
}
