import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aplikasi01/resources/dimentions.dart';
import 'package:nanoid2/nanoid2.dart';

import '../models/moment.dart';
import '../resources/colors.dart';

class MomentEntryPage extends StatefulWidget {
  const MomentEntryPage({
    super.key,
    required this.onSaved,
    this.selectedMoment,
  });

  final Function(Moment newMoment) onSaved;
  final Moment? selectedMoment;

  @override
  State<MomentEntryPage> createState() => _MomentEntryPageState();
}

class _MomentEntryPageState extends State<MomentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};
  // Text Editing Controller untuk set nilai awal pada text field
  final _momentDateController = TextEditingController();
  final _creatorController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _captionController = TextEditingController();
  // Date Format
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    if (widget.selectedMoment != null) {
      final selectedMoment = widget.selectedMoment!;
      _momentDateController.text =
          _dateFormat.format(selectedMoment.momentDate);
      _creatorController.text = selectedMoment.creator;
      _locationController.text = selectedMoment.location;
      _imageUrlController.text = selectedMoment.imageUrl;
      _captionController.text = selectedMoment.caption;
      _selectedDate = selectedMoment.momentDate;
    } else {
      _selectedDate = DateTime.now();
    }
  }

  // Membuat method untuk menyimpan data moment
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataMoment
      _formKey.currentState!.save();
      // Membuat object moment baru
      final moment = Moment(
        id: widget.selectedMoment?.id ??
            nanoid(), //gunakan id yang ada jika update atau baru jika tidak ada
        momentDate: _dataMoment['momentDate'],
        creator: _dataMoment['creator'],
        location: _dataMoment['location'],
        imageUrl: _dataMoment['imageUrl'],
        caption: _dataMoment['caption'],
        likeCount: widget.selectedMoment?.likeCount ?? 0,
        commentCount: widget.selectedMoment?.commentCount ?? 0,
        bookmarkCount: widget.selectedMoment?.bookmarkCount ?? 0,
      );
      // Menyimpan object moment ke list _moments
      widget.onSaved(moment);
      // Menutup halaman create moment
      Navigator.of(context).pop();
    }
  }

  void _pickDate() async {
    final todayDate = DateTime.now();
    final firstDate = todayDate.subtract(const Duration(days: 365));
    final lastDate = todayDate.add(const Duration(days: 0));
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDate: _selectedDate.isAfter(lastDate) ? null : _selectedDate,
    );
    if (selectedDate != null) {
      _momentDateController.text = _dateFormat.format(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${widget.selectedMoment == null ? 'Create' : 'Update'} Moment'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Moment Date'),
                TextFormField(
                  controller: _momentDateController,
                  onTap: _pickDate,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Select Date',
                    prefixIcon: const Icon(Icons.calendar_month),
                  ),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment date in format yyyy-MM-dd';
                    } else if (DateTime.tryParse(value) == null) {
                      return 'Please enter valid moment date in format yyyy-MM-dd';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['momentDate'] =
                          DateTime.tryParse(newValue) ?? DateTime.now();
                    }
                  },
                ),
                const Text('Creator'),
                TextFormField(
                  controller: _creatorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Moment creator',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment creator';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['creator'] = newValue;
                    }
                  },
                ),
                const Text('Location'),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Moment location',
                    prefixIcon: const Icon(Icons.location_pin),
                  ),
                  keyboardType: TextInputType.streetAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment location';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['location'] = newValue;
                    }
                  },
                ),
                const Text('Image URL'),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Moment image URL',
                    prefixIcon: const Icon(Icons.image),
                  ),
                  keyboardType: TextInputType.url,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment image URL';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['imageUrl'] = newValue;
                    }
                  },
                ),
                const Text('Caption'),
                TextFormField(
                  controller: _captionController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Moment description',
                    prefixIcon: const Icon(Icons.note),
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter moment caption';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataMoment['caption'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _saveMoment,
                  child: const Text('Save'),
                ),
                const SizedBox(height: mediumSize),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
