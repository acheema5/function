import 'package:flutter/material.dart';
import 'event_detail_screen.dart';

class RsvpedEventsScreen extends StatelessWidget {
  final List<Map<String, String>> rsvpedEvents;
  final Function(Map<String, String>) onRsvp;
  final Function(Map<String, String>) onUnRsvp;

  const RsvpedEventsScreen({
    super.key,
    required this.rsvpedEvents,
    required this.onRsvp,
    required this.onUnRsvp,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RSVPed Events')),
      body: ListView.builder(
        itemCount: rsvpedEvents.length,
        itemBuilder: (context, index) {
          final event = rsvpedEvents[index];
          return Card(
            color: Colors.purple.shade50,
            child: ListTile(
              title: Text(event['eventName']!),
              subtitle: Text('${event['orgName']} \nDate: ${event['date']} Time: ${event['time']} Location: ${event['location']}'),
              isThreeLine: true,
              onTap: () {
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
                      isRsvped: true,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
