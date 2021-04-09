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
        var scaleW, scaleH, x, y, w, h;
        print(_x.toString() + " "+  _y.toString() + " via" + re["detectedClass"]);
        if (screenH / screenW > previewH / previewW) {
          scaleW = screenH / previewH * previewW;
          scaleH = screenH;
          var difW = (scaleW - screenW) / scaleW;
          x = (_x - difW / 2) * scaleW;
          w = _w * scaleW;
          if (_x < difW / 2) w -= (difW / 2 - _x) * scaleW;
          y = _y * scaleH;
          h = _h * scaleH;
        } else {
          scaleH = screenW / previewW * previewH;
          scaleW = screenW;
          var difH = (scaleH - screenH) / scaleH;
          x = _x * scaleW;
          w = _w * scaleW;
          y = (_y - difH / 2) * scaleH;
          h = _h * scaleH;
          if (_y < difH / 2) h -= (difH / 2 - _y) * scaleH;
        }

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