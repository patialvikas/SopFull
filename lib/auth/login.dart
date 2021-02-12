import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sop_app/pages/home.dart';
import '../models/UserModel.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';
import 'util/validators.dart';
import 'util/widgets.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = new GlobalKey<FormState>();

  String _username, _password;
//Data data=new Data();

  checkLogin ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String checkToken = prefs.getString("loginstatus")??"xyz";
    print('check - $checkToken');
    if(checkToken == "true"){
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
          Home()), (Route<dynamic> route) => false);
      // Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  void initState() {
    print('Login page');
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);

    final usernameField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => _username = value,
      decoration: buildInputDecoration("Confirm password", Icons.email),
      style: TextStyle(fontSize: 18, color: Colors.white),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => _password = value,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
      style: TextStyle(fontSize: 18, color: Colors.white),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text(" Authenticating ... Please wait")
      ],
    );

    final forgotLabel = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          padding: EdgeInsets.all(0.0),
          child: Text("Forgot password?",
              style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(234,112,12, 1) )),
          onPressed: () {
//            Navigator.pushReplacementNamed(context, '/reset-password');
          },
        ),
        FlatButton(
          padding: EdgeInsets.only(left: 0.0),
          child: Text("Sign up", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(234,112,12, 1))),
          onPressed: () { Navigator.pushReplacementNamed(context, '/register'); },
        ),
      ],
    );

    var doLogin = () {
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        auth.fetchLoginModel(context,_username, _password);
      } else {
        print("form is invalid");
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child:
            SingleChildScrollView(child:
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 'Login with Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
                SizedBox(height: 50.0), label("Email"), SizedBox(height: 5.0), usernameField, 
                SizedBox(height: 20.0), label("Password"), SizedBox(height: 5.0), passwordField,
                SizedBox(height: 20.0),
                auth.loggedInStatus == Status.Authenticating
                    ? loading
                    : longButtons("Login", doLogin),
                SizedBox(height: 5.0),
                forgotLabel
              ],
            ),
            ),

          ),
        ),
      ),
    );
  }
}