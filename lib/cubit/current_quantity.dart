import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentQuantityCubit extends Cubit<int> {
  CurrentQuantityCubit() : super(0);

  void updateCurrentQuantity(int currentQuantity) {
    emit(currentQuantity);
  }
}
