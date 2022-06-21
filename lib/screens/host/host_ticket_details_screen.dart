import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mamba/ui_constants.dart';
import 'package:mamba/widgets/buttons/rounded_button.dart';
import 'package:mamba/widgets/chips/add_chip.dart';
import 'package:mamba/widgets/chips/chip_wrap.dart';
import 'package:mamba/widgets/chips/styled_chip.dart';
import 'package:mamba/widgets/dialog/text_field_dialog.dart';
import 'package:mamba/widgets/inputs/styled_text_field.dart';
import 'package:mamba/widgets/text/description_text.dart';
import 'package:mamba/widgets/text/sub_title_text.dart';
import 'package:mamba/widgets/text/title_text.dart';
import 'package:universal_io/io.dart';

class HostTicketDetailsScreen extends StatefulWidget {
  final Set<String> tags;
  final Set<String> selectedTags;
  final Function(String, String?, Set<String> tags, Set<String> selectedTags)
      onAddTicket;
  final String? title;
  final String? description;

  const HostTicketDetailsScreen({
    Key? key,
    required this.tags,
    required this.selectedTags,
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
  Set<String> tags = {};
  // ignore: prefer_final_fields
  Set<String> _selectedTags = {};
  final _textController = TextEditingController();

  get shouldEnableAddButton => _titleController.text.isNotEmpty;
  get editMode => widget.title != null || widget.description != null;
  get shouldShowBackButton => Platform.isAndroid;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.title ?? '';
    _descriptionController.text = widget.description ?? '';
    tags.addAll(widget.tags);
    _selectedTags.addAll(widget.selectedTags);
  }

  void _addChip(String tag) {
    setState(() {
      tags.add(tag);
      _selectedTags.add(tag);
    });
  }

  List<Widget> chipList() {
    List<Widget> styledChipList = tags
        .map(
          (tag) => GestureDetector(
            onTap: () => setState(() {
              _selectedTags.contains(tag)
                  ? _selectedTags.remove(tag)
                  : _selectedTags.add(tag);
            }),
            child: StyledChip(
              text: tag,
              selected: _selectedTags.contains(tag),
              onDeleted: () => setState(() {
                tags.remove(tag);
                _selectedTags.remove(tag);
              }),
            ),
          ),
        )
        .cast<Widget>()
        .toList();

    styledChipList.add(
      AddChip(
        onTap: () => TextFieldAlertDialog.show(
          title: 'Add voting tag',
          placeholder: 'Enter tag name',
          primaryActionTitle: 'Add',
          context: context,
          controller: _textController,
          textFieldInput: _addChip,
        ),
      ),
    );
    return styledChipList;
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
                    Row(
                      children: [
                        if (shouldShowBackButton) ...[
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            iconSize: 30,
                            icon: const Icon(Icons.chevron_left),
                          ),
                        ],
                        Expanded(
                          child: TitleText(
                            text: editMode ? 'Edit ticket' : 'Add a new ticket',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        if (shouldShowBackButton) ...[
                          const SizedBox(width: 48),
                        ],
                      ],
                    ),
                    const DescriptionText(text: 'Ticket details'),
                    const SizedBox(height: 10),
                    StyledTextField(
                      placeholder: 'Title *',
                      controller: _titleController,
                      onChanged: (_) => setState(() {}),
                      autofocus: true,
                    ),
                    StyledTextField(
                      placeholder: 'Description',
                      controller: _descriptionController,
                    ),
                    const SizedBox(height: 10),
                    const SubTitleText(text: 'Tags'),
                    const DescriptionText(
                      text:
                          'Add tags that allow participants to vote for a specific tag, for example a specific platform or technology',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    ChipWrap(
                      children: chipList(),
                    ),
                    const SizedBox(height: 20),
                    RoundedButton(
                      title: editMode ? 'Edit ticket' : 'Add ticket',
                      enabled: shouldEnableAddButton,
                      onPressed: !shouldEnableAddButton
                          ? null
                          : () {
                              widget.onAddTicket(
                                _titleController.text,
                                _descriptionController.text,
                                tags,
                                _selectedTags,
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
