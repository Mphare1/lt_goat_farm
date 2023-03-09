import 'package:flutter/material.dart';

class AddFeedMedicineDialog extends StatefulWidget {
  final String type;

  const AddFeedMedicineDialog({Key? key, required this.type}) : super(key: key);

  @override
  _AddFeedMedicineDialogState createState() => _AddFeedMedicineDialogState();
}

class _AddFeedMedicineDialogState extends State<AddFeedMedicineDialog> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _save() {
    final name = _textEditingController.text.trim();
    Navigator.pop(context, name);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add ${widget.type}'),
      content: TextField(
        controller: _textEditingController,
        decoration: InputDecoration(hintText: 'Enter ${widget.type} name'),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _save,
          child: Text('SAVE'),
        ),
      ],
    );
  }
}
