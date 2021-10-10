enum CategoryEnum {
  todos,
  cerveja,
  essencias,
  destilado,
  refrigerante,
  combo,
}

extension CategoryOperations on CategoryEnum {
  String get value {
    switch (this) {
      case CategoryEnum.cerveja:
        return 'Cerveja';
      case CategoryEnum.todos:
        return 'Todos';
      case CategoryEnum.essencias:
        return 'Essencias';
      case CategoryEnum.destilado:
        return 'Destilado';
      case CategoryEnum.refrigerante:
        return 'Refrigerante';
      case CategoryEnum.combo:
        return 'Combo';
    }
  }
}

extension StringOperations on String {
  CategoryEnum get category {
    switch (this) {
      case 'Cerveja':
        return CategoryEnum.cerveja;
      case 'Todos':
        return CategoryEnum.todos;
      case 'Essencias':
        return CategoryEnum.essencias;
      case 'Destilado':
        return CategoryEnum.destilado;
      case 'Refrigerante':
        return CategoryEnum.refrigerante;
      case 'Combo':
        return CategoryEnum.combo;
      default:
        return CategoryEnum.todos;
    }
  }
}
