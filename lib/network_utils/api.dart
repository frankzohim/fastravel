
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

class Network{
  final String _url = 'http://192.168.100.103:8000/api/v1';
  //if you are using android studio emulator, change localhost to 10.0.2.2
  var token;

  /*_getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = jsonDecode(localStorage.getString('token'))['token'];
  }*/
  Future getUserData() async {
    var response = await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var JsonData = jsonDecode(response.body);
    List<User> users = [];
    for(var u in JsonData){
      User user = User(u['name'], u['email'], u['username']);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  /*Future<Album> fetchAlbum() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/albums/4'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("Hello Album");
      return Album.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }*/

  Future getTest() async {
    final response = await http
        .get(Uri.parse('http://192.168.43.150:8000/api/v1/user'), headers: {
      HttpHeaders.authorizationHeader: 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIyIiwianRpIjoiNzZhZDA4YzBkODFiZmIyZTgxZGJlY2QyYTllMjc4YzRmOTRlMWYzMDg0ZTI2YmFhM2NmZjlhMjc2NWI5MmFmYzRiYjFmMDlkNWJkODAwNzIiLCJpYXQiOjE2NTA3MjIxMDMuNTI4NDkyLCJuYmYiOjE2NTA3MjIxMDMuNTI4NTA4LCJleHAiOjE2ODIyNTgxMDEuNTQ3Mzk0LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.KmNXN_keupExRihhdMdqm4mmnkE-IIB_slr_TYytN7p99f2uWrdRf3WMHNRf38W3Th8daEBZbn4knRU9uOmq1OZl8kqcP2_ovADAq6q54S1mvfoPsH-UCJFnav1IDnauChsNYO31kjNmvYg_RMI-Wos5zq4Yr-ZbWEcon9lcLCDevW2MY1L4WX5vCK-q3ZvWc7smmIJFk5CYiF-tobRPf5wPtp6dK90fM0be3bfX9u7aRzPwqAD1-NjurzN5HTD4jJIPFsRuqqwb5YipZcXniwy1Rt7gsfL-lnN6u2VJ5urVGVY9IZuEnNbOTwhEEax5P9JEGw3IJSRkMB-BlnWHccSNNb_XGXoMKXL-kS4qxy5VQ_lxHc1BFdOSkFIZQKqxh4b8Rti50_ZXGkUEz7gMF67f1T9Yzqf2RHI7wSkUyfV5U6IXZ7nQdGFr_NaKgWxDB385dxwZQRa1ORmxqo-XP1a8Bd8iqnzgibPsIhaL2uUExcVqLup8ilrUdLXAxX0FithS38DzZUE4mNpMKT3eIlkwJjoSCpgzdNz0tR2CvllCYimSjF3DtBJzu224oOqb4htJ0tJ1Ra2W3I0L8vpcWPMWeIOn5yKxnA4jKN6e4vKcL0bDY16EewnnQC9AzJuOiAsGSS8xLBeilxG6yg_UPcQN2ignTR8JhSdq2EC_dCs',
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



  /*authData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(
        fullUrl,
        body: jsonEncode(data),
        headers: _setHeaders()
    );
  }*/

  /*getData(apiUrl) async {
    var fullUrl = _url + apiUrl;
    await _getToken();
    return await http.get(
        fullUrl,
        headers: _setHeaders()
    );
  }*/

  _setHeaders() => {
    'Content-type' : 'application/json',
    'Accept' : 'application/json',
    'Authorization' : 'Bearer $token'
  };

}

class User {
  final String name, email, userName;
  User(this.name,this.email,this.userName);
}

