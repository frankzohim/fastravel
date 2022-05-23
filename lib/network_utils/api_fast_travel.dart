import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class API{

  final String _url = 'http://localhost:8000/api/v1';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiNzZhZDA4YzBkODFiZmIyZTgxZGJlY2QyYTllMjc4YzRmOTRlMWYzMDg0ZTI2YmFhM2NmZjlhMjc2NWI5MmFmYzRiYjFmMDlkNWJkODAwNzIiLCJpYXQiOjE2NTA3MjIxMDMuNTI4NDkyLCJuYmYiOjE2NTA3MjIxMDMuNTI4NTA4LCJleHAiOjE2ODIyNTgxMDEuNTQ3Mzk0LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.KmNXN_keupExRihhdMdqm4mmnkE-IIB_slr_TYytN7p99f2uWrdRf3WMHNRf38W3Th8daEBZbn4knRU9uOmq1OZl8kqcP2_ovADAq6q54S1mvfoPsH-UCJFnav1IDnauChsNYO31kjNmvYg_RMI-Wos5zq4Yr-ZbWEcon9lcLCDevW2MY1L4WX5vCK-q3ZvWc7smmIJFk5CYiF-tobRPf5wPtp6dK90fM0be3bfX9u7aRzPwqAD1-NjurzN5HTD4jJIPFsRuqqwb5YipZcXniwy1Rt7gsfL-lnN6u2VJ5urVGVY9IZuEnNbOTwhEEax5P9JEGw3IJSRkMB-BlnWHccSNNb_XGXoMKXL-kS4qxy5VQ_lxHc1BFdOSkFIZQKqxh4b8Rti50_ZXGkUEz7gMF67f1T9Yzqf2RHI7wSkUyfV5U6IXZ7nQdGFr_NaKgWxDB385dxwZQRa1ORmxqo-XP1a8Bd8iqnzgibPsIhaL2uUExcVqLup8ilrUdLXAxX0FithS38DzZUE4mNpMKT3eIlkwJjoSCpgzdNz0tR2CvllCYimSjF3DtBJzu224oOqb4htJ0tJ1Ra2W3I0L8vpcWPMWeIOn5yKxnA4jKN6e4vKcL0bDY16EewnnQC9AzJuOiAsGSS8xLBeilxG6yg_UPcQN2ignTR8JhSdq2EC_dCs";
  //var token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiZmM2Mjk5MWRjZjNlY2FmNDA5Y2QzNjQ2ZmRiNzY3MDIwODEyNjkwYTg2YTc0ODUzNGU1Y2ZhMjQ3NzdhMTVjM2Q1NDZjZTdiNzRjOGYyZmEiLCJpYXQiOjE2NTA3MjQzODcuOTg0NTI0LCJuYmYiOjE2NTA3MjQzODcuOTg0NTM4LCJleHAiOjE2ODIyNjAzODcuNjk4NzgzLCJzdWIiOiIxMCIsInNjb3BlcyI6W119.D1kMp9LTCmqZWmnBZMKH1gzrmck6ZqfU9sCkilc2XAdPHhQENw7RGtWLRjSpXEWKDCeskaV3XuG5CuRpo5rsNqVlHdJZqSQdaHRhNzZ-rcNhUcBTIGl_EQ9tkXEwWqg94Ecry2Gm3N0k9vgmGk-fxK6xGXuMRzVRYrkN3MUhK8WmiU44UswaaJcZawHCTpcLlFM5QtBoPzW5hGXi5N60ceFzNktzxdgVXNLEjZ2z510AUIhs2fkTUwpd8f4-T80dKc9tlayu065gnbhHAAzOc0lWbO5eLvPimCkZybG6tIucdWrUFDxqtabm6m0yr5zlPvhSlBnv8rXAb0LUfQxfj1mpJyiP28OSYhcJSBCSNlVfZry7VOyUGGp__4l4woAdTvnPj77sk4g-U8HHmuXMV_RuFOMbbAtdqdAlhoLOwXIkhZ8Uz0zUnu51qJsIfireSxBXfVNypP5_oGXgJYItJVN5rBn7pguhtdi2log7VSwD6TDtc1FNcIR1hwQs3qvcagKEf0R3newusx1pWjICR2PxtX9PDobc0o4JYkM7EHetxLqEwH2gbemXB5jD1oN25TPUyUSZnyHZ0u9KXs7znMHesoUdZfWl_9hQ8dhWbmfBJCNmG6ED01ysibsT-gftDA8X7cDCivqGZPPrzLNdcK5z5nWc3F6catufFhOEOns";

  Future getTest() async {
    final response = await http
        .get(Uri.parse('http://192.168.100.138/api/v1/user'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer $token',
    },);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print(response.body);
      //var JsonData = jsonDecode(response.body);
      //print(JsonData);
      //return JsonData;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      throw Exception('Failed to load album');
    }
  }

  Future<Album> createAlbum() async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': 'Fofe',
      }),
    );

    if (response.statusCode == 201) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print("create album");
      print(response.body);
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<Token> getToken() async {

    print('totoj');
    var data = {
      'grant_type': 'password',
      'client_id': '2',
      'client_secret': '8kAY1eaumD49xk476pbDHvh4DXdCQ6osv08XvWPH',
      'username': 'delanofofe@gmail.com',
      'password': 'godblessme',
      'scope': '',
    };
    final response = await http.post(
      Uri.parse('http://192.168.100.108:8000/oauth/token'),
      headers: {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      print(response.statusCode);
      print(response.body);
      return Token.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      throw Exception('Error : Failed to create token.');
    }
  }

  Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/4'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }


  /*authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }*/




  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}

class Token {
  final String token_type;
  final String expires_in;
  final String access_token;

  const Token({required this.token_type, required this.expires_in, required this.access_token});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      token_type: json['token_type'],
      expires_in: json['expires_in'],
      access_token: json['access_token'],
    );
  }
}

class Album {
  final int id;
  final String title;

  const Album({required this.id, required this.title});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
    );
  }
}