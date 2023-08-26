import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RandomActivityScreen extends StatefulWidget {
  @override
  _RandomActivityScreenState createState() => _RandomActivityScreenState();
}

class _RandomActivityScreenState extends State<RandomActivityScreen> {
  String activity = '';

  Future<void> fetchActivity() async {
    final response =
        await http.get(Uri.parse('https://www.boredapi.com/api/activity'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        activity = data['activity'];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchActivity();
  }

  void getNextActivity() {
    fetchActivity();
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Activity'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              activity,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: getNextActivity,
              child: Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: RandomActivityScreen(),
  ));
}
