import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledTextField extends StatefulWidget {
  final String? input;
  final String placeholder;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final EdgeInsets? padding;
  final bool? autofocus;

  const StyledTextField({
    Key? key,
    this.input,
    required this.placeholder,
    this.controller,
    this.onChanged,
    this.padding,
    this.autofocus,
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
      padding: widget.padding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.placeholder,
          contentPadding: const EdgeInsets.all(10),
          fillColor: inputBackgroundColor,
          filled: true,
          labelStyle: descriptionColoredTextStyle,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: inputBackgroundColor),
          ),
        ),
        onChanged: onChanged,
        initialValue: text,
        cursorColor: primaryColor,
        autofocus: widget.autofocus ?? false,
      ),
    );
  }
}
