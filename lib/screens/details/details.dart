import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:trips_flutter_app/models/trips.dart';
import 'package:trips_flutter_app/shared/heart.dart';

class Details extends StatefulWidget {
  final Trip trip;

  Details({ required this.trip});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                    child: Image.asset(
                      'images/${widget.trip.img}',
                      height: 360,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    )
                ),
              ),
              const SizedBox(height: 30),
              ListTile(
                  title: Text(
                      widget.trip.title!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.grey[800]
                      )
                  ),
                  subtitle: Text(
                      '${widget.trip.nights} night stay for only \$${widget.trip.price}',
                      style: const TextStyle(letterSpacing: 1)
                  ),
                  trailing: Heart()
              ),
              Padding(
                  padding: const EdgeInsets.all(18),
                  child: Text(
                      'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                      style: TextStyle(
                          color: Colors.grey[600],
                          height: 1.4
                      )
                  )
              ),
            ],
          ),
        )
    );
  }
}