import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Provider/notes/Notes_bloc.dart';
import '../database/table/notes_table.dart';
import '../utils/Colors.dart';
import '../utils/widgets/search_button.dart';
import 'Add_Notes.dart';
import 'Edit_Screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> notes = [];
  List<String> searchNotes = [];
  @override
  void initState() {
    super.initState();
    // BlocProvider.of<NotesBloc>(context).add(
    //     NotegetEvent(
    //     ));
    _loadNotes();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Refresh notes whenever dependencies change
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    BlocProvider.of<NotesBloc>(context).add(
        NotegetEvent(
        ));
  }

  Future<void> _deleteNoteFromDatabase(int noteId) async {
    BlocProvider.of<NotesBloc>(context).add(
        NoteDeleteEvent(id: noteId
        ));
    _loadNotes();
  }

  void updateSearchResults(List<String> results) {
    setState(() {
      searchNotes = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: CustomSearch(
          data: searchNotes,
          onSearchResultsChanged: updateSearchResults, title: 'Notes App',
        ),
      ),

      body: BlocBuilder<NotesBloc, NotesState>(
        builder: (context, state) {
          if (state is NotesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if(state is NotesSuccess){
            notes = state.notes;
            return _buildScreen(context);
          }
          return _buildScreen(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add note screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddNoteScreen(index: "${notes.length + 1}",),
            ),
          ).then((newNote) {
            if (newNote != null) {
              setState(() {
                notes.add(newNote);
              });
            }
          });
        },
        backgroundColor: CustomColors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  _buildScreen(BuildContext context){
    return RefreshIndicator(
      onRefresh: () async {
        _loadNotes();
        await Future.delayed(const Duration(seconds: 2));
      },
      child: notes.isEmpty
          ?const Center()
          : ListView.builder(
        itemCount: notes.length ,
        itemBuilder: (context, index) {
          final title = notes[index][NotesTable.title] ?? 'No title';
          final content = notes[index][NotesTable.content] ?? 'No content';
          final id = notes[index][NotesTable.id] as int? ?? -1;

          return Container(
            decoration: BoxDecoration(
                border: Border.all(color: CustomColors.grey),
                borderRadius: BorderRadius.circular(10.0)),
            margin: const EdgeInsets.all(08.0),
            child: ListTile(
              title: Text(
                title,
                style: const TextStyle(color: CustomColors.black87,fontWeight: FontWeight.w500),
              ),
              subtitle: Text(
                content,
                maxLines: 1, // Display only one line of content
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: CustomColors.black87,fontSize: 14),
              ),
              onTap: () {
                // Navigate to edit note screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditNoteScreen(noteId: id),
                  ),
                );
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red.shade300),
                onPressed: () {
                  _deleteNoteFromDatabase(id);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}