// update_saving_screen.dart

import 'package:finapp/data_access/models/saving.dart';
import 'package:flutter/material.dart';

class UpdateSavingScreen extends StatefulWidget {
  final Saving saving;
  final Function(Saving) onUpdate;

  const UpdateSavingScreen(
      {super.key, required this.saving, required this.onUpdate});

  @override
  _UpdateSavingScreenState createState() => _UpdateSavingScreenState();
}

class _UpdateSavingScreenState extends State<UpdateSavingScreen> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  DateTime startTimeInterval = DateTime.now();
  DateTime endTimeInterval = DateTime.now().add(const Duration(days: 30));

  @override
  void initState() {
    super.initState();
    categoryController.text = widget.saving.category;
    titleController.text = widget.saving.title;
    descriptionController.text = widget.saving.description;
    amountController.text = widget.saving.amount.toString();
    startTimeInterval = widget.saving.startTimeInterval;
    endTimeInterval = widget.saving.endTimeInterval;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Update Saving'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Category',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(hintText: 'Enter category'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Title',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(hintText: 'Enter title'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Description',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: descriptionController,
                  decoration:
                      const InputDecoration(hintText: 'Enter description'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(hintText: 'Enter amount'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Start Time Interval',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: startTimeInterval,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != startTimeInterval) {
                      setState(() {
                        startTimeInterval = picked;
                      });
                    }
                  },
                  child: const Text('Pick Start Date'),
                ),
                const SizedBox(height: 15),
                const Text(
                  'End Time Interval',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: endTimeInterval,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != endTimeInterval) {
                      setState(() {
                        endTimeInterval = picked;
                      });
                    }
                  },
                  child: const Text('Pick End Date'),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    Saving updatedSaving = Saving(
                      id: widget.saving.id,
                      category: categoryController.text,
                      title: titleController.text,
                      description: descriptionController.text,
                      amount: double.parse(amountController.text),
                      startTimeInterval: startTimeInterval,
                      endTimeInterval: endTimeInterval,
                      lastUpdateDate: DateTime.now(),
                      committed: widget.saving.committed,
                    );
                    widget.onUpdate(updatedSaving);
                    Navigator.pop(context);
                  },
                  child: const Text('Update Saving'),
                ),
              ],
            ),
          ),
        ));
  }
}
