import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:legiao_bebidas_app/database/objectbox.dart';

class AddressModelState {
  String street;
  int? number;
  String complement;

  AddressModelState({
    required this.street,
    required this.number,
    required this.complement,
  });

  AddressModelState copyWith({
    String? street,
    int? number,
    String? complement,
  }) {
    return AddressModelState(
      street: street ?? this.street,
      number: number ?? this.number,
      complement: complement ?? this.complement,
    );
  }

  String get formattedText => '$street - Nº $number\n$complement';

  bool get isValid =>
      this.street.isNotEmpty &&
      this.complement.isNotEmpty &&
      this.number != null;

  factory AddressModelState.empty() => AddressModelState(
        street: '',
        number: null,
        complement: '',
      );
}

class AddressInformationCubit extends Cubit<AddressModelState> {
  AddressInformationCubit() : super(AddressModelState.empty());

  static final ObjectBoxDatabase _database = ObjectBoxDatabase();
  ObjectBoxDatabase get database => _database;
  Future<void> initDb() async {
    await _database.initDb();
  }

  void saveDataInStorage({
    required String complement,
    required String street,
    required String number,
  }) {
    try {
      _database.box.removeAll();
      final convertedNumber = number.isNotEmpty
          ? int.parse(
              number,
            )
          : 0;

      _database.box.put(
        Address(
          complement: complement,
          street: street,
          number: convertedNumber,
        ),
      );
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  void removeFromStorage() {
    _database.box.removeAll();
  }

  void getStorageInformation() {
    try {
      final address = _database.box.getAll();

      if (address.length > 0) {
        final data = address[0];
        emit(
          state.copyWith(
            street: data.street,
            complement: data.street,
            number: data.number,
          ),
        );
      }
    } catch (error) {
      print(error);
    }
  }

  void clearStorage() {
    _database.box.removeAll();
  }
}
