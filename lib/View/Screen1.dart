import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:restapi/View/Screen2.dart';
import 'package:restapi/model/BookStore.dart';
import 'package:restapi/model/News.dart';
import 'package:restapi/model/api_response.dart';
import 'package:restapi/model/getListContry.dart';
import 'package:restapi/model/note_for_listing.dart';
import 'package:restapi/services/notes_service.dart';

import 'note_delete.dart';
import 'note_modify.dart';

class NoteListCountry extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteListCountry> {
  NotesService get service => GetIt.I<NotesService>();
//
//  APIResponse<List<GetCountry>> _apiResponseCountry;
//  APIResponse<List<GetJSNews>> _apiResponseNews;

  APIResponse<List<UserData>> _apiResponseBookStore;

  bool _isLoading = false;

  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  void initState() {
    _fetchNotes();
    super.initState();
  }

  _fetchNotes() async {
    setState(() {
      _isLoading = true;
    });
//    _apiResponseNews = (await service.getListNews()) as APIResponse<List<GetJSNews>>;
//    _apiResponseCountry = (await service.getListcontry()) as APIResponse<List<GetCountry>>;
    _apiResponseBookStore = (await service.bookStore()) as APIResponse<List<UserData>>;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('List of notes')),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => NoteModify()))
                .then((_) {
              _fetchNotes();
            });
          },
          child: Icon(Icons.add),
        ),
        body: Builder(
          builder: (_) {
            if (_isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (_apiResponseBookStore.error) {
              return Center(child: Text(_apiResponseBookStore.errorMessage));
            }

            return ListView.separated(
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.green),
              itemBuilder: (_, index) {
                return Dismissible(
                  key: ValueKey(_apiResponseBookStore.data[index].token),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {},
                  confirmDismiss: (direction) async {
                    final result = await showDialog(
                        context: context, builder: (_) => NoteDelete());
                    print(result);
                    return result;
                  },
                  background: Container(
                    color: Colors.red,
                    padding: EdgeInsets.only(left: 16),
                    child: Align(
                      child: Icon(Icons.delete, color: Colors.white),
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      _apiResponseBookStore.data[index].displayName.toString(),
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    subtitle: Text(
                        _apiResponseBookStore.data[index].token.toString()),
                       // 'Last edited on ${formatDateTime(_apiResponse.data[index].latestEditDateTime ?? _apiResponse.data[index].createDateTime)}'),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => Screen2(
                              IDCT: _apiResponseBookStore.data[index].token.toString(),
                              NameCT: _apiResponseBookStore.data[index].displayName.toString(),
                          )
                      ));
                    },
                  ),
                );
              },
              itemCount: _apiResponseBookStore.data.length,
            );
          },
        ));
  }
}
