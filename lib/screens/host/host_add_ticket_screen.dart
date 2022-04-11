import 'package:flutter/material.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class HostAddTicketScreen extends StatefulWidget {
  final Set<String> tags;
  final Function(String, String?, Set<String> tags) onAddTicket;

  const HostAddTicketScreen({
    Key? key,
    required this.tags,
    required this.onAddTicket,
  }) : super(key: key);

  @override
  State<HostAddTicketScreen> createState() => _HostAddTicketScreenState();
}

class _HostAddTicketScreenState extends State<HostAddTicketScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  get shouldEnableAddButton => _titleController.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          margin:
              const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const TitleText(text: 'Add a new ticket'),
                const DescriptionText(text: 'Ticket details'),
                StyledTextField(
                  placeholder: 'Title *',
                  controller: _titleController,
                  onChanged: (_) => setState(() {}),
                ),
                StyledTextField(
                  placeholder: 'Description',
                  controller: _descriptionController,
                ),
                //TODO: Tag selection
                RoundedButton(
                  title: 'Add ticket',
                  enabled: shouldEnableAddButton,
                  onPressed: () {
                    widget.onAddTicket(
                      _titleController.text,
                      _descriptionController.text,
                      {},
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
