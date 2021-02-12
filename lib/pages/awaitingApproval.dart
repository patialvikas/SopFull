import 'package:flutter/material.dart';

class AwaitingApproval extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
          constraints: BoxConstraints.expand(),
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text( 'Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
              SizedBox(height: 50.0),
              Text( 'Please Wait for Approval', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
              SizedBox(height: 30.0),
              Text('Your registration has been succesfully done. Request you to wait till the admin from organisation approves your account.', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(255,255,255, 1), fontSize: 20.0, height: 2,)),
              SizedBox(height: 30.0),
              Text( 'Thanks for your Patience', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
            ]
          )
        )
      )
    );
  }
}