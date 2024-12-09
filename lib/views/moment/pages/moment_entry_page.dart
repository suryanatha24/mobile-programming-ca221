import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:myapp/models/moments.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:myapp/views/moment/bloc/moment_bloc.dart';
import 'package:nanoid2/nanoid2.dart';

class MomentEntryPage extends StatefulWidget {
  static const routeName = '/moment/entry';
  const MomentEntryPage({super.key, this.momentId});

  final String? momentId;

  @override
  State<MomentEntryPage> createState() => _MomentEntryPageState();
}

class _MomentEntryPageState extends State<MomentEntryPage> {
  // Buat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataMoment = {};

  // Text Editing Controller
  final _momentDateController = TextEditingController();
  final _creatorController = TextEditingController();
  final _locationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _captionController = TextEditingController();
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
    _creatorController.text = moment.creator;
    _locationController.text = moment.location;
    _imageUrlController.text = moment.imageUrl;
    _captionController.text = moment.caption;
    _selectedDate = moment.momentDate;
  }

  // Form data save method
  void _saveMoment() {
    if (_formKey.currentState!.validate()) {
      // Saving the form data to _dataMoment
      _formKey.currentState!.save();
      // Create new object from form data
      final moment = Moment(
          id: widget.momentId ?? nanoid(),
          momentDate: _dataMoment['momentDate'],
          creator: _dataMoment['creator'],
          location: _dataMoment['location'],
          imageUrl: _dataMoment['imageUrl'],
          caption: _dataMoment['caption'],
          likeCount: _updatedMoment?.likeCount ?? 0,
          commentCount: _updatedMoment?.commentCount ?? 0,
          bookmarkCount: _updatedMoment?.bookmarkCount ?? 0);
      if (widget.momentId != null) {
        context.read<MomentBloc>().add(MomentUpdateEvent(moment));
      } else {
        context.read<MomentBloc>().add(MomentAddEvent(moment));
      }
      // Navigasi ke halaman home
      Navigator.of(context).pop();
    }
  }

  void _pickDate() async {
    final todayDate = DateTime.now();
    final firstDate = todayDate.subtract(const Duration(days: 365));
    final selectedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: todayDate,
      initialDate: _selectedDate.isAfter(todayDate) ? null : _selectedDate,
    );
    if (selectedDate != null) {
      setState(() {
        _momentDateController.text = _dateFormat.format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back
            ),
            onPressed: () {
              context.read<MomentBloc>().add(MomentNavigateBackEvent());
            },
          ),
          title:
            Text('${widget.momentId == null ? 'Create' : 'Update'} Moment'),
          centerTitle: true),
        body: BlocListener<MomentBloc, MomentState>(
          listener: (context, state) {
            // TODO: implement listener
            if (state is MomentGetByIdSuccessState) {
              _initExistingData(state.moment);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(extraLargeSize),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Moment Date'),
                      ),
                      TextFormField(
                        controller: _momentDateController,
                        onTap: _pickDate,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(extraLargeSize)),
                            hintText: 'Select Date',
                            prefixIcon: const Icon(Icons.calendar_month)),
                        keyboardType: TextInputType.datetime,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter date time';
                          } else if (DateTime.tryParse(value) == null) {
                            return 'Please enter a valid date time in format yyyy-MM-dd';
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
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Creator'),
                      ),
                      TextFormField(
                        controller: _creatorController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(extraLargeSize)),
                            hintText: 'Moment Creator',
                            prefixIcon: const Icon(Icons.person)),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Moment Creator';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _dataMoment['creator'] = newValue;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Location'),
                      ),
                      TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(extraLargeSize)),
                            hintText: 'Moment Location',
                            prefixIcon: const Icon(Icons.location_on)),
                        keyboardType: TextInputType.streetAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Moment Location';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _dataMoment['location'] = newValue;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Image URL'),
                      ),
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(extraLargeSize)),
                            hintText: 'Moment Image URL',
                            prefixIcon: const Icon(Icons.image)),
                        keyboardType: TextInputType.url,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Moment Image URL';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _dataMoment['imageUrl'] = newValue;
                          }
                        },
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Caption'),
                      ),
                      TextFormField(
                        controller: _captionController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(extraLargeSize)),
                            hintText: 'Moment Description',
                            prefixIcon: const Icon(Icons.notes)),
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Moment Caption';
                          }
                          return null;
                        },
                        onSaved: (newValue) {
                          if (newValue != null) {
                            _dataMoment['caption'] = newValue;
                          }
                        },
                      ),
                      const SizedBox(
                        height: largeSize,
                      ),
                      ElevatedButton(
                        onPressed: _saveMoment,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor,
                            foregroundColor: Colors.white),
                        child:
                            Text(widget.momentId == null ? 'Save' : 'Update'),
                      ),
                      const SizedBox(
                        height: mediumSize,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          // Navigasi ke halaman home
                          context.read<MomentBloc>().add(MomentNavigateBackEvent());
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
