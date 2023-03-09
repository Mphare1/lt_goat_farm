import 'package:flutter/material.dart';
import 'goat_data.dart';
import 'goat.dart';
import 'feed.dart';
import 'medicine.dart';
import 'add_feed_medicine_dialog.dart';

class GoatFeedsMedicinesScreen extends StatefulWidget {
  final Goat goat;

  const GoatFeedsMedicinesScreen({Key? key, required this.goat})
      : super(key: key);

  @override
  _GoatFeedsMedicinesScreenState createState() =>
      _GoatFeedsMedicinesScreenState();
}

class _GoatFeedsMedicinesScreenState extends State<GoatFeedsMedicinesScreen> {
  List<Feed> _feeds = [];
  List<Medicine> _medicines = [];
  List<Feed> _selectedFeeds = [];
  List<Medicine> _selectedMedicines = [];

  @override
  void initState() {
    super.initState();
    _getFeedsAndMedicines();
  }

  Future<void> _getFeedsAndMedicines() async {
    final feeds = await GoatData.getFeeds();
    final medicines = await GoatData.getMedicines();
    setState(() {
      _feeds = feeds;
      _medicines = medicines;
    });
    _setSelectedFeedsAndMedicines();
  }

  void _setSelectedFeedsAndMedicines() {
    setState(() {
      _selectedFeeds = List.from(widget.goat.feeds ?? []);
      _selectedMedicines = List.from(widget.goat.medicines ?? []);
    });
  }

  void _showAddFeedMedicineDialog(BuildContext context, String type) async {
    final result = await showDialog(
      context: context,
      builder: (context) => AddFeedMedicineDialog(type: type),
    );
    if (result != null) {
      if (type == 'feed') {
        final feed = Feed(name: result);
        await GoatData.addFeed(feed);
        setState(() {
          _feeds.add(feed);
        });
      } else if (type == 'medicine') {
        final medicine = Medicine(name: result);
        await GoatData.addMedicine(medicine);
        setState(() {
          _medicines.add(medicine);
        });
      }
    }
  }

  Widget _buildListTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildListItem(dynamic item, List<dynamic> selectedList) {
    bool isSelected = selectedList.contains(item);
    return CheckboxListTile(
      title: Text(item.name),
      value: isSelected,
      onChanged: (value) {
        setState(() {
          if (isSelected) {
            selectedList.remove(item);
          } else {
            selectedList.add(item);
          }
        });
      },
    );
  }

  Widget _buildList(List<dynamic> items, List<dynamic> selectedList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildListTitle(
            '${items.length} ${items.length == 1 ? items[0].runtimeType.toString() : items[0].runtimeType.toString() + 's'}'),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildListItem(items[index], selectedList);
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goat.name ?? ''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Feeds and Medicines',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () => _showAddFeedMedicineDialog(context, 'feed'),
                child: Text('Add Feed'),
              ),
              SizedBox(height: 8.0),
              _buildList(_feeds, _selectedFeeds),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () =>
                    _showAddFeedMedicineDialog(context, 'medicine'),
                child: Text('Add Medicine'),
              ),
              SizedBox(height: 8.0),
              _buildList(_medicines, _selectedMedicines),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  widget.goat.feeds = _selectedFeeds;
                  widget.goat.medicines = _selectedMedicines;
                  GoatData().updateGoat(widget.goat, newGoatData);
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
              SizedBox(height: 16.0),
              Text(
                'Educational Section',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text(
                'Educational content about goat feeds and medicines to help users better understand the importance and proper use of each item.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
