import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';

import '../../../models/moment.dart';
import '../../../core/resources/colors.dart';

class MomentEntryPage extends StatefulWidget {
  static const String routeName = '/moment/entry';
  const MomentEntryPage({
    super.key,
    this.momentId,
  });

  final String? momentId;

  @override
  State<MomentEntryPage> createState() => _MomentEntryPageState();
}

class _MomentEntryPageState extends State<MomentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};
  // Text Editing Controller untuk set nilai awal pada text field
  final _momentDateController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _captionController = TextEditingController();
  // Date Format
  final _dateFormat = DateFormat('yyyy-MM-dd');
  late DateTime _selectedDate;
  Moment? _updatedMoment;

  @override
  void initState() {
    super.initState();
    if (widget.momentId != null) {
      context.read<MomentBloc>().add(MomentGetByIdEvent(widget.momentId!));
    } else {
      _selectedDate = DateTime.now();
    }
  }

  void _initExistingData(Moment moment) {
    _updatedMoment = moment;
    _momentDateController.text = _dateFormat.format(moment.momentDate);
    _locationController.text = moment.location;
    _imageUrlController.text = moment.imageUrl;
    _captionController.text = moment.caption;
    _selectedDate = moment.momentDate;
  }

  // Membuat method untuk menyimpan data moment
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataMoment
      _formKey.currentState!.save();
      // Membuat object moment baru
      // Menyimpan object moment ke list _moments
      if (widget.momentId != null && _updatedMoment != null) {
        context.read<MomentBloc>().add(
              MomentUpdateEvent(
                _updatedMoment!.copyWith(
                  momentDate: _dataMoment['momentDate'],
                  location: _dataMoment['location'],
                  imageUrl: _dataMoment['imageUrl'],
                  caption: _dataMoment['caption'],
                ),
              ),
            );
      } else {
        final moment = Moment(
          momentDate: _dataMoment['momentDate'],
          location: _dataMoment['location'],
          imageUrl: _dataMoment['imageUrl'],
          caption: _dataMoment['caption'],
        );
        context.read<MomentBloc>().add(MomentAddEvent(moment));
      }
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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.read<MomentBloc>().add(MomentNavigateBackEvent());
          },
        ),
        title: Text('${widget.momentId == null ? 'Create' : 'Update'} Moment'),
      ),
      body: BlocListener<MomentBloc, MomentState>(
        listener: (context, state) {
          if (state is MomentGetByIdSuccessState) {
            _initExistingData(state.moment);
          }
        },
        child: Padding(
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
                  SizedBox(
                    height: 50.0,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: _saveMoment,
                      child: const Text('Save'),
                    ),
                  ),
                  const SizedBox(height: mediumSize),
                  SizedBox(
                    height: 50.0,
                    child: OutlinedButton(
                      onPressed: () {
                        context
                            .read<MomentBloc>()
                            .add(MomentNavigateBackEvent());
                      },
                      style: OutlinedButton.styleFrom(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
