import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/UserModel.dart';
import 'providers/auth.dart';
import 'providers/user_provider.dart';
import 'util/validators.dart';
import 'util/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../auth/util/app_url.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Future<OrgList> futureloinlevel;
  final formKey = new GlobalKey<FormState>();
  String name, org, email, password, password_confirmation;
  String selectedOrg;
  List data = List();

  Future getOrgList() async {
    var response = await http.get(AppUrl.getDept, headers: {'Accept': 'application/json'});
    var responseData = json.decode(response.body);
    setState(() {
      data = responseData['data'];
    });
    return "success";
  }
  void callmyFun() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String check=prefs.getString("loginstatus") ?? "hii";
    try {
      if(check=="true"){
        Navigator.pushReplacementNamed(context, '/home');
      }else{
        getOrgList();
      }
    } on Exception catch (e) {
      print('error caught: $e');
    }
  }
  @override
  void initState(){
    super.initState();
    callmyFun();
  }
  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    final nameField = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Please enter first name" : null,
      onSaved: (value) => name = value,
      decoration: buildInputDecoration("Name", Icons.person),
      style: TextStyle(fontSize: 18, color: Colors.white),      
    );

    final orgField = Container(
    width: 500.0,
    // child: DropdownButtonHideUnderline( 
      child: DropdownButton(
      autofocus: false,
      value: selectedOrg,
      style: TextStyle(color: Color.fromRGBO(0,66,96, 1) ),
      hint: Text('Select Organisation', style: TextStyle( color: Color.fromRGBO(234,112,12, 1) ) ),
      items: data.map((i){
        return DropdownMenuItem(
          child: Text(i['org'], style: TextStyle( color: Color.fromRGBO(234,112,12, 1) )),
          value: i['id'].toString(),
        );
      },).toList(),
      onChanged: (value) { setState(() { selectedOrg = value; }); },
    )
    // )
    );

    final emailField = TextFormField(
      autofocus: false,
      validator: validateEmail,
      onSaved: (value) => email = value,
      decoration: buildInputDecoration("Email", Icons.email),
      style: TextStyle(fontSize: 18, color: Colors.white),
    );

    final passwordField = TextFormField(
      autofocus: false,
      obscureText: true,
      validator: (value) => value.isEmpty ? "Please enter password" : null,
      onSaved: (value) => password = value,
      decoration: buildInputDecoration("Password", Icons.lock),
      style: TextStyle(fontSize: 18, color: Colors.white),
    );

    final confirmPassword = TextFormField(
      autofocus: false,
      validator: (value) => value.isEmpty ? "Your password is required" : null,
      onSaved: (value) => password_confirmation = value,
      obscureText: true,
      decoration: buildInputDecoration("Confirm password", Icons.lock),
      style: TextStyle(fontSize: 18, color: Colors.white),
    );

    var loading = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularProgressIndicator(),
        Text("Registering ... Please wait")
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
          child: Text("Sign In", style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromRGBO(234,112,12, 1))),
          // onPressed: () { Navigator.pushReplacementNamed(context, '/login'); },
          onPressed: () { Navigator.pushReplacementNamed(context, '/login'); },
        ),
      ],
    );

    var doRegister = () async{
     // Map response;
      final form = formKey.currentState;
      if (form.validate()) {
        form.save();
        await auth.fetchRegModel(context,name, email, password, password_confirmation, selectedOrg ).then((response) {
        });
      } else {
        Flushbar(
          title: "Invalid form",
          message: "Please complete the form properly",
          duration: Duration(seconds: 20),
        ).show(context);
      }
    };

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(40.0),
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text( 'Register with Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
                SizedBox(height: 50.0), label("Name"), SizedBox(height: 3.0), nameField,
                SizedBox(height: 10.0), label("Email"), SizedBox(height: 3.0), emailField,
                SizedBox(height: 10.0), label("Organisation"), SizedBox(height: 3.0), orgField,
                SizedBox(height: 10.0), label("Password"), SizedBox(height: 3.0), passwordField,
                SizedBox(height: 10.0), label("Confirm Password"), SizedBox(height: 3.0), confirmPassword,
                SizedBox(height: 12.0),
                auth.loggedInStatus == Status.Authenticating ? loading : longButtons("Register", doRegister),
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