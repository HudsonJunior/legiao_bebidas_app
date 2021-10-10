import 'package:legiao_bebidas_app/database/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

@Entity()
class Address {
  String street;
  int number;
  String complement;
  int id;

  Address({
    this.id = 0,
    required this.street,
    required this.number,
    required this.complement,
  });
}

class ObjectBoxDatabase {
  late final Store store;
  late final Box<Address> box;

  Future<void> initDb() async {
    final dir = await getApplicationDocumentsDirectory();
    store = Store(getObjectBoxModel(), directory: join(dir.path, 'address'));
    box = store.box<Address>();
  }
}
