
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fast_travel/pages/login_page.dart';
import 'package:fast_travel/pages/splash_screen.dart';
import 'package:fast_travel/pages/widgets/header_widget.dart';
import 'dart:developer';
import 'forgot_password_page.dart';
import 'forgot_password_verification_page.dart';
import 'registration_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _ProfilePageState();
  }
}

class _ProfilePageState extends State<ProfilePage>{

  double  _drawerIconSize = 24;
  double _drawerFontSize = 17;
  dynamic token;
  dynamic name = "";
  dynamic email = "";


  Future _retrieveData() async {
    log('Here in profile page');
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token');
    name = localStorage.getString('name');
    email = localStorage.getString('email');
    return localStorage;
  }


  @override
  Widget build(BuildContext context) {

    //Using a FutureBuilder to wait for the async function _retrieveData() to be ready
     return FutureBuilder(
      future: _retrieveData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //log(snapshot.data.toString());
          return Scaffold(
            appBar: AppBar(
              title: Text("Fast Travel",
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              elevation: 0.5,
              iconTheme: IconThemeData(color: Colors.white),
              flexibleSpace:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[Theme.of(context).primaryColor, Theme.of(context).accentColor,]
                    )
                ),
              ),
              actions: [
                Container(
                  margin: EdgeInsets.only( top: 16, right: 16,),
                  child: Stack(
                    children: <Widget>[
                      Icon(Icons.notifications),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(1),
                          decoration: BoxDecoration( color: Colors.red, borderRadius: BorderRadius.circular(6),),
                          constraints: BoxConstraints( minWidth: 12, minHeight: 12, ),
                          child: Text( '5', style: TextStyle(color: Colors.white, fontSize: 8,), textAlign: TextAlign.center,),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            drawer: Drawer(
              child: Container(
                decoration:BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        stops: [0.0, 1.0],
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(0.2),
                          Theme.of(context).accentColor.withOpacity(0.5),
                        ]
                    )
                ) ,
                child: ListView(
                  children: [
                    DrawerHeader(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 1.0],
                          colors: [ Theme.of(context).primaryColor,Theme.of(context).accentColor,],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        child: Text("Fast Travel",
                          style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.screen_lock_landscape_rounded, size: _drawerIconSize, color: Theme.of(context).accentColor,),
                      title: Text('Mes Courses', style: TextStyle(fontSize: 17, color: Theme.of(context).accentColor),),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SplashScreen(title: "Splash Screen")));
                      },
                    ),
                    ListTile(
                      leading: Icon(Icons.login_rounded,size: _drawerIconSize,color: Theme.of(context).accentColor),
                      title: Text('Rechercher un voyage', style: TextStyle(fontSize: _drawerFontSize, color: Theme.of(context).accentColor),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()),);
                      },
                    ),
                    Divider(color: Theme.of(context).primaryColor, height: 1,),
                    ListTile(
                      leading: Icon(Icons.person_add_alt_1, size: _drawerIconSize,color: Theme.of(context).accentColor),
                      title: Text('Inscription',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationPage()),);
                      },
                    ),
                    Divider(color: Theme.of(context).primaryColor, height: 1,),
                    ListTile(
                      leading: Icon(Icons.password_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                      title: Text('Mot de passe oublié',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                      onTap: () {
                        Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordPage()),);
                      },
                    ),
                    Divider(color: Theme.of(context).primaryColor, height: 1,),
                    ListTile(
                      leading: Icon(Icons.verified_user_sharp, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                      title: Text('Vérification',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                      onTap: () {
                        Navigator.push( context, MaterialPageRoute(builder: (context) => ForgotPasswordVerificationPage()), );
                      },
                    ),
                    Divider(color: Theme.of(context).primaryColor, height: 1,),
                    ListTile(
                      leading: Icon(Icons.logout_rounded, size: _drawerIconSize,color: Theme.of(context).accentColor,),
                      title: Text('Déconnexion',style: TextStyle(fontSize: _drawerFontSize,color: Theme.of(context).accentColor),),
                      onTap: () {
                        SystemNavigator.pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(height: 100, child: HeaderWidget(100,false,Icons.house_rounded),),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(width: 5, color: Colors.white),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 20, offset: const Offset(5, 5),),
                            ],
                          ),
                          child: Icon(Icons.person, size: 80, color: Colors.grey.shade300,),
                        ),
                        SizedBox(height: 20,),
                        Text(name, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                        SizedBox(height: 20,),
                        Text('Passager', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
                        SizedBox(height: 10,),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "Informations Utilisateur",
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Card(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    children: <Widget>[
                                      Column(
                                        children: <Widget>[
                                          ...ListTile.divideTiles(
                                            color: Colors.grey,
                                            tiles: [
                                              ListTile(
                                                contentPadding: EdgeInsets.symmetric(
                                                    horizontal: 12, vertical: 4),
                                                leading: Icon(Icons.my_location),
                                                title: Text("Localisation"),
                                                subtitle: Text("Douala, Cameroun"),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.email),
                                                title: Text("Email"),
                                                subtitle: Text(email),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.phone),
                                                title: Text("Phone"),
                                                subtitle: Text("+237-694-77-9579"),
                                              ),
                                              ListTile(
                                                leading: Icon(Icons.person),
                                                title: Text("A Propos"),
                                                subtitle: Text(
                                                    "Ceci est un lien à propos de moi et vous pouvez savoir qui je suis dans cette section."),
                                              ),
                                            ],
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return CircularProgressIndicator(); // or some other widget
      },
    );


  }

}