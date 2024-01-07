// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  SavingDao? _savingDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Savings` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `category` TEXT NOT NULL, `title` TEXT NOT NULL, `description` TEXT NOT NULL, `amount` REAL NOT NULL, `startTimeInterval` INTEGER NOT NULL, `endTimeInterval` INTEGER NOT NULL, `lastUpdateDate` INTEGER NOT NULL, `committed` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SavingDao get savingDao {
    return _savingDaoInstance ??= _$SavingDao(database, changeListener);
  }
}

class _$SavingDao extends SavingDao {
  _$SavingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _savingInsertionAdapter = InsertionAdapter(
            database,
            'Savings',
            (Saving item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'title': item.title,
                  'description': item.description,
                  'amount': item.amount,
                  'startTimeInterval':
                      _dateTimeConverter.encode(item.startTimeInterval),
                  'endTimeInterval':
                      _dateTimeConverter.encode(item.endTimeInterval),
                  'lastUpdateDate':
                      _dateTimeConverter.encode(item.lastUpdateDate),
                  'committed': item.committed ? 1 : 0
                }),
        _savingUpdateAdapter = UpdateAdapter(
            database,
            'Savings',
            ['id'],
            (Saving item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'title': item.title,
                  'description': item.description,
                  'amount': item.amount,
                  'startTimeInterval':
                      _dateTimeConverter.encode(item.startTimeInterval),
                  'endTimeInterval':
                      _dateTimeConverter.encode(item.endTimeInterval),
                  'lastUpdateDate':
                      _dateTimeConverter.encode(item.lastUpdateDate),
                  'committed': item.committed ? 1 : 0
                }),
        _savingDeletionAdapter = DeletionAdapter(
            database,
            'Savings',
            ['id'],
            (Saving item) => <String, Object?>{
                  'id': item.id,
                  'category': item.category,
                  'title': item.title,
                  'description': item.description,
                  'amount': item.amount,
                  'startTimeInterval':
                      _dateTimeConverter.encode(item.startTimeInterval),
                  'endTimeInterval':
                      _dateTimeConverter.encode(item.endTimeInterval),
                  'lastUpdateDate':
                      _dateTimeConverter.encode(item.lastUpdateDate),
                  'committed': item.committed ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Saving> _savingInsertionAdapter;

  final UpdateAdapter<Saving> _savingUpdateAdapter;

  final DeletionAdapter<Saving> _savingDeletionAdapter;

  @override
  Future<List<Saving>> getAllSavings() async {
    return _queryAdapter.queryList('SELECT * FROM Savings',
        mapper: (Map<String, Object?> row) => Saving(
            id: row['id'] as int?,
            category: row['category'] as String,
            title: row['title'] as String,
            description: row['description'] as String,
            amount: row['amount'] as double,
            startTimeInterval:
                _dateTimeConverter.decode(row['startTimeInterval'] as int),
            endTimeInterval:
                _dateTimeConverter.decode(row['endTimeInterval'] as int),
            lastUpdateDate:
                _dateTimeConverter.decode(row['lastUpdateDate'] as int),
            committed: (row['committed'] as int) != 0));
  }

  @override
  Future<int> insertSaving(Saving saving) {
    return _savingInsertionAdapter.insertAndReturnId(
        saving, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSaving(Saving saving) async {
    await _savingUpdateAdapter.update(saving, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateSavings(List<Saving> savings) async {
    await _savingUpdateAdapter.updateList(savings, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteSaving(Saving saving) async {
    await _savingDeletionAdapter.delete(saving);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
