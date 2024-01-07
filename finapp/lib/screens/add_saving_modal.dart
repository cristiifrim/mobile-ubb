import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddSavingModal extends StatefulWidget {
  final Function(String, String, String, double, DateTime, DateTime) onSave;

  const AddSavingModal({super.key, required this.onSave});

  @override
  _AddSavingModalState createState() => _AddSavingModalState();
}

class _AddSavingModalState extends State<AddSavingModal> {
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();

  DateTime _startTimeInterval = DateTime.now();
  DateTime _endTimeInterval = DateTime.now().add(const Duration(days: 30));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Saving'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Add New Saving',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(labelText: 'Amount'),
                ),
                const SizedBox(height: 15),
                Text(
                    'Start Time Interval: ${DateFormat.yMMMd().format(_startTimeInterval)}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _startTimeInterval,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _startTimeInterval) {
                      setState(() {
                        _startTimeInterval = picked;
                      });
                    }
                  },
                  child: const Text('Pick Start Date'),
                ),
                const SizedBox(height: 15),
                Text(
                    'End Time Interval: ${DateFormat.yMMMd().format(_endTimeInterval)}'),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: _endTimeInterval,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2101),
                    );
                    if (picked != null && picked != _endTimeInterval) {
                      setState(() {
                        _endTimeInterval = picked;
                      });
                    }
                  },
                  child: const Text('Pick End Date'),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    widget.onSave(
                        titleController.text,
                        categoryController.text,
                        descriptionController.text,
                        double.parse(amountController.text),
                        _startTimeInterval,
                        _endTimeInterval);

                    // Close the modal and pass the new saving instance
                    Navigator.of(context).pop();
                  },
                  child: const Text('Add Saving'),
                ),
              ],
            ),
          ),
        ));
  }
}
