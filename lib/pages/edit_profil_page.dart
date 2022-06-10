
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fast_travel/common/theme_helper.dart';
import 'package:fast_travel/pages/widgets/header_widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'dart:developer';
import 'dart:convert';
import 'login_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'profile_page.dart';

class EditionPage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _EditionPageState();
  }
}

class _EditionPageState extends State<EditionPage>{

  final _formKey = GlobalKey<FormState>();
  bool checkedValue = false;
  bool checkboxValue = false;
  dynamic name;
  dynamic lastname;
  dynamic email;
  dynamic password;
  dynamic password_confirmation;
  dynamic phone;
  dynamic token;
  dynamic role;
  dynamic id;

  // Initial Selected Value
  String role_id = 'Chauffeur';

  // List of items in our dropdown menu
  var items = [
    'Chauffeur',
    'Passager',
  ];

  Future _retrieveData() async {
    log('Here in edit profile page');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    name = localStorage.getString('name');
    lastname = localStorage.getString('lastname');
    email = localStorage.getString('email');
    phone = localStorage.getString('phone');
    role = localStorage.getInt('role_id');
    id = localStorage.getInt('id');
    if(role_id==1)
      role = "Admin";
    else if(role_id==2)
      role = "Chauffeur";
    else if(role_id==3)
      role = "Passager";
    return localStorage;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _retrieveData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 150,
                    child: HeaderWidget(
                        150, false, Icons.person_add_alt_1_rounded),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(25, 50, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    alignment: Alignment.center,
                    child: Column(
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              GestureDetector(
                                child: Stack(
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        border: Border.all(
                                            width: 5, color: Colors.white),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 20,
                                            offset: const Offset(5, 5),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade300,
                                        size: 80.0,
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          80, 80, 0, 0),
                                      child: Icon(
                                        Icons.add_circle,
                                        color: Colors.grey.shade700,
                                        size: 25.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                child: TextFormField(
                                  initialValue: lastname,
                                  // The validator receives the text that the user has entered.
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Entrez votre prénom";
                                    }
                                    else {
                                      lastname = value;
                                      log(value);
                                      return null;
                                    }
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Prénom', 'Entrez votre prénom'),
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 30,),
                              Container(
                                child: TextFormField(
                                  initialValue: name,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Entrez votre nom";
                                    }
                                    else {
                                      name = value;
                                      return null;
                                    }
                                  },
                                  decoration: ThemeHelper().textInputDecoration(
                                      'Nom', 'Entrez votre nom'),
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  initialValue: email,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Adresse E-mail", "Entrer votre Email"),
                                  keyboardType: TextInputType.emailAddress,
                                  validator: (val) {
                                    if (val == null || val.isEmpty) {
                                      return "Entrez une adresse e-mail valide";
                                    }
                                    if (!RegExp(
                                        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                                        .hasMatch(val)) {
                                      return "Entrez une adresse e-mail valide";
                                    }
                                    else {
                                      email = val;
                                      return null;
                                    }
                                  },
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                child: TextFormField(
                                  initialValue: phone,
                                  decoration: ThemeHelper().textInputDecoration(
                                      "Numéro de téléphone",
                                      "Entrez votre numéro de mobile"),
                                  keyboardType: TextInputType.phone,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Entrez un numéro de téléphone valide";
                                    }
                                    if (!RegExp(r"^(\d+)*$").hasMatch(value)) {
                                      return "Entrez un numéro de téléphone valide";
                                    }

                                    else {
                                      phone = value;
                                      return null;
                                    }
                                  },
                                ),
                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),

                              SizedBox(height: 20.0),
                              Container(
                                child: DropdownButton(

                                  // Initial Value

                                  value: role_id,
                                  isExpanded: true,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.keyboard_arrow_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items,
                                      child: Text(items),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      role_id = newValue!;
                                    });
                                  },
                                  hint: Text('Type de compte'),
                                ),

                                decoration: ThemeHelper()
                                    .inputBoxDecorationShaddow(),
                              ),

                              SizedBox(height: 15.0),
                              FormField<bool>(
                                builder: (state) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Checkbox(
                                              value: checkboxValue,
                                              onChanged: (value) {
                                                setState(() {
                                                  checkboxValue = value!;
                                                  state.didChange(value);
                                                });
                                              }),
                                          Text("J'accepte", style: TextStyle(
                                              color: Colors.grey),),
                                        ],
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          state.errorText ?? '',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(color: Theme
                                              .of(context)
                                              .errorColor, fontSize: 12,),
                                        ),
                                      )
                                    ],
                                  );
                                },
                                validator: (value) {
                                  if (!checkboxValue) {
                                    return 'Vous devez accepter les termes et conditions';
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              SizedBox(height: 20.0),
                              Container(
                                decoration: ThemeHelper().buttonBoxDecoration(
                                    context),
                                child: ElevatedButton(
                                  style: ThemeHelper().buttonStyle(),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        40, 10, 40, 10),
                                    child: Text(
                                      "Mettre à jour".toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      log(name);
                                      log(lastname);
                                      log(phone);
                                      log(email);
                                      log(role_id);
                                      // If the form is valid, display a snackbar. In the real world,
                                      // you'd often call a server or save the information in a database.
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                'Traitement en cours')),
                                      );
                                      //We can now call REST API to check if credentials match records
                                      //After successful login we will redirect to profile page. Let's create profile page now
                                      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                                      _register();
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 30.0),
                              Text(
                                "Ou créez un compte en utilisant les médias sociaux",
                                style: TextStyle(color: Colors.grey),),
                              SizedBox(height: 25.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.googlePlus, size: 35,
                                      color: HexColor("#EC2D2F"),),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Google Plus",
                                                "Vous appuyez sur l'icône sociale GooglePlus.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  SizedBox(width: 30.0,),
                                  GestureDetector(
                                    child: Container(
                                      padding: EdgeInsets.all(0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            100),
                                        border: Border.all(
                                            width: 5,
                                            color: HexColor("#40ABF0")),
                                        color: HexColor("#40ABF0"),
                                      ),
                                      child: FaIcon(
                                        FontAwesomeIcons.twitter, size: 23,
                                        color: HexColor("#FFFFFF"),),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Twitter",
                                                "Vous appuyez sur l'icône sociale Twitter.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                  SizedBox(width: 30.0,),
                                  GestureDetector(
                                    child: FaIcon(
                                      FontAwesomeIcons.facebook, size: 35,
                                      color: HexColor("#3E529C"),),
                                    onTap: () {
                                      setState(() {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return ThemeHelper().alartDialog(
                                                "Facebook",
                                                "Vous appuyez sur l'icône sociale de Facebook.",
                                                context);
                                          },
                                        );
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator(); // or some other widget
      },
    );
  }

  void _register() async{
    print("Here in _register function");
    //var response = API().getToken();

    var data = {
      'id': id,
      'name': name,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'role_id': role_id,
    };

    final response = await http.post(
      Uri.parse('http://fastravel.stillforce.tech/api/v1/edit/profile'),
      headers: {
        'Content-type' : 'application/json',
        'Accept' : 'application/json',
        'Authorization' : 'Bearer $token',
      },
      body: jsonEncode(data),
    );
    //print(response);
    //log('hello pnln');
    if (response.statusCode == 200) {
      // If the server did return a 200 CREATED response,
      // then parse the JSON.
      var jsonData = jsonDecode(response.body);
      log("now redirecting to profil page");
      //Launching login form
      print(jsonData);

      //saving token in sharedPreferences;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('name', jsonData['name']);
      localStorage.setString('email', jsonData['email']);
      localStorage.setString('lastname', jsonData['lastname']);
      localStorage.setString('phone', jsonData['phone']);
      localStorage.setInt('role_id', jsonData['role_id']);
      localStorage.setInt('id', jsonData['id']);
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
          content: new Text("Modifications faites avec succès")
      )

      );
      //Now redirecting the user to the profil page
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProfilePage()
        ),
      );
    }

    else if(response.statusCode == 412) {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      //throw Exception('Error : Failed to create token.');
      print(response.statusCode);
      print(response.body);
      var jsonData = jsonDecode(response.body);
      String message = jsonData['message'];
      dynamic data = jsonData['data'];

      if(data['email']!= null){
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: new Text("Email déjà utilisé")
        )

        );
      }
      if(data['password']!= null){
        ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
            content: new Text("Mot de passe doit contenir au moins 8 caractères")
        )

        );
      }

    }

    else {
      // If the server did not return a 200 CREATED response,
      // then throw an exception.
      //throw Exception('Error : Failed to create token.');
      print(response.statusCode);
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Une erreur est survenue, veuillez réessayez plutard")),
      );
    }

  }
}