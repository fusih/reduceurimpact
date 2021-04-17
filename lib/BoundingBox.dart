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
          print(x.toString()+ "  "+ y.toString());
          
          w = _w * previewW;
          w = w - w/2.7;
          h = _h * previewH;
          h = h - h/2.7;
          print(w.toString()+ " - lunghezza "  + h.toString()+" - altezza "+_h.toString()+"- altezza scala 1 "+previewH.toString()+" altezza screeen");


        return Positioned(
          left: math.max(0, x),
          top: math.max(0, y),
          width: w,
          height: h,
          child: GestureDetector(
            onTap: (){
              print(re["detectedClass"]);
              print("eccomi");
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(re["detectedClass"]),
                    content: Container(
                      child: SingleChildScrollView(

                        child: Text("eccomi ora vi mostro quanto cosuma questa cosa"),
                      ),
                    ),

                  )
              );
            },
            child: Container(
              padding: EdgeInsets.only(left: 5, top: 5),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 5.0,
                ),
              ),
              child: Text(
                "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                style: TextStyle(
                  color: Colors.white,
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
