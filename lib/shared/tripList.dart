import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:trips_flutter_app/models/trips.dart';
import 'package:trips_flutter_app/screens/details/details.dart';

class TripList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('trips').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        List<Trip> trips = snapshot.data!.docs.map((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
          return Trip(
            title: data['title'],
            price: data['price'],
            nights: data['nights'],
            img: data['img'],
          );
        }).toList();

        return ListView.builder(
          itemCount: trips.length,
          itemBuilder: (context, index) {
            return _buildTile(context, trips[index]);
          },
        );
      },
    );
  }

  Widget _buildTile(BuildContext context, Trip trip) {
    return ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => Details(trip: trip)));
      },
      contentPadding: const EdgeInsets.all(25),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text('${trip.nights} nights',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.blue[300])),
          Text(trip.title!, style: TextStyle(fontSize: 20, color: Colors.grey[600])),
        ],
      ),
      leading: trip.img != null ? ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Image.asset(
          'images/${trip.img}',
          height: 50.0,
        ),
      ): const SizedBox(),
      trailing: Text('\$${trip.price}'),
    );
  }
}
