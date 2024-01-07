import 'package:finapp/business_logic/saving_business_logic.dart';
import 'package:finapp/business_logic/web_socket_manager.dart';
import 'package:finapp/common/constants.dart';
import 'package:finapp/data_access/models/saving.dart';
import 'package:finapp/screens/update_saving_screen.dart';
import 'package:finapp/screens/add_saving_modal.dart';
import 'package:finapp/widgets/delete_confirmation_dialog.dart';
import 'package:finapp/widgets/saving_item.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final SavingBusinessLogic savingBusinessLogic;
  const Home({super.key, required this.savingBusinessLogic});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late WebSocketManager _webSocketManager;

  @override
  void initState() {
    super.initState();

    _webSocketManager = WebSocketManager(
        serverUrl: 'ws://10.0.2.2:5062/api/WebSocket/ws',
        onMessageReceived: (message) {
          // Handle the incoming message (e.g., update UI)
          openSnackbar(context, 'Notification: $message', 5);
        });

    widget.savingBusinessLogic.getAllSavings().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    _webSocketManager.disconnect();
    widget.savingBusinessLogic.updateSavings();
    super.dispose();
  }

  void openSnackbar(
      BuildContext context, String message, int durationInSeconds) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: durationInSeconds),
      ),
    );
  }

  void deleteSaving(int index) async {
    await widget.savingBusinessLogic.deleteSaving(index).then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error deleting saving: $e');
      openSnackbar(context, 'Error deleting saving: $e', 2);
    });
  }

  void addSaving(
      String title,
      String category,
      String description,
      double amount,
      DateTime startTimeInterval,
      DateTime endTimeInterval) async {
    await widget.savingBusinessLogic
        .addSaving(title, category, description, amount, startTimeInterval,
            endTimeInterval)
        .then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error adding saving: $e');
      openSnackbar(context, 'Error adding saving: $e', 2);
    });
    setState(() {});
  }

  void updateSaving(Saving updatedSaving) async {
    await widget.savingBusinessLogic.updateSaving(updatedSaving).then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error updating saving: $e');
      openSnackbar(context, 'Error updating saving: $e', 2);
    });
  }

  void commitSaving(int index) async {
    await widget.savingBusinessLogic.commitSaving(index).then((_) {
      setState(() {});
    }).catchError((e) {
      print('Error committing saving: $e');
      openSnackbar(context, 'Error committing saving: $e', 2);
    });
  }

  Future<void> _showAddSavingModal(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddSavingModal(onSave: addSaving),
      ),
    );
  }

  Future<void> _showUpdateSavingModal(
      BuildContext context, Saving saving) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            UpdateSavingScreen(saving: saving, onUpdate: updateSaving),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int index) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          onConfirm: () {
            // Handle delete confirmation
            deleteSaving(index);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade900,
        elevation: 0,
        title: Text(CommonConstants.appName),
        centerTitle: true,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
      ),
      body: Padding(
          padding: const EdgeInsets.all(20),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Savings',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.savingBusinessLogic.savings.length,
                itemBuilder: (context, index) => SavingItem(
                  entity: widget.savingBusinessLogic.savings[index],
                  onDelete: () => _showDeleteConfirmationDialog(context, index),
                  onCommit: () => commitSaving(index),
                  onUpdate: () => _showUpdateSavingModal(
                      context, widget.savingBusinessLogic.savings[index]),
                ),
              ),
            )
          ])),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddSavingModal(context),
        tooltip: 'Add saving',
        backgroundColor: Colors.green.shade600,
        child: const Icon(Icons.add),
      ),
    );
  }
}
