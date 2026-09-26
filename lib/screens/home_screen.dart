import 'dart:async';

import 'package:flutter/material.dart';

import 'add_event_dialog.dart';
import '../models/event.dart';
import '../models/event_category.dart';
import 'event_detail_screen.dart';
import '../services/event_storage_service.dart';
import '../services/elapsed_time_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Event> _events = [];
  final EventStorageService _storageService = EventStorageService();

  bool _isLoading = true;

  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _loadEvents();

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> _loadEvents() async {
    final loadedEvents = await _storageService.loadEvents();

    if (!mounted) return;

    setState(() {
      _events.clear();
      _events.addAll(loadedEvents);
      _isLoading = false;
    });
  }

  Future<void> _saveEvents() async {
    await _storageService.saveEvents(_events);
  }

  Future<void> _addEvent() async {
    final result = await showAddEventDialog(context);

    if (result != null) {
      setState(() {
        _events.add(result);
      });

      await _saveEvents();
    }
  }

  Future<void> _editEvent(int index) async {
    final event = _events[index];

    final result = await showAddEventDialog(context, event: event);

    if (result != null) {
      setState(() {
        _events[index] = result;
      });

      await _saveEvents();
    }
  }

  Future<void> _deleteEvent(int index) async {
    final event = _events[index];

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Voqeani o‘chirish'),
          content: Text('“${event.title}” voqeasini o‘chirishni xohlaysizmi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Bekor qilish'),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('O‘chirish'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _events.removeAt(index);
    });

    await _saveEvents();
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day.toString().padLeft(2, '0')}.'
        '${dateTime.month.toString().padLeft(2, '0')}.'
        '${dateTime.year} '
        '${dateTime.hour.toString().padLeft(2, '0')}:'
        '${dateTime.minute.toString().padLeft(2, '0')}';
  }

  String _formatElapsedTime(Event event) {
    final elapsed = ElapsedTimeService.calculate(
      event.dateTime,
      DateTime.now(),
    );

    return '${elapsed.years} yil '
        '${elapsed.months} oy '
        '${elapsed.days} kun\n'
        '${elapsed.hours.toString().padLeft(2, '0')}:'
        '${elapsed.minutes.toString().padLeft(2, '0')}:'
        '${elapsed.seconds.toString().padLeft(2, '0')}';
  }

  IconData _getEventIcon(Event event) {
    switch (event.category) {
      case EventCategory.birthday:
        return Icons.cake;
      case EventCategory.general:
        return Icons.event;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Qancha vaqt o‘tdi?')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _events.isEmpty
          ? const Center(
              child: Text(
                'Hali hech qanday voqea qo‘shilmagan',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: _events.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final event = _events[index];

                return Card(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(12),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailScreen(event: event),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(child: Icon(_getEventIcon(event))),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  event.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),

                              PopupMenuButton<String>(
                                padding: EdgeInsets.zero,
                                onSelected: (value) {
                                  if (value == 'edit') {
                                    _editEvent(index);
                                  } else if (value == 'delete') {
                                    _deleteEvent(index);
                                  }
                                },
                                itemBuilder: (context) => const [
                                  PopupMenuItem<String>(
                                    value: 'edit',
                                    child: Row(
                                      children: [
                                        Icon(Icons.edit),
                                        SizedBox(width: 8),
                                        Text('Tahrirlash'),
                                      ],
                                    ),
                                  ),
                                  PopupMenuItem<String>(
                                    value: 'delete',
                                    child: Row(
                                      children: [
                                        Icon(Icons.delete_outline),
                                        SizedBox(width: 8),
                                        Text('O‘chirish'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          Text(
                            _formatElapsedTime(event),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          Text(
                            _formatDateTime(event.dateTime),
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addEvent,
        child: const Icon(Icons.add),
      ),
    );
  }
}
