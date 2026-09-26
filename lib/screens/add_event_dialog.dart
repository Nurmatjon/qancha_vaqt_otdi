import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/event.dart';
import '../models/event_category.dart';

Future<Event?> showAddEventDialog(BuildContext context, {Event? event}) async {
  final l10n = AppLocalizations.of(context)!;

  final titleController = TextEditingController(text: event?.title ?? '');

  final descriptionController = TextEditingController(
    text: event?.description ?? '',
  );

  DateTime selectedDate = event?.dateTime ?? DateTime.now();

  TimeOfDay selectedTime = event != null
      ? TimeOfDay(hour: event.dateTime.hour, minute: event.dateTime.minute)
      : TimeOfDay.now();

  EventCategory selectedCategory = event?.category ?? EventCategory.general;

  final result = await showDialog<Event>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final isEditing = event != null;

          String formatDate(DateTime date) {
            return '${date.day.toString().padLeft(2, '0')}.'
                '${date.month.toString().padLeft(2, '0')}.'
                '${date.year}';
          }

          return AlertDialog(
            title: Text(isEditing ? l10n.editEventTitle : l10n.newEventTitle),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: titleController,
                    autofocus: !isEditing,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: l10n.eventName,
                      hintText: l10n.eventNameHint,
                      prefixIcon: const Icon(Icons.edit),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<EventCategory>(
                    initialValue: selectedCategory,
                    decoration: InputDecoration(
                      labelText: l10n.category,
                      prefixIcon: const Icon(Icons.category),
                      border: const OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: EventCategory.general,
                        child: Text(l10n.generalEvent),
                      ),
                      DropdownMenuItem(
                        value: EventCategory.birthday,
                        child: Text(l10n.birthday),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() {
                          selectedCategory = value;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final pickedDate = await showDatePicker(
                              context: context,
                              initialDate: selectedDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              setDialogState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                          icon: const Icon(Icons.calendar_today),
                          label: Text(formatDate(selectedDate)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final pickedTime = await showTimePicker(
                              context: context,
                              initialTime: selectedTime,
                            );

                            if (pickedTime != null) {
                              setDialogState(() {
                                selectedTime = pickedTime;
                              });
                            }
                          },
                          icon: const Icon(Icons.access_time),
                          label: Text(selectedTime.format(context)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      labelText: l10n.shortDescription,
                      hintText: l10n.shortDescriptionHint,
                      prefixIcon: const Icon(Icons.notes),
                      border: const OutlineInputBorder(),
                      alignLabelWithHint: true,
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(l10n.cancel),
              ),
              FilledButton.icon(
                onPressed: () {
                  final title = titleController.text.trim();

                  if (title.isEmpty) {
                    return;
                  }

                  final dateTime = DateTime(
                    selectedDate.year,
                    selectedDate.month,
                    selectedDate.day,
                    selectedTime.hour,
                    selectedTime.minute,
                  );

                  Navigator.pop(
                    context,
                    Event(
                      title: title,
                      dateTime: dateTime,
                      description: descriptionController.text.trim(),
                      category: selectedCategory,
                    ),
                  );
                },
                icon: const Icon(Icons.save),
                label: Text(l10n.save),
              ),
            ],
          );
        },
      );
    },
  );

  titleController.dispose();
  descriptionController.dispose();

  return result;
}
