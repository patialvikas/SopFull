import 'package:flutter/material.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: Builder(
        builder: (context) => IconButton(
          icon: new Icon( Icons.menu, color: Color.fromRGBO(0,66,96, 1) ), onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ),
      title: Text( 'Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(0,66,96, 1) ) ),
      backgroundColor: Colors.white,
    );
  }
}
