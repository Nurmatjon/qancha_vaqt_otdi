import 'package:flutter/material.dart';

import '../models/event.dart';

Future<Event?> showAddEventDialog(
  BuildContext context, {
  Event? event,
}) async {
  final titleController = TextEditingController(
    text: event?.title ?? '',
  );

  final descriptionController = TextEditingController(
    text: event?.description ?? '',
  );

  DateTime selectedDate = event?.dateTime ?? DateTime.now();

  TimeOfDay selectedTime = event != null
      ? TimeOfDay(
          hour: event.dateTime.hour,
          minute: event.dateTime.minute,
        )
      : TimeOfDay.now();

  final result = await showDialog<Event>(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setDialogState) {
          final isEditing = event != null;

          return AlertDialog(
            title: Text(
              isEditing ? 'Voqeani tahrirlash' : 'Yangi voqea',
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Voqea nomi',
                      hintText: 'Masalan: O‘g‘lim tug‘ilgan kun',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.calendar_today),
                    title: const Text('Sana'),
                    subtitle: Text(
                      '${selectedDate.day.toString().padLeft(2, '0')}.'
                      '${selectedDate.month.toString().padLeft(2, '0')}.'
                      '${selectedDate.year}',
                    ),
                    onTap: () async {
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
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.access_time),
                    title: const Text('Vaqt'),
                    subtitle: Text(
                      selectedTime.format(context),
                    ),
                    onTap: () async {
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
                  ),
                  TextField(
                    controller: descriptionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Qisqa izoh',
                      hintText:
                          'Masalan: Oilamizga yangi quvonch keldi',
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
                child: const Text('Bekor qilish'),
              ),
              FilledButton(
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
                      description:
                          descriptionController.text.trim(),
                    ),
                  );
                },
                child: Text(
                  isEditing ? 'Saqlash' : 'Saqlash',
                ),
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