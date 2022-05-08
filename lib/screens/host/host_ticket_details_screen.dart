import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/title_text.dart';

class HostTicketDetailsScreen extends StatefulWidget {
  final Set<String> tags;
  final Function(String, String?, Set<String> tags) onAddTicket;
  final String? title;
  final String? description;

  const HostTicketDetailsScreen({
    Key? key,
    required this.tags,
    required this.onAddTicket,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  State<HostTicketDetailsScreen> createState() =>
      _HostTicketDetailsScreenState();
}

class _HostTicketDetailsScreenState extends State<HostTicketDetailsScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  get shouldEnableAddButton => _titleController.text.isNotEmpty;
  get editMode => widget.title != null || widget.description != null;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title ?? '';
    _descriptionController.text = widget.description ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints.tightFor(width: maxWidth),
        child: ListView(
          shrinkWrap: kIsWeb,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.only(
                  top: 16, bottom: 8, left: 16, right: 16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    TitleText(
                        text: editMode ? 'Edit ticket' : 'Add a new ticket'),
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
                      title: editMode ? 'Edit ticket' : 'Add ticket',
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
        ),
      ),
    );
  }
}
