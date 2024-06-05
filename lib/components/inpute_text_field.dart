import 'package:flutter/material.dart';

class InputTextField extends StatelessWidget {
  const InputTextField({super.key, 
    required this.textEditingController,
    required this.label,
    required this.onValidator,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final TextEditingController textEditingController;
  final String? Function(String? value) onValidator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: onValidator,
      decoration: InputDecoration(
        label: Text(label),
        hintText: label,
        prefixIcon: Icon(icon),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          // borderSide: BorderSide(
          //     color: Colors.grey.withOpacity(.3), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
            width: 2.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 1,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.error,
            width: 2,
          ),
        ),
      ),
    );
  }
}
