import 'package:flutter/material.dart';
import 'package:technical_store/constants.dart';

class YesNoDialog extends StatefulWidget {
  final String answer;
  final VoidCallback doIfYes;

  const YesNoDialog({super.key, required this.answer, required this.doIfYes});

  @override
  State<YesNoDialog> createState() => _OkNoDialogState();
}

class _OkNoDialogState extends State<YesNoDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.answer),
      actions: [
        TextButton(
          onPressed: () {
            widget.doIfYes(); 
            Navigator.of(context).pop();
          },
          child: Text("Да", style: TextStyle(color: kTextColor, fontSize: 20)),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Нет", style: TextStyle(color: kTextColor, fontSize: 20)),
        ),
      ],
    );
  }
}
