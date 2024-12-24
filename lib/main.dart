import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/booking_list_screen.dart';
import 'screens/add_passenger_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firestore Booking App',
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => BookingListScreen(),
        '/add': (context) => AddPassengerScreen(),
      },
    );
  }
}
