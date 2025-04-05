import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'routes/login_screen.dart';
import 'routes/spaced_items_list.dart';
import 'routes/rsvped_events_screen.dart';
import 'routes/interest_selection_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Map<String, String>> rsvpedEvents = [];
  bool _isLoggedIn = false;
  String _userName = '';
  String _userSchool = '';
  List<String> _selectedInterests = [];

  void _addRsvp(Map<String, String> event) {
    setState(() {
      if (!rsvpedEvents.any((e) => e['eventName'] == event['eventName'])) {
        rsvpedEvents.add(event);
      }
    });
  }

  void _removeRsvp(Map<String, String> event) {
    setState(() {
      rsvpedEvents.removeWhere((e) => e['eventName'] == event['eventName']);
    });
  }


  void _login(String name, String school) {
    setState(() {
      _isLoggedIn = true;
      _userName = name;
      _userSchool = school;
    });
  }

  void _onInterestsSelected(List<String> interests) {
    setState(() {
      _selectedInterests = interests;
    });
    print("Selected interests: $_selectedInterests");

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.of(context, rootNavigator: true).pushReplacement(
        MaterialPageRoute(builder: (context) => _buildHomePage()),
      );
    });
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildHomePage() {
    List<Widget> screens = [
      SpacedItemsList(onRsvp: _addRsvp, onUnRsvp: _removeRsvp, rsvpedEvents: rsvpedEvents),
      RsvpedEventsScreen(rsvpedEvents: rsvpedEvents, onRsvp: _addRsvp, onUnRsvp: _removeRsvp),
    ];

    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: 'RSVPed Events',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        cardTheme: CardTheme(color: Colors.blue.shade50),
        useMaterial3: true,
      ), 
      home: _isLoggedIn
          ? InterestSelectionScreen(onInterestsSelected: _onInterestsSelected)
          : LoginScreen(onLogin: _login),
    );
  }
}
