import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:restapi/model/News.dart';
import 'package:restapi/model/api_response.dart';
import 'package:restapi/model/getListContry.dart';
import 'package:restapi/model/note.dart';
import 'package:restapi/model/note_for_listing.dart';
import 'package:restapi/model/note_insert.dart';

class NotesService {
  static const APIBookStore = 'http://10.0.2.2:8000/user/sign-in';
  static const APINews = 'http://103.101.162.49/api/tintuc/GetTinTuc?page=1';
  static const API = 'http://api.notes.programmingaddict.com';
  static const APICountry = 'http://45.117.81.234:100/api/apiData/DanhSachThanhPho';
  static const APITest = 'https://randomuser.me/api/?results=15';
  static const headers = {
    'apiKey': '7b2b4ee5-e8a3-4a5b-a924-7376179f27aa',
    'Content-Type': 'application/json'
  };

  static const header = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader : ''
  };

  Future<APIResponse<List<GetJSNews>>> getListNews() {
    return http.get(APINews , headers: header).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final notes = <GetJSNews>[];
        print("Newsssss");
        for (var item in jsonData) {
          print(item);
          notes.add(GetJSNews.fromJson(item));
        }
        return APIResponse<List<GetJSNews>>(data: notes);
      }
      return APIResponse<List<GetJSNews>>(error: true, errorMessage: 'Loi cmnr nhe');
    })
        .catchError((_) => APIResponse<List<GetJSNews>>(error: true, errorMessage: 'Loi cmnr ha'));
  }

  Future<APIResponse<List<NoteForListing>>> getNotesList() {
    return http.get(API + '/notes', headers: headers).then((data) {
      if (data.statusCode == 200) {
        final jsonData = json.decode(data.body);

        final notes = <NoteForListing>[];
        //print("ooooooo");
        for (var item in jsonData) {
        //  print(item);
          notes.add(NoteForListing.fromJson(item));
        }
        return APIResponse<List<NoteForListing>>(data: notes);
      }
      return APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Loi cmnr nhe');
    })
        .catchError((_) => APIResponse<List<NoteForListing>>(error: true, errorMessage: 'Loi cmnr ha'));
  }

  ///get info from idNote

  Future<APIResponse<Note>> getNote(String noteID) {
    return http.get(API + '/notes/' + noteID, headers: headers).then((data) {
      if (data.statusCode == 200) {

        final jsonData = json.decode(data.body);
        return APIResponse<Note>(data: Note.fromJson(jsonData));
      }
      return APIResponse<Note>(error: true, errorMessage: 'Loi cmmr ?');
    })
        .catchError((_) => APIResponse<Note>(error: true, errorMessage: 'Loi cmm chua :)'));
  }

  /// post info - insert and return result
  Future<APIResponse<bool>> createNote(NoteInsert item) {
    return http.post(API + '/notes', headers: headers, body: json.encode(item.toJson())).then((data) {
      print(data.statusCode);
      if (data.statusCode == 201) {
        print(data.body);
        return APIResponse<bool>(data: true);
      }
      return APIResponse<bool>(error: true, errorMessage: 'An error occured');
    })
        .catchError((_) => APIResponse<bool>(error: true, errorMessage: 'An error occured'));
  }

  /// post method get List contry
  ///
  ///

  Future<APIResponse<List<GetCountry>>> bookStore() async{
    final response = await http.post(APIBookStore,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader : ''
      },
    ).then((data) {
      print(data.statusCode);
      if(data.statusCode == 200){
        final jsdata = json.decode(data.body)['data'];
        final listContry = <GetCountry>[];
        for(var item in jsdata){
          listContry.add(GetCountry.fromJson(item));
        }
        return APIResponse<List<GetCountry>>(data: listContry);
      }
      return APIResponse<List<GetCountry>>(error: true,errorMessage: 'List item is null');
    }).catchError((_) => APIResponse<List<GetCountry>>(error: true,errorMessage: 'Response is error'));
    return response;
  }


  Future<APIResponse<List<GetCountry>>> getListcontry() async{
    final response = await http.post(APICountry,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader : ''
        },
    ).then((data) {
      print(data.statusCode);
      if(data.statusCode == 200){
        final jsdata = json.decode(data.body)['data'];
        final listContry = <GetCountry>[];
        for(var item in jsdata){
          listContry.add(GetCountry.fromJson(item));
        }
        return APIResponse<List<GetCountry>>(data: listContry);
      }
      return APIResponse<List<GetCountry>>(error: true,errorMessage: 'List item is null');
    }).catchError((_) => APIResponse<List<GetCountry>>(error: true,errorMessage: 'Response is error'));
    return response;
  }

  Future<GetCountry> createAlbum(String title) async {
    final http.Response response = await http.post(
      'https://jsonplaceholder.typicode.com/albums',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );

    if (response.statusCode == 201) {
      return GetCountry.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create album.');
    }
  }

}

