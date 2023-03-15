import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';

class StyledTextField extends StatefulWidget {
  final String? input;
  final String placeholder;
  final TextEditingController? controller;
  final Function(String?)? onChanged;
  final VoidCallback? onFieldSubmitted;
  final EdgeInsets? padding;
  final bool? autofocus;
  final bool enabled;

  const StyledTextField({
    Key? key,
    this.input,
    required this.placeholder,
    this.controller,
    this.onChanged,
    this.onFieldSubmitted,
    this.padding,
    this.autofocus,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<StyledTextField> createState() => _StyledTextFieldState();
}

class _StyledTextFieldState extends State<StyledTextField> {
  late TextEditingController _controller;
  String? text;

  @override
  void initState() {
    super.initState();
    text = widget.input;
    _controller = widget.controller ?? TextEditingController(text: text);
  }

  @override
  void didUpdateWidget(covariant StyledTextField oldWidget) {
    if (widget.input != _controller.text) {
      text = widget.input;
      if (text != null) _controller.text = text!;
    }
    super.didUpdateWidget(oldWidget);
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
            vertical: 8,
          ),
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
          labelText: widget.placeholder,
          contentPadding: const EdgeInsets.all(10),
          filled: true,
          labelStyle: descriptionColoredTextStyle,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: primaryColor),
          ),
        ),
        onChanged: onChanged,
        cursorColor: primaryColor,
        autofocus: widget.autofocus == true,
        enabled: widget.enabled,
        onFieldSubmitted: (_) => widget.onFieldSubmitted?.call(),
      ),
    );
  }
}
