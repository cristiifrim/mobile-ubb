import 'dart:io';

import 'package:dio/dio.dart';
import 'package:finapp/data_access/dao/saving_dao.dart';
import 'package:finapp/data_access/models/saving.dart';

class SavingBusinessLogic {
  final SavingDao _savingDao;

  String apiUrl = "http://10.0.2.2:5062/api";
  List<Saving> savings = [];

  SavingBusinessLogic(this._savingDao);

  Future<void> addSaving(
      String title,
      String category,
      String description,
      double amount,
      DateTime startTimeInterval,
      DateTime endTimeInterval) async {
    var saving = Saving(
        category: category,
        title: title,
        description: description,
        amount: amount,
        startTimeInterval: startTimeInterval,
        endTimeInterval: endTimeInterval,
        lastUpdateDate: DateTime.now(),
        committed: false);

    if (await hasNetwork()) {
      try {
        print("Add on server");
        Response serverResponse =
            await Dio().post("$apiUrl/Savings", data: saving.toJson());
        saving = Saving.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(e.response?.data ?? "Error while adding the saving!");
        } else {
          throw Exception(
              "An unexpected error appeared while adding the saving.");
        }
      }
    } else {
      print("Add on local db");
      saving.id = await _savingDao.insertSaving(saving);
    }

    savings.add(saving);
  }

  Future<List<Saving>> getAllSavings() async {
    if (await hasNetwork()) {
      try {
        print("Retrieve from server");
        Response serverResponse = await Dio().get("$apiUrl/Savings");
        var rawList = serverResponse.data as List;
        savings = rawList.map((e) => Saving.fromJson(e)).toList();
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(
              e.response?.data ?? "Error while requesting the savings!");
        } else {
          throw Exception(
              "An unexpected error appeared while requesting the savings.");
        }
      }
    } else {
      print("Retrieve from local database");
      savings = await _savingDao.getAllSavings();
    }
    return savings;
  }

  Future<void> updateSavings() async {
    await _savingDao.updateSavings(savings);
  }

  Future<void> updateSaving(Saving saving) async {
    int index = savings.indexWhere((s) => s.id == saving.id);
    if (await hasNetwork()) {
      try {
        print("Update on server");
        int savingId = saving.id ?? -1;
        Response serverResponse =
            await Dio().put("$apiUrl/Savings/$savingId", data: saving.toJson());
        var updatedSaving = Saving.fromJson(serverResponse.data);
        if (index != -1) {
          savings[index] = updatedSaving;
        }
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(
              e.response?.data ?? "Error while updating the saving!");
        } else {
          throw Exception(
              "An unexpected error appeared while updating the saving.");
        }
      }
    } else {
      print("Update locally");
      await _savingDao.updateSaving(saving);
      if (index != -1) {
        savings[index] = saving;
      }
    }
  }

  Future<void> deleteSaving(int index) async {
    var saving = savings.removeAt(index);
    if (await hasNetwork()) {
      try {
        print("Delete on server");
        int savingId = saving.id ?? -1;
        await Dio().delete("$apiUrl/Savings/$savingId");
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(
              e.response?.data ?? "Error while deleting the saving!");
        } else {
          throw Exception(
              "An unexpected error appeared while deleting the saving.");
        }
      }
    } else {
      print("Delete on local db");
      await _savingDao.deleteSaving(saving);
    }
  }

  Future<void> commitSaving(int index) async {
    Saving updatedSaving =
        savings[index].copyWith(committed: !savings[index].committed);
    if (await hasNetwork()) {
      try {
        print("Commit on server");
        int savingId = updatedSaving.id ?? -1;
        Response serverResponse = await Dio()
            .put("$apiUrl/Savings/$savingId", data: updatedSaving.toJson());
        updatedSaving = Saving.fromJson(serverResponse.data);
      } on DioException catch (e) {
        if (e.response != null) {
          throw Exception(
              e.response?.data ?? "Error while committing the saving!");
        } else {
          throw Exception(
              "An unexpected error appeared while committing the saving.");
        }
      }
    } else {
      print("Commit on local db");
      await _savingDao.updateSaving(updatedSaving);
    }
    savings[index] = updatedSaving;
  }

  Future<bool> hasNetwork() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }
}
