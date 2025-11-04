import 'package:flutter/material.dart';

class PropertyAddedSuccess extends StatelessWidget {
  static const routeName = '/property_added_success';
  final Map<String, String>? propertyData;

  const PropertyAddedSuccess({super.key, this.propertyData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 64,
                backgroundColor: Colors.blue[50],
                child: Icon(Icons.check, size: 72, color: Colors.blue),
              ),
              SizedBox(height: 24),
              Text(
                'Your Property is added successfully',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, propertyData);
                  Navigator.pop(context, propertyData);
                },
                child: Text('Go back to Dashboard'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
