import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'constants.dart';
import 'goat.dart';
import 'rounded_button.dart';
import 'rounded_input_field.dart';
import 'rounded_dropdown_field.dart';
import 'rounded_date_picker_field.dart';
import 'rounded_weight_field.dart';
import 'rounded_image_picker.dart';

class AddGoatScreen extends StatefulWidget {
  final Goat? goat;

  const AddGoatScreen({Key? key, this.goat}) : super(key: key);

  @override
  _AddGoatScreenState createState() => _AddGoatScreenState();
}

class _AddGoatScreenState extends State<AddGoatScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tagController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _parentController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? _image;
  DateTime? _selectedDate;
  String? _selectedWeightUnit;
  String? _selectedGender;
  String? _selectedParent;
  String? _selectedBreed;

  @override
  void initState() {
    super.initState();
    if (widget.goat != null) {
      _tagController.text = widget.goat!.tag;
      _nameController.text = widget.goat!.name!;
      _breedController.text = widget.goat!.breed!;
      _genderController.text = widget.goat!.gender.toString();
      _parentController.text = widget.goat!.parent!;
      _selectedDate = widget.goat!.dob;
      _selectedWeightUnit = widget.goat!.weightUnit;
      _selectedGender = widget.goat!.gender.toString();
      _selectedParent = widget.goat!.parent!;
      _selectedBreed = widget.goat!.breed!;
    } else {
      _selectedWeightUnit = Constants.weightUnits[0];
      _selectedGender = Constants.genders[0];
      _selectedBreed = Constants.breeds[0];
    }
  }

  @override
  void dispose() {
    _tagController.dispose();
    _nameController.dispose();
    _breedController.dispose();
    _genderController.dispose();
    _parentController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().getImage(source: source);
    if (pickedFile != null) {
      final imageFile = File(pickedFile.path);
      setState(() {
        _image = imageFile;
      });
    }
    return Future.value();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.goat == null ? 'Add Goat' : 'Edit Goat'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RoundedInputField(
                  label: 'Tag',
                  controller: _tagController,
                  hintText: 'Tag',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Tag is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                RoundedInputField(
                  label: 'Goat Name',
                  controller: _nameController,
                  hintText: 'Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                RoundedDropdownField(
                  label: 'Breed',
                  items: Constants.breeds,
                  value: _selectedBreed,
                  hintText: 'Breed',
                  onChanged: (value) {
                    setState(() {
                      _selectedBreed = value;
                    });
                  },
                ),
                SizedBox(height: 16.0),
                RoundedButton(
                  text: widget.goat == null ? 'Add Goat' : 'Save Changes',
                  press: () {
                    if (_formKey.currentState!.validate()) {
                      final tag = _tagController.text.trim();
                      final name = _nameController.text.trim();
                      final breed = _selectedBreed!;
                      final gender = _selectedGender as Gender;
                      final dob = _selectedDate!;
                      final weightUnit =
                          double.tryParse(_weightController.text);
                      final parent = _parentController.text.trim();
                      final image = _image?.path;

                      final newGoat = Goat(
                        tag: tag,
                        name: name,
                        breed: breed,
                        gender: gender,
                        dob: dob,
                        weight: weightUnit,
                        parent: parent,
                        image: image,
                      );

                      Navigator.of(context).pop(newGoat);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
