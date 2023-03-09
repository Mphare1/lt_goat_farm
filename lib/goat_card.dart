import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'goat.dart';

class GoatCard extends StatelessWidget {
  final Goat goat;
  final VoidCallback? onPressed;

  const GoatCard({
    Key? key,
    required this.goat,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Hero(
                tag: goat.tag,
                child: CircleAvatar(
                  radius: 32.0,
                  backgroundImage: goat.image != null
                      ? AssetImage(goat.image!)
                      : AssetImage(Constants.defaultGoatImage),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goat.name!,
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Text(
                      'Tag: ${goat.tag}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'Gender: ${goat.gender}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'DOB: ${DateFormat.yMd().format(goat.dob)}',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
