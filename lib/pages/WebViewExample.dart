import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:sop_app/auth/util/app_url.dart';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';

class WebViewExample extends StatefulWidget {
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<WebViewExample> {
String urladd;
InAppWebViewController _webViewController;
var taskId;
bool checkforbutton=false;
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    //if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FileView"),backgroundColor: Color.fromRGBO(234, 112, 12, 1),),
      body:

     Container(child: Column(children:[
      Flexible(flex:5,
        fit: FlexFit.loose,child: InAppWebView(
      initialUrl: AppUrl.webviewURL+urladd,
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
              debuggingEnabled: true,
              useOnDownloadStart: true
          ),
        ),

        onWebViewCreated: (InAppWebViewController controller) {
          _webViewController = controller;
        },

        onDownloadStart: (controller, url) async {
          print("onDownloadStart $url");
          setState(() {
            checkforbutton=true;
          });

         // File path = new File( await getExternalStorageDirectory() );
         // print(await getExternalStorageDirectory().path);
          taskId = await FlutterDownloader.enqueue(
            url: url,
            savedDir: (await getExternalStorageDirectory()).path,
            showNotification: true, // show download progress in status bar (for Android)
            openFileFromNotification: true,
            // click on notification to open downloaded file (for Android)
          );
        },
//FlutterDownloader.open(taskId: taskId);
        //javascriptMode: JavascriptMode.unrestricted,
    ),),
       Visibility(visible:checkforbutton,child:

      Flexible(flex:1,
        fit: FlexFit.loose,
        child: ButtonBar(

         alignment: MainAxisAlignment.center,
         children: <Widget>[


           RaisedButton(

             child: Icon(Icons.view_headline),
             onPressed: () {
               //FlutterDownloader.open(taskId: taskId);
               OpenFile.open("/storage/emulated/0/Android/data/com.example.sop_app/files/$urladd");
             },
           ),
         ],
       ),),

       ),

    ]

     ),),
    );
  }

  @override
  void didChangeDependencies() {
    final Map<String, String> argss = ModalRoute.of(context).settings.arguments;
    urladd = argss["urladd"];
    print(urladd);
  }
}