import 'package:aplikasi01/models/comment.dart';
import 'package:flutter/material.dart';
import 'package:aplikasi01/resources/dimentions.dart';
import 'package:intl/intl.dart';
import 'package:nanoid2/nanoid2.dart';

import '../resources/colors.dart';

class CommentEntryPage extends StatefulWidget {
  const CommentEntryPage({
    super.key,
    required this.onSaved,
    this.selectedComment,
  });

  final Function(Comment newComment) onSaved;
  final Comment? selectedComment;

  @override
  State<CommentEntryPage> createState() => _CommentEntryPageState();
}

class _CommentEntryPageState extends State<CommentEntryPage> {
  // Membuat object form global key
  final _formKey = GlobalKey<FormState>();
  final _dataComment = {};
  // Text Editing Controller untuk set nilai awal pada text field
  final _createdAtController = TextEditingController();
  final _creatorController = TextEditingController();
  final _contentController = TextEditingController();

  //Date Format
  final _dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    if (widget.selectedComment != null) {
      final selectedMoment = widget.selectedComment!;
      _createdAtController.text = _dateFormat.format(selectedMoment.createdAt);
      _creatorController.text = selectedMoment.creator;
      _contentController.text = selectedMoment.content;
    } else {}
  }

  // Membuat method untuk menyimpan data moment
  void _saveComment() {
    if (_formKey.currentState!.validate()) {
      // Menyimpan data inputan pengguna ke map _dataMoment
      _formKey.currentState!.save();
      // Membuat object moment baru
      final comment = Comment(
        id: widget.selectedComment?.id ?? nanoid(),
        momentId: _dataComment['momentId'] ?? 'default_moment_id',
        creator: _dataComment['creator'],
        content: _dataComment['content'],
        createdAt: DateTime.now(),
      );

      // Menyimpan object moment ke list _moments
      widget.onSaved(comment);
      // Menutup halaman create moment
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.selectedComment == null ? 'Create' : 'Edit'} Comment',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(largeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                      _dataComment['creator'] = newValue;
                    }
                  },
                ),
                const Text('Comment'),
                TextFormField(
                  controller: _contentController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0),
                    ),
                    hintText: 'Comment description',
                    prefixIcon: const Icon(Icons.note),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: 5, // Menambah jumlah baris
                  minLines: 5, // Menentukan tinggi minimal kolom
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter comment description';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['content'] = newValue;
                    }
                  },
                ),
                const SizedBox(height: largeSize),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _saveComment,
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
