import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:sop_app/auth/login.dart';
import 'dart:convert';
import 'package:sop_app/models/DeptListModel.dart';
import '../auth/util/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../auth/providers/auth.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatefulWidget {
  _MyRegister createState() => _MyRegister();
}

class _MyRegister extends State<Sidebar> {
  Future<DeptListModel> futureloinlevel;

  @override
  void initState() {
    futureloinlevel = fetchDeptListModel();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = Provider.of<AuthProvider>(context);
    return Drawer(child:
        FutureBuilder<DeptListModel>(
        future: futureloinlevel,
        builder: (context, snapshot) {
        if (snapshot.hasData) {
          return
            Column(
            children: [
            createDrawerHeader(context,snapshot),
            bodyofDrawer(context,snapshot),
            ListTile(
              title:Text('Log Out', style: TextStyle( fontWeight: FontWeight.bold) ),
              onTap: () async {
                if (await auth.logout()) {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      Login()), (Route<dynamic> route) => false);
                  // Navigator.pushReplacementNamed(context, '/login');
                }
              }
            ),
          ],
        );
          } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
          }
          return (Center(
          child: CircularProgressIndicator(),
          ));
        }),
    );
  }

  Widget createDrawerHeader(BuildContext context, AsyncSnapshot<DeptListModel> snapshot) {
    return DrawerHeader(
      decoration: BoxDecoration( color: Color.fromRGBO(0,66,96, 1), ),
      child: Center( child : Text( 'Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ), )
      );
  }

 Widget bodyofDrawer(BuildContext context, AsyncSnapshot<DeptListModel> snapshot) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount:snapshot.data.data.length,
        itemBuilder: (BuildContext context,int index){
          return ListTile(
              title:Text(snapshot.data.data[index].name, style: TextStyle( fontWeight: FontWeight.bold) ),
            onTap: () {
              Navigator.pushReplacementNamed(context, '/sop', arguments: <String, String>{ 'id': snapshot.data.data[index].id.toString() },);
            },
          );
        }
    );
 }

  Future<DeptListModel> fetchDeptListModel ()async{
    Map bodyr;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken");
    var res = await http.get(AppUrl.deptList, headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token', } );
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      bodyr = json.decode(res.body) as Map;
    }
    return DeptListModel.fromJson(bodyr);
  }
}