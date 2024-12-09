import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/core/resources/colors.dart';
import 'package:myapp/core/resources/dimentions.dart';
import 'package:nanoid2/nanoid2.dart';
import 'package:myapp/models/comment.dart';

class CreateComment extends StatefulWidget {
  const CreateComment({
    super.key,
    required this.onSaved,
    this.selectedComment
    });

  final Function(Comment newComment) onSaved;
  final Comment? selectedComment;

  @override
  State<CreateComment> createState() => _CreateCommentState();
}

class _CreateCommentState extends State<CreateComment> {

  final _formKey = GlobalKey<FormState>();
  final _dataComment = {};

  // Text Editing Controller
  final _creatorController = TextEditingController();
  final _commentController = TextEditingController();
  final _dateFormat = DateFormat('dd MMM yyyy');
  late DateTime _selectedDate;

  @override


  void initState() {
    super.initState();
    if (widget.selectedComment != null) {
      final selectedComment = widget.selectedComment!;
      _creatorController.text = selectedComment.creator;
      _commentController.text = selectedComment.comment;
      _selectedDate = selectedComment.createdAt;
    } else {
      _selectedDate = DateTime.now();
    }
  }

 void _saveComment() {
    if (_formKey.currentState!.validate()) {
      // Saving the form data to _dataMoment
      _formKey.currentState!.save();
      // Create new object from form data
      final comment = Comment(
        id: widget.selectedComment?.id ?? nanoid(),
        momentId: widget.selectedComment?.momentId ?? '',
        createdAt: DateTime.now(),
        creator: _dataComment['creator'],
        comment: _dataComment['comment'],
      );
      widget.onSaved(comment);
      // Navigasi ke halaman home
      Navigator.of(context).pop();
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.selectedComment != null ? 'Update' : 'Create'} Comment'
          ),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(extraLargeSize),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Comment Creator'),
                ), 
                TextFormField(
                  controller: _creatorController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Insert Your Name',
                    prefixIcon: const Icon(Icons.person)
                  ),
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['creator'] = newValue;
                    }
                  }
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Comment Text'),
                ),
                TextFormField(
                  controller: _commentController,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(extraLargeSize)
                    ),
                    hintText: 'Insert Comment Text',
                    prefixIcon: const Icon(Icons.notes)
                  ),
                  keyboardType: TextInputType.multiline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your comment';
                    }
                    return null;
                  },
                  onSaved: (newValue) {
                    if (newValue != null) {
                      _dataComment['comment'] = newValue;
                    }
                  },
                  minLines: 3,
                  maxLines: null,
                ),
                const SizedBox(height: largeSize,),
                ElevatedButton(
                  onPressed: _saveComment,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white
                  ),
                  child: const Text('Send'),
                ),
                const SizedBox(height: mediumSize,),
                OutlinedButton(
                  onPressed: () {
                    // Navigasi ke halaman home
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
              ],
            ),
          )),
      )
    );
  }
}