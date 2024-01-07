import 'package:finapp/data_access/models/saving.dart';
import 'package:floor/floor.dart';

@dao
abstract class SavingDao {
  @Query('SELECT * FROM Savings')
  Future<List<Saving>> getAllSavings();

  @insert
  Future<int> insertSaving(Saving saving);

  @delete
  Future<void> deleteSaving(Saving saving);

  @update
  Future<void> updateSaving(Saving saving);

  @update
  Future<void> updateSavings(List<Saving> savings);
}