import 'package:flutter/material.dart';
import 'dart:math';
import 'event_detail_screen.dart';

class SpacedItemsList extends StatefulWidget {
  final Function(Map<String, String>) onRsvp;
  final Function(Map<String, String>) onUnRsvp;
  final List<Map<String, String>> rsvpedEvents;

  const SpacedItemsList({
    super.key,
    required this.onRsvp,
    required this.onUnRsvp,
    required this.rsvpedEvents,
  });

  @override
  _SpacedItemsListState createState() => _SpacedItemsListState();
}

class _SpacedItemsListState extends State<SpacedItemsList> {
  @override
  Widget build(BuildContext context) {
    const items = 20;
    final random = Random();
    final eventNames = List.generate(items, (index) => 'Event ${index + 1}');
    final orgNames = List.generate(items, (index) => 'Club ${index + 1}');
    final dates = List.generate(items, (index) => '${random.nextInt(28) + 1}/07/2024');
    final times = List.generate(items, (index) => '${random.nextInt(12) + 1}:${random.nextInt(60).toString().padLeft(2, '0')} ${random.nextBool() ? 'AM' : 'PM'}');
    final locations = List.generate(items, (index) => 'Location ${index + 1}');
    final prices = List.generate(items, (index) => '\$${random.nextInt(100) + 1}');
    final whosInvitedList = List.generate(items, (index) => 'Everyone');
    final eventTypes = List.generate(items, (index) => 'Type ${index + 1}');

    return Scaffold(
      appBar: AppBar(title: const Text('Upcoming Events!')),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                items,
                (index) {
                  final event = {
                    'eventName': eventNames[index],
                    'orgName': orgNames[index],
                    'date': dates[index],
                    'time': times[index],
                    'location': locations[index],
                    'price': prices[index],
                    'whosInvited': whosInvitedList[index],
                    'eventType': eventTypes[index],
                  };
                  final isRsvped = widget.rsvpedEvents.any((e) => e['eventName'] == event['eventName']);
                  return ItemWidget(
                    event: event,
                    onRsvp: widget.onRsvp,
                    onUnRsvp: widget.onUnRsvp,
                    isRsvped: isRsvped,
                  );
                },
              ),
            ),
          ),
        );
      }),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final Map<String, String> event;
  final Function(Map<String, String>) onRsvp;
  final Function(Map<String, String>) onUnRsvp;
  final bool isRsvped;

  const ItemWidget({
    super.key,
    required this.event,
    required this.onRsvp,
    required this.onUnRsvp,
    required this.isRsvped,
  });

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventDetailScreen(
          eventName: event['eventName']!,
          orgName: event['orgName']!,
          date: event['date']!,
          time: event['time']!,
          location: event['location']!,
          price: event['price']!,
          whosInvited: event['whosInvited']!,
          eventType: event['eventType']!,
          onRsvp: onRsvp,
          onUnRsvp: onUnRsvp,
          isRsvped: isRsvped,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Card(
        color: isRsvped ? Colors.purple.shade100 : null,
        child: SizedBox(
          height: 100,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Event: ${event['eventName']}', style: const TextStyle(fontWeight: FontWeight.bold)),
                Text('Club: ${event['orgName']}'),
                Text('Date: ${event['date']}'),
                Text('Time: ${event['time']}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
