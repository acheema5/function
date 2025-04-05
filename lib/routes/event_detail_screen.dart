import 'package:flutter/material.dart';

class EventDetailScreen extends StatelessWidget {
  final String eventName;
  final String orgName;
  final String date;
  final String time;
  final String location;
  final String price;
  final String whosInvited;
  final String eventType;
  final Function(Map<String, String>) onRsvp;
  final Function(Map<String, String>) onUnRsvp;
  final bool isRsvped;

  const EventDetailScreen({
    super.key,
    required this.eventName,
    required this.orgName,
    required this.date,
    required this.time,
    required this.location,
    required this.price,
    required this.whosInvited,
    required this.eventType,
    required this.onRsvp,
    required this.onUnRsvp,
    required this.isRsvped,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(eventName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(eventName, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text(orgName, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Date: $date'),
                Text('Time: $time'),
                Text('Location: $location'),
              ],
            ),
            const Divider(height: 32),
            const Text('Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Price: $price'),
            Text('Who\'s Invited: $whosInvited'),
            Text('Event Type: $eventType'),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final event = {
                    'eventName': eventName,
                    'orgName': orgName,
                    'date': date,
                    'time': time,
                    'location': location,
                    'price': price,
                    'whosInvited': whosInvited,
                    'eventType': eventType,
                  };
                  if (isRsvped) {
                    onUnRsvp(event);
                  } else {
                    onRsvp(event);
                  }
                  Navigator.pop(context);
                },
                child: Text(isRsvped ? 'Un-RSVP' : 'RSVP'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
