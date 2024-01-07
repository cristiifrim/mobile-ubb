import 'package:finapp/data_access/models/saving.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SavingItem extends StatelessWidget {
  final Saving entity;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  final VoidCallback onCommit;

  const SavingItem(
      {required this.entity,
      required this.onDelete,
      required this.onUpdate,
      required this.onCommit,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green.shade500,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        leading: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 35, // Set a fixed width for the commit button
              height: 35,
              child: IconButton(
                icon: Icon(
                  entity.committed
                      ? Icons.check_circle_outline
                      : Icons.check_circle,
                  color: entity.committed ? Colors.blueAccent : Colors.grey,
                ),
                onPressed: onCommit,
              ),
            ),
            SizedBox(
              width: 30, // Set a fixed width for the Container
              child: Text(
                entity.committed ? 'Uncommit' : 'Commit',
                style: const TextStyle(fontSize: 10),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${DateFormat.yMMMd().format(entity.startTimeInterval)} to ${DateFormat.yMMMd().format(entity.endTimeInterval)}',
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w400),
            ),
            Text('${entity.title} #${entity.category}',
                overflow: TextOverflow.ellipsis,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            Text(
              'Amount: ${entity.amount} RON',
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Description: ${entity.description}',
            ),
          ],
        ),
        trailing: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.delete, size: 30, color: Colors.red),
                onPressed: onDelete,
              ),
              IconButton(
                icon: const Icon(
                  Icons.edit,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: onUpdate,
              )
            ]),
      ),
    );
  }
}
