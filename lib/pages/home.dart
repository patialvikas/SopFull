import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import '../parts/footer.dart';
import '../parts/appBar.dart';
import '../parts/drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      drawer: Sidebar(),
      bottomNavigationBar: BottomBar(),
      body: Container(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[Header(), Slider(),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 15),
            child: Text( 'Bizz Sutra', textAlign: TextAlign.center, style: TextStyle( color: Color.fromRGBO(234,112,12, 1), fontWeight: FontWeight.bold, fontSize: 25.0 ) ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text( 'The complete Standard Operating procesures (SOP for your organisation on one click)', textAlign: TextAlign.center,
                style: TextStyle( fontWeight: FontWeight.w400 ) )
          ),


            // BottomBar()
          ],
        ),
      ),
    );
  }
}

class Slider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GFCarousel(
      autoPlay: true,
        viewportFraction:1.0,
      autoPlayInterval: Duration(seconds: 3),
      items: [1, 2, 3, 4, 5].map(
            (i) {
          return Container(
            margin: EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              // child: Image.asset( 'assets/images/$i.jpg', fit: BoxFit.cover, width: 1000.0 ),
              child: Image.network('http://akkdev.in/images/app/$i.jpg', fit: BoxFit.cover, width: 1000.0)
            ),
          );
        },
      ).toList(),
    );
  }
}
