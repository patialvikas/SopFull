import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyClass(
          
        );
      }
    }
    
    class MyClass extends StatefulWidget{
      _BottomBarState createState() => _BottomBarState();
}
 
class _BottomBarState extends State<MyClass> {
  bool selected_item=false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
        height: 70,
        child: Material(
          child: InkWell(
            child:Container(
              decoration: new BoxDecoration ( color: Color.fromRGBO(0,66,96, 1), ),
              child:Row(
                children: [
                  Expanded(
                    child:Column(
                      children: [  
                        IconButton(
                          icon: Icon( Icons.home, color: selected_item  ? Color.fromRGBO(234,112,12, 1) : Colors.white, ),
                          onPressed: () { Navigator.pushReplacementNamed(context, '/home'); },
                        ),
                        Text("Home", style: TextStyle( color: Colors.white )),
                      ],
                    )
                  ),

                  Expanded(
                      child:Column(
                        children: [
                          IconButton(
                            icon: Icon( Icons.business, color: selected_item  ? Color.fromRGBO(234,112,12, 1) : Colors.white, ),
                            onPressed: () { Navigator.pushNamed(context, '/sops'); },
                          ),
                          Text("SOPs", style: TextStyle( color: Colors.white )),
                        ],
                      )
                  ),


                  Expanded(
                  child:Column(
                    children: [  
                      IconButton(
                        icon: Icon( Icons.business, color: selected_item  ? Color.fromRGBO(234,112,12, 1) : Colors.white, ),
                        onPressed: () { Navigator.pushNamed(context, '/departmentList'); },
                      ),
                      Text("SOP", style: TextStyle( color: Colors.white )),
                    ],
                  )
                ),
                ],
              ),
            ),
          ),
        ),
    );
  }
}

