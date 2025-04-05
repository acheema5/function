import 'package:flutter/material.dart';

class InterestSelectionScreen extends StatefulWidget {
  final Function(List<String>) onInterestsSelected;

  const InterestSelectionScreen({super.key, required this.onInterestsSelected});

  @override
  _InterestSelectionScreenState createState() => _InterestSelectionScreenState();
}

class _InterestSelectionScreenState extends State<InterestSelectionScreen> {
  final List<String> interests = [
    'Soccer',
    'Football',
    'Basketball',
    'Reading',
    'Physics',
    'Business',
    'Music',
    'Art',
    'Technology',
    'Cooking',
    'Dance',
    'Drama',
    'Literature',
    'Science',
    'Math',
    'Engineering',
    'Photography',
    'Travel',
    'Gaming',
    'Volunteering'
  ];

  final Set<String> selectedInterests = {};

  void _toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else {
        if (selectedInterests.length < 10) {
          selectedInterests.add(interest);
        }
      }
    });

    if (selectedInterests.length == 10) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.onInterestsSelected(selectedInterests.toList());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Your Interests')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Hello ______', style: TextStyle(fontSize: 24)),
            const SizedBox(height: 20),
            const Text('What are your interests?', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 3,
                children: interests.map((interest) {
                  final isSelected = selectedInterests.contains(interest);
                  return GestureDetector(
                    onTap: () => _toggleInterest(interest),
                    child: Container(
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.blue.shade100 : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          interest,
                          style: TextStyle(
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            color: isSelected ? Colors.blue : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
