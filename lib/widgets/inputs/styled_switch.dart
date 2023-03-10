import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';
import 'package:universal_io/io.dart';

class StyledSwitch extends StatefulWidget {
  final String text;
  final bool value;
  final void Function(bool)? onChanged;

  const StyledSwitch({
    Key? key,
    required this.text,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  State<StyledSwitch> createState() => _StyledSwitchState();
}

class _StyledSwitchState extends State<StyledSwitch> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    value = widget.value;
  }

  void onChange(bool newValue) {
    setState(() {
      value = newValue;
    });
    widget.onChanged?.call(newValue);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Text(
              widget.text,
              style: descriptionTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          const Spacer(),
          _platformSwitch(),
        ],
      ),
    );
  }

  Widget _platformSwitch() {
    if (Platform.isIOS) {
      return CupertinoSwitch(
        value: value,
        onChanged: onChange,
        activeColor: primaryColor,
      );
    } else {
      return Switch(
        value: value,
        onChanged: onChange,
        activeColor: primaryColor,
      );
    }
  }
}
