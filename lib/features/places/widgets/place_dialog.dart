import 'package:flutter/material.dart';
import '../../../core/l10n.dart';

Future<String?> showPlaceDialog(BuildContext context, AppStrings strings,
    {String? title, String? initialValue}) {
  final controller = TextEditingController(text: initialValue);
  final formKey = GlobalKey<FormState>();
  return showDialog<String>(
    context: context,
    builder: (ctx) => Directionality(
      textDirection: strings.isArabic ? TextDirection.rtl : TextDirection.ltr,
      child: AlertDialog(
        title: Text(title ?? strings.addPlace),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            autofocus: true,
            decoration: InputDecoration(
              labelText: strings.name,
              border: const OutlineInputBorder(),
            ),
            validator: (v) => v == null || v.trim().isEmpty ? strings.nameRequired : null,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(strings.cancel),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                Navigator.pop(ctx, controller.text.trim());
              }
            },
            child: Text(strings.save),
          ),
        ],
      ),
    ),
  );
}
