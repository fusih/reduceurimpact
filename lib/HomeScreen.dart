import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ecoapp/BoundingBox.dart';
import 'package:ecoapp/Camera.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

const String ssd = "SSD MobileNet";
const String ssd2 = "SSD MobileNet v2";

class HomeScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomeScreen(this.cameras);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  loadModel() async {
    String result;

    switch (_model) {
      case ssd2:
        print("altromodello");
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssdlite_mobilenet_v2.tflite"
        );
        break;
      case ssd:
        print("Sono qui");
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssd_mobilenet.tflite"
        );
        break;
    }
    print("Questo è il riultato bro "+result);
  }

  onSelectModel(model) {
    setState(() {
      _model = model;
    });

    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: _model == ""
          ? Container(
            color: Colors.green,
            width:double.infinity,
            child: Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment. center,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: screen.height/4,
                      ),
                      Text(
                        "Reduce", style: TextStyle(fontSize: 60,color: Colors.white,fontWeight:FontWeight.bold ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: screen.height/30,
                      ),
                      Text(
                        "Ur", style: TextStyle(fontSize: 60,color: Colors.white,fontWeight:FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: screen.height/30,
                      ),
                      Text(
                        "Impact", style: TextStyle(fontSize: 60,color: Colors.white, fontWeight:FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
              ),
                Container(
                  margin: EdgeInsets.only(top: screen.height/1.3,left: screen.width/3.6),
                  height: screen.height/10,
                  width: screen.width/2.16,
                  child:  RaisedButton(
                      onPressed: () {
                        onSelectModel(ssd2);
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                      child:
                      Row(
                        children: <Widget>[
                          SizedBox(width: screen.width/20,),
                          Text("Start", style: TextStyle(color: Colors.green,fontSize: 30),),
                          SizedBox(width: screen.width/20,),
                          Icon(Icons.spa, color: Colors.green,),
                          SizedBox(width: screen.width/20,),
                        ],
                      )
                  ),
                )
              ],
            ),
         )
          : Stack(
        children: [
          Camera(widget.cameras, _model, setRecognitions),
          BoundingBox(
              _recognitions == null ? [] : _recognitions,
              math.max(_imageHeight, _imageWidth),
              math.min(_imageHeight, _imageWidth),
              screen.width, screen.height, _model
          )
        ],
      ),
    );
  }
}