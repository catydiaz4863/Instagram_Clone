import 'package:flutter/material.dart';
import 'package:instagram_clone/blocs/instagrambloc.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    InstagramBloc bloc = Provider.of<InstagramBloc>(context);

    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Text("Instagram",
              style: TextStyle(color: Colors.black,
              fontSize: 50,
              fontFamily: 'Instagram',
              fontStyle: FontStyle.italic,
              
              )),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: usernameCtrl,
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                controller: passwordCtrl,
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left:250),
              child: Text("Forgot password?",
              style: TextStyle(
                color: Color(0xFF5395E9),
                ),
              ),
            ),
           
              Padding(
            padding: EdgeInsets.only(top: 50,),
            child: RaisedButton(
              padding: EdgeInsets.symmetric(horizontal: 150),
              child: Text(
                "Log In",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            
              color: Color(0xFFA5C9F3),
              onPressed: () async {
                 bloc.attemptLogin(usernameCtrl.text, passwordCtrl.text);
              }

              
            ),
              ),
              Text(bloc.didLoginFail ? "Login failed" : "", style: TextStyle(color: Colors.redAccent),)
            
          ],
        )) 
      
    );
  }
}