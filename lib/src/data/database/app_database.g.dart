// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $WishlistTableTable extends WishlistTable
    with TableInfo<$WishlistTableTable, WishlistItemModel> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WishlistTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
      'id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryNameMeta =
      const VerificationMeta('countryName');
  @override
  late final GeneratedColumn<String> countryName = GeneratedColumn<String>(
      'country_name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _countryCodeMeta =
      const VerificationMeta('countryCode');
  @override
  late final GeneratedColumn<String> countryCode = GeneratedColumn<String>(
      'country_code', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _flagUrlMeta =
      const VerificationMeta('flagUrl');
  @override
  late final GeneratedColumn<String> flagUrl = GeneratedColumn<String>(
      'flag_url', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _addedAtMeta =
      const VerificationMeta('addedAt');
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
      'added_at', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [id, countryName, countryCode, flagUrl, addedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'wishlist_table';
  @override
  VerificationContext validateIntegrity(Insertable<WishlistItemModel> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('country_name')) {
      context.handle(
          _countryNameMeta,
          countryName.isAcceptableOrUnknown(
              data['country_name']!, _countryNameMeta));
    } else if (isInserting) {
      context.missing(_countryNameMeta);
    }
    if (data.containsKey('country_code')) {
      context.handle(
          _countryCodeMeta,
          countryCode.isAcceptableOrUnknown(
              data['country_code']!, _countryCodeMeta));
    } else if (isInserting) {
      context.missing(_countryCodeMeta);
    }
    if (data.containsKey('flag_url')) {
      context.handle(_flagUrlMeta,
          flagUrl.isAcceptableOrUnknown(data['flag_url']!, _flagUrlMeta));
    } else if (isInserting) {
      context.missing(_flagUrlMeta);
    }
    if (data.containsKey('added_at')) {
      context.handle(_addedAtMeta,
          addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta));
    } else if (isInserting) {
      context.missing(_addedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WishlistItemModel map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WishlistItemModel(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}id'])!,
      countryName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_name'])!,
      countryCode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}country_code'])!,
      flagUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}flag_url'])!,
      addedAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}added_at'])!,
    );
  }

  @override
  $WishlistTableTable createAlias(String alias) {
    return $WishlistTableTable(attachedDatabase, alias);
  }
}

class WishlistItemModel extends DataClass
    implements Insertable<WishlistItemModel> {
  final String id;
  final String countryName;
  final String countryCode;
  final String flagUrl;
  final DateTime addedAt;
  const WishlistItemModel(
      {required this.id,
      required this.countryName,
      required this.countryCode,
      required this.flagUrl,
      required this.addedAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['country_name'] = Variable<String>(countryName);
    map['country_code'] = Variable<String>(countryCode);
    map['flag_url'] = Variable<String>(flagUrl);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  WishlistTableCompanion toCompanion(bool nullToAbsent) {
    return WishlistTableCompanion(
      id: Value(id),
      countryName: Value(countryName),
      countryCode: Value(countryCode),
      flagUrl: Value(flagUrl),
      addedAt: Value(addedAt),
    );
  }

  factory WishlistItemModel.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WishlistItemModel(
      id: serializer.fromJson<String>(json['id']),
      countryName: serializer.fromJson<String>(json['countryName']),
      countryCode: serializer.fromJson<String>(json['countryCode']),
      flagUrl: serializer.fromJson<String>(json['flagUrl']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'countryName': serializer.toJson<String>(countryName),
      'countryCode': serializer.toJson<String>(countryCode),
      'flagUrl': serializer.toJson<String>(flagUrl),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  WishlistItemModel copyWith(
          {String? id,
          String? countryName,
          String? countryCode,
          String? flagUrl,
          DateTime? addedAt}) =>
      WishlistItemModel(
        id: id ?? this.id,
        countryName: countryName ?? this.countryName,
        countryCode: countryCode ?? this.countryCode,
        flagUrl: flagUrl ?? this.flagUrl,
        addedAt: addedAt ?? this.addedAt,
      );
  WishlistItemModel copyWithCompanion(WishlistTableCompanion data) {
    return WishlistItemModel(
      id: data.id.present ? data.id.value : this.id,
      countryName:
          data.countryName.present ? data.countryName.value : this.countryName,
      countryCode:
          data.countryCode.present ? data.countryCode.value : this.countryCode,
      flagUrl: data.flagUrl.present ? data.flagUrl.value : this.flagUrl,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WishlistItemModel(')
          ..write('id: $id, ')
          ..write('countryName: $countryName, ')
          ..write('countryCode: $countryCode, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, countryName, countryCode, flagUrl, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WishlistItemModel &&
          other.id == this.id &&
          other.countryName == this.countryName &&
          other.countryCode == this.countryCode &&
          other.flagUrl == this.flagUrl &&
          other.addedAt == this.addedAt);
}

class WishlistTableCompanion extends UpdateCompanion<WishlistItemModel> {
  final Value<String> id;
  final Value<String> countryName;
  final Value<String> countryCode;
  final Value<String> flagUrl;
  final Value<DateTime> addedAt;
  final Value<int> rowid;
  const WishlistTableCompanion({
    this.id = const Value.absent(),
    this.countryName = const Value.absent(),
    this.countryCode = const Value.absent(),
    this.flagUrl = const Value.absent(),
    this.addedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WishlistTableCompanion.insert({
    required String id,
    required String countryName,
    required String countryCode,
    required String flagUrl,
    required DateTime addedAt,
    this.rowid = const Value.absent(),
  })  : id = Value(id),
        countryName = Value(countryName),
        countryCode = Value(countryCode),
        flagUrl = Value(flagUrl),
        addedAt = Value(addedAt);
  static Insertable<WishlistItemModel> custom({
    Expression<String>? id,
    Expression<String>? countryName,
    Expression<String>? countryCode,
    Expression<String>? flagUrl,
    Expression<DateTime>? addedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (countryName != null) 'country_name': countryName,
      if (countryCode != null) 'country_code': countryCode,
      if (flagUrl != null) 'flag_url': flagUrl,
      if (addedAt != null) 'added_at': addedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WishlistTableCompanion copyWith(
      {Value<String>? id,
      Value<String>? countryName,
      Value<String>? countryCode,
      Value<String>? flagUrl,
      Value<DateTime>? addedAt,
      Value<int>? rowid}) {
    return WishlistTableCompanion(
      id: id ?? this.id,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
      flagUrl: flagUrl ?? this.flagUrl,
      addedAt: addedAt ?? this.addedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (countryName.present) {
      map['country_name'] = Variable<String>(countryName.value);
    }
    if (countryCode.present) {
      map['country_code'] = Variable<String>(countryCode.value);
    }
    if (flagUrl.present) {
      map['flag_url'] = Variable<String>(flagUrl.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WishlistTableCompanion(')
          ..write('id: $id, ')
          ..write('countryName: $countryName, ')
          ..write('countryCode: $countryCode, ')
          ..write('flagUrl: $flagUrl, ')
          ..write('addedAt: $addedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $WishlistTableTable wishlistTable = $WishlistTableTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [wishlistTable];
}

typedef $$WishlistTableTableCreateCompanionBuilder = WishlistTableCompanion
    Function({
  required String id,
  required String countryName,
  required String countryCode,
  required String flagUrl,
  required DateTime addedAt,
  Value<int> rowid,
});
typedef $$WishlistTableTableUpdateCompanionBuilder = WishlistTableCompanion
    Function({
  Value<String> id,
  Value<String> countryName,
  Value<String> countryCode,
  Value<String> flagUrl,
  Value<DateTime> addedAt,
  Value<int> rowid,
});

class $$WishlistTableTableFilterComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryName => $composableBuilder(
      column: $table.countryName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get flagUrl => $composableBuilder(
      column: $table.flagUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnFilters(column));
}

class $$WishlistTableTableOrderingComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryName => $composableBuilder(
      column: $table.countryName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get flagUrl => $composableBuilder(
      column: $table.flagUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
      column: $table.addedAt, builder: (column) => ColumnOrderings(column));
}

class $$WishlistTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $WishlistTableTable> {
  $$WishlistTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get countryName => $composableBuilder(
      column: $table.countryName, builder: (column) => column);

  GeneratedColumn<String> get countryCode => $composableBuilder(
      column: $table.countryCode, builder: (column) => column);

  GeneratedColumn<String> get flagUrl =>
      $composableBuilder(column: $table.flagUrl, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$WishlistTableTableTableManager extends RootTableManager<
    _$AppDatabase,
    $WishlistTableTable,
    WishlistItemModel,
    $$WishlistTableTableFilterComposer,
    $$WishlistTableTableOrderingComposer,
    $$WishlistTableTableAnnotationComposer,
    $$WishlistTableTableCreateCompanionBuilder,
    $$WishlistTableTableUpdateCompanionBuilder,
    (
      WishlistItemModel,
      BaseReferences<_$AppDatabase, $WishlistTableTable, WishlistItemModel>
    ),
    WishlistItemModel,
    PrefetchHooks Function()> {
  $$WishlistTableTableTableManager(_$AppDatabase db, $WishlistTableTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WishlistTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WishlistTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WishlistTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> id = const Value.absent(),
            Value<String> countryName = const Value.absent(),
            Value<String> countryCode = const Value.absent(),
            Value<String> flagUrl = const Value.absent(),
            Value<DateTime> addedAt = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistTableCompanion(
            id: id,
            countryName: countryName,
            countryCode: countryCode,
            flagUrl: flagUrl,
            addedAt: addedAt,
            rowid: rowid,
          ),
          createCompanionCallback: ({
            required String id,
            required String countryName,
            required String countryCode,
            required String flagUrl,
            required DateTime addedAt,
            Value<int> rowid = const Value.absent(),
          }) =>
              WishlistTableCompanion.insert(
            id: id,
            countryName: countryName,
            countryCode: countryCode,
            flagUrl: flagUrl,
            addedAt: addedAt,
            rowid: rowid,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $$WishlistTableTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $WishlistTableTable,
    WishlistItemModel,
    $$WishlistTableTableFilterComposer,
    $$WishlistTableTableOrderingComposer,
    $$WishlistTableTableAnnotationComposer,
    $$WishlistTableTableCreateCompanionBuilder,
    $$WishlistTableTableUpdateCompanionBuilder,
    (
      WishlistItemModel,
      BaseReferences<_$AppDatabase, $WishlistTableTable, WishlistItemModel>
    ),
    WishlistItemModel,
    PrefetchHooks Function()>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$WishlistTableTableTableManager get wishlistTable =>
      $$WishlistTableTableTableManager(_db, _db.wishlistTable);
}
