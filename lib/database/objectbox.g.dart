// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'objectbox.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 8636250177765321073),
      name: 'Address',
      lastPropertyId: const IdUid(5, 5321767325779040555),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6226126355075484873),
            name: 'street',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(2, 6677163126406818252),
            name: 'number',
            type: 6,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 6809498729301414880),
            name: 'complement',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8182401237736010767),
            name: 'shouldSave',
            type: 1,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 5321767325779040555),
            name: 'id',
            type: 6,
            flags: 1)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(1, 8636250177765321073),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Address: EntityDefinition<Address>(
        model: _entities[0],
        toOneRelations: (Address object) => [],
        toManyRelations: (Address object) => {},
        getId: (Address object) => object.id,
        setId: (Address object, int id) {
          object.id = id;
        },
        objectToFB: (Address object, fb.Builder fbb) {
          final streetOffset = fbb.writeString(object.street);
          final complementOffset = fbb.writeString(object.complement);
          fbb.startTable(6);
          fbb.addOffset(0, streetOffset);
          fbb.addInt64(1, object.number);
          fbb.addOffset(2, complementOffset);
          fbb.addInt64(4, object.id);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Address(
            id: const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0),
            street:
                const fb.StringReader().vTableGet(buffer, rootOffset, 4, ''),
            number: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
            complement:
                const fb.StringReader().vTableGet(buffer, rootOffset, 8, ''),
          );

          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Address] entity fields to define ObjectBox queries.
class Address_ {
  /// see [Address.street]
  static final street =
      QueryStringProperty<Address>(_entities[0].properties[0]);

  /// see [Address.number]
  static final number =
      QueryIntegerProperty<Address>(_entities[0].properties[1]);

  /// see [Address.complement]
  static final complement =
      QueryStringProperty<Address>(_entities[0].properties[2]);

  /// see [Address.shouldSave]
  static final shouldSave =
      QueryBooleanProperty<Address>(_entities[0].properties[3]);

  /// see [Address.id]
  static final id = QueryIntegerProperty<Address>(_entities[0].properties[4]);
}
