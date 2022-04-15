import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class JoinEditNameScreen extends StatefulWidget {
  final Function(String) onChangeName;
  final String name;

  const JoinEditNameScreen({
    Key? key,
    required this.name,
    required this.onChangeName,
  }) : super(key: key);

  @override
  State<JoinEditNameScreen> createState() => _JoinEditNameScreenState();
}

class _JoinEditNameScreenState extends State<JoinEditNameScreen> {
  final _nameController = TextEditingController();

  get shouldEnableEditButton => _nameController.text.isNotEmpty;
  get editMode => widget.name.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.only(
            top: 16,
            bottom: 8,
            left: 16,
            right: 16,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const TitleText(text: 'Edit name'),
                const DescriptionText(text: 'Ticket details'),
                StyledTextField(
                  placeholder: 'Name *',
                  controller: _nameController,
                  onChanged: (_) => setState(() {}),
                ),
                RoundedButton(
                  title: 'Edit name',
                  enabled: shouldEnableEditButton,
                  onPressed: () {
                    widget.onChangeName(
                      _nameController.text,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
