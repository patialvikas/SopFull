import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sop_app/auth/util/app_url.dart';
import 'package:sop_app/pages/sops.dart';
import 'package:sop_app/parts/appBar.dart';
import 'package:sop_app/parts/drawer.dart';
import 'package:sop_app/parts/footer.dart';
import 'package:http/http.dart' as http;

class SopsUi extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    //throw UnimplementedError();
    return MyClasss();
  }


}

class MyClasss extends StatefulWidget{
  _MyDart createState()=> _MyDart();


}

class _MyDart extends State<MyClasss>{

  Future<Sops> futureloinlevel;
  int forname=0;
  List<int> indexformainlist;
  List<int>indexforinnerlist;
  List<List<int>>indexforthrdlist;
  List<List<int>>indexforfrthlist;
  List<List<int>>indexforfivlist;
  List<int>insidethird;
  var listofthrd;
  int u=0;
  @override
  void initState() {
    //futureloinlevel = fetchDeptListModel(1, context);
  }
  @override
  Widget build(BuildContext context) {
    forname=0;
    u=0;
    indexformainlist=new List();
    indexforinnerlist=new List();
    indexforthrdlist=new List();
    indexforfrthlist=new List();
    indexforfivlist=new List();
    insidethird=new List();
    // TODO: implement build
    //throw UnimplementedError();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        drawer: Sidebar(),
        bottomNavigationBar: BottomBar(),
        body:Container(

          child: new ListView(
             // mainAxisSize: MainAxisSize.min,
              children: <Widget>[
              Header(),
          Container(

              child: FutureBuilder<Sops>(
                  future: fetchDeptListModel(1, context),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: <Widget>[
                          ListView.builder(
                              physics: NeverScrollableScrollPhysics(), ///
                              shrinkWrap: true, ///
                              scrollDirection: Axis.vertical, ///
                              itemCount: callForLength(snapshot.data),
                              itemBuilder: (_, index) =>
                                  Container (
                                    decoration: new BoxDecoration (
                                        color: Color.fromRGBO(234, 112, 12, 1),
                                        border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
                                    ),
                                    child: new ExpansionTile(
                                      title: Text( //snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString()
                                        //callForMainListName(snapshot.data)
                                        snapshot.data.data[indexformainlist[index]].name
                                        ,
                                        textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                                      children: [
                                        createwidget(snapshot.data,indexformainlist[index]),
                                      ],
                                      //onTap: () {



                                       // Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(),} );

                                        //},
                                    ),
                                  )
                          )
                        ],
                      );
                    } else if (snapshot.hasError) { return Center( child: Text("${snapshot.error}")); }
                    return ( Center ( child: CircularProgressIndicator(), ));
                  }),
          ),
          ]),
        ),

    );
  }


  Future<Sops> fetchDeptListModel (int i,BuildContext context)async{
    Map bodyr;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("userToken");
    var res = await http.get(AppUrl.sopslist, headers: { 'Content-Type': 'application/json', 'Authorization': 'Bearer $token' } );
    if (res.statusCode == 200 && res.body.isNotEmpty) {
      bodyr = json.decode(res.body) as Map;
    }
    return Sops.fromJson(bodyr);
  }

 int callForLength(Sops data) {
    int y=0;
    for(int i=0;i<data.data.length;i++){
      if(data.data[i].step=="0"&&data.data[i].head=="0"){
        y++;
        indexformainlist.add(i);
      }
    }

    return y;
  }

  Widget createwidget(Sops data, int index) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(), ///
        shrinkWrap: true, ///
        scrollDirection: Axis.vertical, ///
        itemCount: callForinnerLength(data,index),
        itemBuilder: (_, index) =>
            Container (
              margin: EdgeInsets.only(left: 10),
              decoration: new BoxDecoration (
                  color: Color(0xff228B22),
                  border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
              ),
              child: new ExpansionTile(
                title: Text( //snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString()
                  //callForMainListName(snapshot.data)
                  data.data[indexforinnerlist[index]].name
                  ,
                  textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                children: [

                  createthrdwidget(data,indexforinnerlist[index],index),

                ],
                //onTap: () {



                // Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(),} );

                //},
              ),
            )
    );
  }

  callForinnerLength(Sops data, int index) {
    int y=0;
    for(int i=0;i<data.data.length;i++){
      if(data.data[i].step==index.toString()&&data.data[i].head==data.data[index].id){
        y++;
        indexforinnerlist.add(i);
        print("inner"+i.toString());
      }
    }

    return y;

  }

  Widget createthrdwidget(Sops data, int indexforinnerlis,int parentindex) {
    print("indexforinnerlist[indexforinnerlis].toString()"+indexforinnerlis.toString());
    //int u=0;
   // indexforthrdlist.clear();
    print("u"+u.toString());
    u++;
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(), ///
        shrinkWrap: true, ///
        scrollDirection: Axis.vertical, ///
        itemCount: callForthirdLength(data,indexforinnerlis),
        itemBuilder: (_, index) =>
            Container (
              margin: EdgeInsets.only(left: 10),
              decoration: new BoxDecoration (
                  color: Color(0xff3CB371),
                  border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
              ),
              child: new ExpansionTile(
                title: Text( //snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString()
                  //callForMainListName(snapshot.data)
                  data.data[indexforthrdlist[parentindex][ index ]].name
                  //callForName(index,data)
                  ,
                  textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                children: [
                  createfrthwidget(data,indexforthrdlist[parentindex][ index ],index),
                ],
                //onTap: () {



                // Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(),} );

                //},
              ),
            )
    );
  }

  callForthirdLength(Sops data, int indexforinnerlis) {
List<int>mui=new List();
    int y=0;
    for(int i=0;i<data.data.length;i++){
      if(data.data[i].step=="2"&&data.data[i].head==data.data[indexforinnerlis].id){
        y++;
        //indexforthrdlist.add(i);
        mui.add(i);
        print("third"+i.toString());
      }
    }
    indexforthrdlist.add(mui);
//listofthrd=[insidethird];

   // print(indexforthrdlist.toString());

    return y;

  }

 Widget createfrthwidget(Sops data, int indexforthrdlist, int parentindex) {
   return ListView.builder(
       physics: NeverScrollableScrollPhysics(), ///
       shrinkWrap: true, ///
       scrollDirection: Axis.vertical, ///
       itemCount: callForfrthLength(data,indexforthrdlist),
       itemBuilder: (_, index) =>
           Container (
             margin: EdgeInsets.only(left: 10),
             decoration: new BoxDecoration (
                 color: Color(0xffBA55D3),
                 border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
             ),
             child: new ExpansionTile(
               title: Text( //snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString()
                 //callForMainListName(snapshot.data)
                 data.data[indexforfrthlist[parentindex][ index ]].name
                 //callForName(index,data)
                 ,
                 textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
               children: [
                  createfivewidget(data,indexforfrthlist[parentindex][ index ],index),
               ],
               //onTap: () {



               // Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(),} );

               //},
             ),
           )
   );


 }

  callForfrthLength(Sops data, int indexforthrdlist) {
    List<int>muif=new List();
    int y=0;
    for(int i=0;i<data.data.length;i++){
      if(data.data[i].step=="3"&&data.data[i].head==data.data[indexforthrdlist].id){
        y++;
        //indexforthrdlist.add(i);
        muif.add(i);
        print("frth"+i.toString());
      }
    }
    indexforfrthlist.add(muif);
//listofthrd=[insidethird];

    // print(indexforthrdlist.toString());

    return y;

  }

  Widget createfivewidget(Sops data, int indexforfrthlist, int parentindex) {

    return ListView.builder(
        physics: NeverScrollableScrollPhysics(), ///
        shrinkWrap: true, ///
        scrollDirection: Axis.vertical, ///
        itemCount: callForfivLength(data,indexforfrthlist),
        itemBuilder: (_, index) =>
            Container (
              margin: EdgeInsets.only(left: 10),
              decoration: new BoxDecoration (
                  color: Color(0xff228B22),
                  border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
              ),
              child: new ExpansionTile(
                title: Text( //snapshot.data.data[index].name +'-'+ snapshot.data.data[index].id.toString()
                  //callForMainListName(snapshot.data)
                  data.data[indexforfivlist[parentindex][ index ]].name
                  //callForName(index,data)
                  ,
                  textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
                children: [
              Container ( margin: EdgeInsets.only(left: 10),

              decoration: new BoxDecoration (
              color: Color.fromRGBO(234, 112, 12, 1),
                border: Border( bottom: BorderSide( color: Color.fromRGBO(255, 255, 255, 1), width: 2.0 ) )
            ),
      child:FlatButton(
        onPressed: () {
          //Navigator.pushNamed(context, "YourRoute");
           Navigator.pushNamed(context, '/webview', arguments: { 'urladd': data.data[indexforfivlist[parentindex][ index ]].sop, } );
        },
        child: new Text("Download SOP", textAlign: TextAlign.center, style: TextStyle( color: Colors.white, ), ),
      ),),

                 // Widget createfivewidget(data,indexforfrthlist[parentindex][ index ],index),
                ],
                //onTap: () {



                // Navigator.pushReplacementNamed(context, '/sop', arguments: { 'id': snapshot.data.data[index].id.toString(),} );

                //},
              ),
            )
    );

  }

  callForfivLength(Sops data, int indexforfrthlist) {
    List<int>muifv=new List();
    int y=0;
    for(int i=0;i<data.data.length;i++){
      if(data.data[i].step=="4"&&data.data[i].head==data.data[indexforfrthlist].id){
        y++;
        //indexforthrdlist.add(i);
        muifv.add(i);
        print("frth"+i.toString());
      }
    }
    indexforfivlist.add(muifv);
//listofthrd=[insidethird];

    // print(indexforthrdlist.toString());

    return y;

  }

  /*String callForName(int index, Sops data) {
    u++;
    print("listlength"+indexforthrdlist.length.toString());
    print("insidethird u-1.."+insidethird[u-1].toString());
    print("index"+index.toString());
    print("u..."+u.toString());

    print("thrdlistindex"+indexforthrdlist[ (indexforthrdlist.length-insidethird[u-1])+index ].toString());
    for (var i = 0; i < listofthrd.length; i++) {
      for (var j = 0; j < listofthrd[i].length; j++) {
        return data.data[indexforthrdlist[listofthrd[i][j]]].name;
        print(listofthrd[i][j]);
      }
    }

   // return data.data[indexforthrdlist[ (indexforthrdlist.length-insidethird[u-1])+index ]].name;
  }*/







}