import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../parts/footer.dart';
import '../parts/appBar.dart';
import '../parts/drawer.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sop_app/models/DeptListModel.dart';
import '../auth/util/app_url.dart';

class DepartmentList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return deptReive();
  }
}

class deptReive extends StatefulWidget { 
  _MyPass createState() => _MyPass();
}

class _MyPass extends State<deptReive> {
  Future<DeptListModel> futureloinlevel;
  @override
  void initState() {
    futureloinlevel = fetchDeptListModel(1, context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      // drawer: Drawer(child:Sidebar()),
      drawer: Sidebar(),
      bottomNavigationBar: BottomBar(),
      body: Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Header(), 
            Container( 
              child: FutureBuilder<DeptListModel>(
                future: futureloinlevel,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: <Widget>[
                        ListView.builder(
                        physics: NeverScrollableScrollPhysics(), ///
                        shrinkWrap: true, ///
                        scrollDirection: Axis.vertical, ///
                          itemCount: snapshot.data.data.length,
                          itemBuilder: (_, index) =>                  
                          Container (
                            decoration: new BoxDecoration (
                                color: Color.fromRGBO(234, 112, 12, 1),
                                border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
                            ),
                            child: new ListTile( 
                              title: Text( snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString(), textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                                onTap: () { Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(), } ); },
                            ),
                          )
                        )
                      ],
                    );
                  } else if (snapshot.hasError) { return Center( child: Text("${snapshot.error}")); }
                  return ( Center ( child: CircularProgressIndicator(), ));
                })
            ),],
        ),
      ),
    );
  }
  Future<DeptListModel> fetchDeptListModel (int i,BuildContext context)async{
    Map bodyr;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken");
    var res = await http.get(AppUrl.deptList, headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' } );
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      bodyr = json.decode(res.body) as Map;
    }
    return DeptListModel.fromJson(bodyr);
  }
}