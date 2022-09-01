import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fast_travel/common/theme_helper.dart';
import 'package:fast_travel/network_utils/api.dart';
import 'package:http/http.dart' as http;
import 'package:fast_travel/network_utils/api_fast_travel.dart';
import 'forgot_password_page.dart';
import 'profile_page.dart';
import 'registration_page.dart';
import 'widgets/header_widget.dart';
import 'package:email_validator/email_validator.dart';
import 'dart:developer';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double _headerHeight = 250;
  bool _isLoading = false;
  var email;
  var password;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );

    //_scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: _headerHeight,
              child: HeaderWidget(_headerHeight, true,
                  Icons.login_rounded), //let's create a common header widget
            ),
            SafeArea(
              child: Container(
                  padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  margin: EdgeInsets.fromLTRB(
                      20, 10, 20, 10), // This will be the login form
                  child: Column(
                    children: [
                      Text(
                        'Hello',
                        style: TextStyle(
                            fontSize: 60, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Connectez-vous à votre compte',
                        style: TextStyle(color: Colors.grey),
                      ),
                      SizedBox(height: 30.0),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Entrez votre Email";
                                    }
                                    if (EmailValidator.validate(value)) {
                                      email = value;
                                      return null;
                                    } else
                                      return "Adresse e-mail non valide";
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Adresse Email',
                                      'Entrez votre adresse email'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30.0),
                              Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Entrez un mot de passe';
                                    } else {
                                      password = value;
                                      log(password);
                                      return null;
                                    }
                                  },
                                  obscureText: true,
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Mot de passe',
                                      'Entrer votre mot de passe'),
                                ),
                                decoration:
                                    ThemeHelper().inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 15.0),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                                alignment: Alignment.topRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPasswordPage()),
                                    );
                                  },
                                  child: Text(
                                    "Mot de passe oublié?",
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(40, 10, 40, 10),
                                    child: Text(
                                      'Connexion'.toUpperCase(),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white),
                                    ),
                                  ),
                                  onPressed: () {
                                    // Validate returns true if the form is valid, or false otherwise.
                                    if (_formKey.currentState!.validate()) {
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Authentification en cours')),
                                      );
                                      //We can now call REST API to check if credentials match records
                                      //After successful login we will redirect to profile page. Let's create profile page now
                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                      _login();
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                                //child: Text('Don\'t have an account? Create'),
                                child: Text.rich(TextSpan(children: [
                                  TextSpan(text: "Pas de compte? "),
                                  TextSpan(
                                    text: 'Créer un compte',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    RegistrationPage()));
                                      },
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).accentColor),
                                  ),
                                ])),
                              ),
                            ],
                          )),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async {
    print("Here in _login function");
    //var response = API().getToken();
    setState(() {
      _isLoading = true;
    });

    var data = {
      'grant_type': 'password',
      'client_id': '2',
      'client_secret': 'IEQhZlThmKi37Gv5GnsSPpHEBIrqHgIvGbcdAi9T',
      'username': email,
      'password': password,
      'scope': '',
    };

    final response = await http.post(
      Uri.parse('http://fastravel.stillforce.tech/oauth/token'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode(data),
    );
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      //print(response.statusCode);
      //print(response.body);
      log("Access Token ok");
      var JsonData = jsonDecode(response.body);
      String token = JsonData['access_token'];

      //saving token in sharedPreferences;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', token);

      //launching a get request to have user information
      final userRequest = await http.get(
        Uri.parse('http://fastravel.stillforce.tech/api/v1/user'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (userRequest.statusCode == 200) {
        //Saving user information in sharedPreferences
        var user = jsonDecode(userRequest.body);
        print(userRequest.body);
        String name = user['name'];
        String email = user['email'];
        localStorage.setString('name', name);
        localStorage.setString('email', email);
        localStorage.setString('lastname', user['lastname']);
        localStorage.setString('phone', user['phone']);
        localStorage.setInt('role_id', user['role_id']);
        localStorage.setInt('id', user['id']);
        log("user ok");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Echec lors de la récupération de l'utilisateur")),
        );
      }

      //Now redirecting the user to the profil page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      //throw Exception('Error : Failed to create token.');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Paramètres incorrectes")),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }
}
