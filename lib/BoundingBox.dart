import 'package:flutter/material.dart';
import 'dart:math' as math;

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;

  BoundingBox(this.results, this.previewH, this.previewW, this.screenH,
      this.screenW, this.model);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var  x, y, w, h;

          x=_x*previewW;
          x=x-x/2.7;
          y=_y*previewH ;
          y=y-y/2.7;

          w = _w * previewW;
          w = w - w/2.7;
          h = _h * previewH;
          h = h - h/2.7;


        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: GestureDetector(
            onTap: (){
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    backgroundColor: Color(0xFF8FD5A6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: <Widget> [
                          SizedBox(
                              height: 5,
                          ),
                          Text(re["detectedClass"].toUpperCase(),textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF054E48),fontWeight: FontWeight.bold,fontSize: 22.0,),),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            margin: const EdgeInsets.only(right: 50.0),
                            child: Text("ANNUAL C02 CONSUMPTION:",textAlign: TextAlign.left,style: TextStyle(color: Color(0xFF0C8346),fontWeight: FontWeight.bold,fontSize: 15.0,)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            child: Text("A laptop uses between 50 and 100 W/hour when it is being used, depending on the model. A laptop that is on for eight hours a day uses between 150 and 300 kWh and emits between 44 and 88 kg of CO2 per year.",style: TextStyle(color: Color(0xFF329F5B),fontSize: 15.0)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text("TIPS ON HOW TO REDUCE UR IMPACT:",textAlign: TextAlign.left,style: TextStyle(color: Color(0xFF0C8346),fontWeight: FontWeight.bold,fontSize: 15.0,)),
                          ),
                          SizedBox(
                            height: 7,
                          ),
                          Container(
                            child: Text("Switch off your computer or put it in stand-by mode if you are not going to work on your PC for more than 30 minutes. A multiple socket makes it easy to switch off all your computing equipment.",style: TextStyle(color: Color(0xFF329F5B),fontSize: 15.0)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            child: Text("tap outside the box to close",textAlign: TextAlign.center,style: TextStyle(color: Color(0xFF054E48),fontWeight: FontWeight.bold,fontSize: 14.0,),),
                          ),
                        ],
                      )

                    ),

                  )
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Color(0xFF8FD5A6),
                  width:2,
                ),
              ),
              child: Text(
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  color: Color(0xFF8FD5A6),
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )

        );
      }).toList();
    }
    return Stack(
      children: _renderBoxes(),
    );
  }
}
