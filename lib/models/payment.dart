import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum PaymentFormEnum {
  debit,
  credit,
  money,
  pix,
}

extension PaymentFormExt on PaymentFormEnum {
  String get value {
    switch (this) {
      case PaymentFormEnum.debit:
        return 'Cartão de Débito';
      case PaymentFormEnum.credit:
        return 'Cartão de Crédito';
      case PaymentFormEnum.money:
        return 'Dinheiro';
      case PaymentFormEnum.pix:
        return 'Pix';
    }
  }

  IconData get icon {
    switch (this) {
      case PaymentFormEnum.debit:
        return FontAwesomeIcons.ccMastercard;
      case PaymentFormEnum.credit:
        return FontAwesomeIcons.creditCard;
      case PaymentFormEnum.money:
        return FontAwesomeIcons.moneyBillAlt;
      case PaymentFormEnum.pix:
        return FontAwesomeIcons.ccMastercard;
    }
  }
}
