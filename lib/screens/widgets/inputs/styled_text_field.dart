import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledTextField extends StatefulWidget {
  final String? input;
  final String placeholder;
  final Function(String?)? onChanged;

  const StyledTextField({
    Key? key,
    this.input,
    required this.placeholder,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  String? text;

  @override
  void initState() {
    super.initState();
    text = widget.input;
  }

  void onChanged(String? newValue) {
    text = newValue;
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: widget.placeholder,
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBackgroundColor,
          filled: true,
          labelStyle: const TextStyle(
            color: primaryColor,
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        onChanged: onChanged,
        initialValue: text,
        cursorColor: primaryColor,
      ),
    );
  }
}
