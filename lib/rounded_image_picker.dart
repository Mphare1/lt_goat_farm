import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'constants.dart';

const Color kPrimaryColor = Color(0xFF00ADEF);

class RoundedImagePicker extends StatefulWidget {
  final Function(File?) onImagePicked;
  final String? buttonText;
  final double width;
  final File? image;

  const RoundedImagePicker({
    Key? key,
    required this.onImagePicked,
    this.buttonText,
    this.image,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  _RoundedImagePickerState createState() => _RoundedImagePickerState();
}

class _RoundedImagePickerState extends State<RoundedImagePicker> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onImagePicked(_image);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.buttonText != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                widget.buttonText!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: kPrimaryColor,
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (BuildContext context) {
                  return SafeArea(
                    child: Container(
                      child: Wrap(
                        children: [
                          ListTile(
                            leading: Icon(Icons.camera_alt),
                            title: Text('Take a photo'),
                            onTap: () {
                              _pickImage(ImageSource.camera);
                              Navigator.of(context).pop();
                            },
                          ),
                          ListTile(
                            leading: Icon(Icons.photo_library),
                            title: Text('Choose from gallery'),
                            onTap: () {
                              _pickImage(ImageSource.gallery);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[200],
              ),
              width: widget.width,
              height: widget.width * 0.75,
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: widget.width,
                      height: widget.width * 0.75,
                      fit: BoxFit.cover,
                    )
                  : Icon(
                      Icons.camera_alt,
                      size: widget.width * 0.25,
                      color: Colors.grey[400],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
