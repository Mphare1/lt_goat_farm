import 'package:flutter/material.dart';
import 'goat_data.dart';
import 'goat.dart';
import 'goat_card.dart';
import 'goat_detail_screen.dart';

class GoatListScreen extends StatefulWidget {
  @override
  _GoatListScreenState createState() => _GoatListScreenState();
}

class _GoatListScreenState extends State<GoatListScreen> {
  late List<Goat> goats;

  @override
  void initState() {
    super.initState();
    final goatData = GoatData();
    goatData.loadGoatsFromJson().then((loadedGoats) {
      setState(() {
        goats = loadedGoats;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Goat List'),
      ),
      body: goats == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: goats.length,
                itemBuilder: (BuildContext context, int index) {
                  final goat = goats[index];
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => GoatDetailScreen(goat: goat),
                      ));
                    },
                    child: GoatCard(goat: goat),
                  );
                },
              ),
            ),
    );
  }
}
