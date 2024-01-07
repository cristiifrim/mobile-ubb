// database.dart

// required package imports
import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'package:finapp/common/helpers/date_time_converter.dart';
import 'package:finapp/data_access/dao/saving_dao.dart';
import 'package:finapp/data_access/models/saving.dart';

part 'app_database.g.dart'; // the generated code will be there

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [Saving])
abstract class AppDatabase extends FloorDatabase {
  SavingDao get savingDao;
}