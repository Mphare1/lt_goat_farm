import 'package:flutter/material.dart';
import 'file_helper.dart';
import 'dart:convert';
import 'goat_data.dart';
import 'goat.dart';
import 'goat_list_screen.dart';

class DashboardScreen extends StatefulWidget {
  final List<Goat> goats;

  const DashboardScreen({Key? key, required this.goats}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _numberOfGoats = 0;
  double _averageWeight = 0.0;
  int _numberOfPregnantGoats = 0;

  @override
  void initState() {
    super.initState();
    _getDefaultValues();
  }

  Future<void> _getDefaultValues() async {
    // Read the values from the file
    final data = await FileHelper.readData('dashboard_data.json');

    // Parse the JSON data
    final jsonData = json.decode(data);

    // Set the default values
    setState(() {
      _numberOfGoats = jsonData['numberOfGoats'] ?? 0;
      _averageWeight = jsonData['averageWeight'] ?? 0.0;
      _numberOfPregnantGoats = jsonData['numberOfPregnantGoats'] ?? 0;
    });

    // Update the values with the actual data from the goats list
    _updateValues();
  }

  void _updateValues() {
    // Calculate the number of goats
    setState(() {
      _numberOfGoats = widget.goats.length;
    });

    // Calculate the average weight
    double totalWeight = 0.0;
    for (var goat in widget.goats) {
      totalWeight += goat.weight ?? 0;
    }
    setState(() {
      _averageWeight = totalWeight / widget.goats.length;
    });

    // Calculate the number of pregnant goats
    int numberOfPregnantGoats = 0;
    for (var goat in widget.goats) {
      if (goat.isPregnant) {
        numberOfPregnantGoats++;
      }
    }
    setState(() {
      _numberOfPregnantGoats = numberOfPregnantGoats;
    });

    // Save the updated values to the file
    _saveValuesToFile();
  }

  Future<void> _saveValuesToFile() async {
    final jsonData = {
      'numberOfGoats': _numberOfGoats,
      'averageWeight': _averageWeight,
      'numberOfPregnantGoats': _numberOfPregnantGoats,
    };

    final data = json.encode(jsonData);
    await FileHelper.writeData('dashboard_data.json', data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoatListScreen(),
                  ),
                );
              },
              child: Text(
                'Number of Goats: $_numberOfGoats',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
