import 'package:flutter/material.dart';
import 'goat.dart';

class GoatDetailScreen extends StatelessWidget {
  final Goat goat;

  const GoatDetailScreen({required this.goat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goat Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Name: ${goat.name}'),
              SizedBox(height: 8),
              Text('Gender: ${goat.gender}'),
              SizedBox(height: 8),
              Text('Age: ${goat.dob}'),
              SizedBox(height: 8),
              Text('Breed: ${goat.breed}'),
              SizedBox(height: 8),
              Text('Weight: ${goat.weight}'),
            ],
          ),
        ),
      ),
    );
  }
}
