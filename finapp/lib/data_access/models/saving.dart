import 'package:floor/floor.dart';
import 'package:flutter/foundation.dart';

@Entity(tableName: 'Savings')
class Saving {
  @PrimaryKey(autoGenerate: true)
  int? id;
  final String category;
  final String title;
  final String description;
  final double amount;
  final DateTime startTimeInterval;
  final DateTime endTimeInterval;
  DateTime lastUpdateDate;
  final bool committed;

  Saving(
      {this.id,
      required this.category,
      required this.title,
      required this.description,
      required this.amount,
      required this.startTimeInterval,
      required this.endTimeInterval,
      required this.lastUpdateDate,
      required this.committed});

  Saving copyWith({
    int? id,
    String? category,
    String? title,
    String? description,
    double? amount,
    DateTime? startTimeInterval,
    DateTime? endTimeInterval,
    DateTime? lastUpdateDate,
    required bool committed,
  }) {
    return Saving(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      startTimeInterval: startTimeInterval ?? this.startTimeInterval,
      endTimeInterval: endTimeInterval ?? this.endTimeInterval,
      lastUpdateDate: lastUpdateDate ?? this.lastUpdateDate,
      committed: committed,
    );
  }

  factory Saving.fromJson(Map<String, dynamic> json) => Saving(
      id: json["id"],
      category: json["category"] ?? "",
      title: json["title"] ?? "",
      description: json["description"] ?? "",
      amount: json["amount"] + 0.0,
      startTimeInterval: DateTime.parse(json["startTimeInterval"].toString()),
      endTimeInterval: DateTime.parse(json["endTimeInterval"].toString()),
      lastUpdateDate: DateTime.parse(json["lastUpdateDate"].toString()),
      committed: json["isCommited"]);

  Map<String, dynamic> toJson() => {
        "category": category,
        "title": title,
        "description": description,
        "amount": amount,
        "startTimeInterval": startTimeInterval.toIso8601String(),
        "endTimeInterval": endTimeInterval.toIso8601String(),
        "isCommited": committed
      };
}
