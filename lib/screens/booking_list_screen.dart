import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// String extension to capitalize the first letter of the string
extension StringExtension on String {
  String capitalize() {
    if (isEmpty) {
      return this;
    }
    return this[0].toUpperCase() + substring(1);
  }
}

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/add');
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('bookings')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No bookings available.'));
          }

          final bookings = snapshot.data!.docs;

          return ListView.builder(
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              final id = booking.id;
              final name = booking['name'];
              final location = booking['location'];
              final status = (booking['status'] ?? '').toString();  // Ensure it's a String

              return Card(
                margin: EdgeInsets.all(8),
                child: ListTile(
                  title: Text('Passenger: $name'),
                  subtitle: Text(
                    'Location: $location\nStatus: ${status.capitalize()}',
                  ),
                  trailing: status == 'pending'
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.check, color: Colors.green),
                        onPressed: () => _updateStatus(id, 'accepted'),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _updateStatus(id, 'rejected'),
                      ),
                    ],
                  )
                      : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
  // Function to update the status of the booking
  void _updateStatus(String id, String status) async {
    await FirebaseFirestore.instance
        .collection('bookings')
        .doc(id)
        .update({'status': status});
  }
}
