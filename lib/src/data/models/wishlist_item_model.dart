import 'package:drift/drift.dart';

@DataClassName('WishlistItemModel')
class WishlistTable extends Table {
  TextColumn get id => text()();
  TextColumn get countryName => text()();
  TextColumn get countryCode => text()();
  TextColumn get flagUrl => text()();
  DateTimeColumn get addedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
