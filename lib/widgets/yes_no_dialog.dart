import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text(widget.answer),
      actions: [
        TextButton(
          onPressed: () {
            widget.doIfYes();
            Navigator.of(context).pop();
          },
          child: Text("Да", style: theme.textTheme.bodySmall),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Нет", style: theme.textTheme.bodySmall),
        ),
      ],
    );
  }
}
