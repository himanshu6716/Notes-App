import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_app/utils/Colors.dart';
import 'package:notes_app/utils/widgets/Buttom.dart';
import 'package:notes_app/utils/widgets/Custom_TextField.dart';
import '../Provider/notes/Notes_bloc.dart';

class AddNoteScreen extends StatefulWidget {
  String index;
  AddNoteScreen({Key? key,required this.index}) : super(key: key);

  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>(); // Add a GlobalKey for the Form

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: CustomColors.black87),
        backgroundColor: CustomColors.white,
        title: const Text(
          "Add Notes",
          style: TextStyle(color: CustomColors.black87),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the GlobalKey to the Form
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Note No. ${widget.index}', // Convert widget.index to string
                  style: const TextStyle(color: CustomColors.black87, fontSize: 18),
                ),
                const SizedBox(height: 12.0),
                CustomTextField(
                  label: 'Title',
                  onChanged: (val) => {},
                  controller: _titleController,
                  keyboardType: TextInputType.text, validatorLable: 'title',

                ),
                const SizedBox(height: 12.0),
                CustomTextField(
                  label: 'Content',
                  onChanged: (val) => {},
                  controller: _contentController,
                  keyboardType: TextInputType.text, validatorLable: 'Content',maxline: 5,

                ),
                const SizedBox(height: 12.0),
                CustomButton(onPressed: saveDataToTable, label: "Save",)
              ],
            ),
          ),
        ),
      ),
    );
  }

  void saveDataToTable() {
    if (_formKey.currentState!.validate()) {
      String id = widget.index;
      String title = _titleController.text;
      String content = _contentController.text;

      BlocProvider.of<NotesBloc>(context).add(
        NoteSuccessEvent(id: id, title: title, content: content),
      );
      BlocProvider.of<NotesBloc>(context).add(
        NotegetEvent(),
      );
      Navigator.pop(context);
    }
  }
}


