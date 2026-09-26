import 'dart:async';

import 'package:flutter/material.dart';

import '../models/event.dart';
import '../services/elapsed_time_service.dart';

class EventDetailScreen extends StatefulWidget {
  final Event event;

  const EventDetailScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _twoDigits(int value) {
    return value.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    final elapsed = ElapsedTimeService.calculate(
      widget.event.dateTime,
      DateTime.now(),
    );

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.event.title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),

            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 24,
                ),
                child: Column(
                  children: [
                    Text(
                      '${elapsed.years} yil',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${elapsed.months} oy  '
                      '${elapsed.days} kun',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${_twoDigits(elapsed.hours)}:'
                      '${_twoDigits(elapsed.minutes)}:'
                      '${_twoDigits(elapsed.seconds)}',
                      style: theme.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Boshlangan sana',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Text(
              '${widget.event.dateTime.day.toString().padLeft(2, '0')}.'
              '${widget.event.dateTime.month.toString().padLeft(2, '0')}.'
              '${widget.event.dateTime.year} '
              '${_twoDigits(widget.event.dateTime.hour)}:'
              '${_twoDigits(widget.event.dateTime.minute)}',
              style: theme.textTheme.bodyLarge,
            ),

            if (widget.event.description.isNotEmpty) ...[
              const SizedBox(height: 24),
              Text(
                'Izoh',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.event.description,
                style: theme.textTheme.bodyLarge,
              ),
            ],
          ],
        ),
      ),
    );
  }
}