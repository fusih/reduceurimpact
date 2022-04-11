import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:ecoapp/BoundingBox.dart';
import 'package:ecoapp/Camera.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:tflite/tflite.dart';
import 'dart:math' as math;

const String ssd = "SSD MobileNet";
const String ssd2 = "SSD MobileNet v2";
List<String> bandiere = ["🇬🇧", "🇮🇹"];
List<String> start = ["start", "inzia"];
List<String> lingua = ["Language: ", "Lingua: "];
int flaglingua = 0;
const object = {
  "person": ["persona", 0],
  "bicycle": ["bicicletta", 1],
  "car": ["macchina", 2],
  "motorcycle": ["motocicletta", 3],
  "airplane": ["aereoplano", 4],
  "bus": ["bus", 5],
  "train": ["treno", 6],
  "truck": ["camion", 7],
  "boat": ["barca", 8],
  "traffic light": ["semaforo", 9],
  "fire hydrant": ["idrante", 9],
  "???": ["???", 9],
  "stop sign": ["segnale di stop", 9],
  "parking meter": ["parchimetro", 9],
  "bench": ["panchina", 9],
  "bird": ["uccello", 9],
  "cat": ["gatto", 9],
  "dog": ["cane", 9],
  "horse": ["cavallo", 9],
  "sheep": ["pecora", 10],
  "cow": ["mucca", 10],
  "elephant": ["elefante", 9],
  "bear": ["orso", 9],
  "zebra": ["zebra", 9],
  "giraffe": ["giraffa", 9],
  "backpack": ["zaino", 9],
  "umbrella": ["ombrello", 9],
  "handbag": ["borsetta", 9],
  "tie": ["cravatta", 9],
  "suitcase": ["valigia", 9],
  "frisbee": ["frisbee", 9],
  "skis": ["sci", 9],
  "snowboard": ["snowboard", 9],
  "sports ball": ["palla", 9],
  "kite": ["aquilone", 9],
  "baseball bat": ["Mazza da baseball", 9],
  "baseball glove": [":guanto da baseball", 9],
  "skateboard": ["skateboard", 9],
  "surfboard": ["surfboard", 9],
  "tennis racket": ["racchetta da tennis", 9],
  "bottle": ["bottiglia", 11],
  "wine glass": ["bicchiere di vino", 9],
  "cup": ["tazza", 9],
  "fork": ["forchetta", 9],
  "knife": ["coltello", 9],
  "spoon": ["cucchiaio", 9],
  "bowl": ["ciotola", 9],
  "banana": ["banana", 16],
  "apple": ["mela", 16],
  "sandwich": ["sandwich", 16],
  "orange": ["arancia", 16],
  "broccoli": ["broccoli", 16],
  "carrot": ["carota", 16],
  "hot dog": ["hot dog", 16],
  "pizza": ["pizza", 16],
  "donut": ["ciambella", 16],
  "cake": ["torta", 16],
  "chair": ["sedia", 9],
  "couch": ["divano", 9],
  "potted plant": ["pianta in vaso", 9],
  "bed": ["letto", 9],
  "dining table": ["tavolo", 9],
  "toilet": ["gabinetto", 9],
  "tv": ["tv", 17],
  "laptop": ["laptop", 12],
  "mouse": ["mouse", 9],
  "remote": ["telecomando", 9],
  "keyboard": ["tastiera", 9],
  "cell phone": ["cellulare", 13],
  "microwave": ["microonde", 9],
  "oven": ["forno", 9],
  "toaster": ["tostapane", 9],
  "sink": ["Lavello", 9],
  "refrigerator": ["frigorifero", 14],
  "book": ["libro", 9],
  "clock": ["orologio", 9],
  "vase": ["vaso", 9],
  "scissors": ["forbici", 9],
  "teddy bear": ["teddy bear", 9],
  "hair drier": ["asciugacapelli", 15],
  "toothbrush": ["spazzolino", 9],
};

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

  BannerAd _bannerAd;
  bool isAdLoaded = false;

  InterstitialAd _interstitialAd;
  bool _isAdLoaded = false;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _initBannerAd();
    _initAd();
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => _initAd());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _initBannerAd() {
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: "ca-app-pub-ADCODE",
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {},
      ),
      request: AdRequest(),
    );

    _bannerAd.load();
  }

  void _initAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-ADCODE",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: onAdLoaded,
        onAdFailedToLoad: (error) {
          print(error);
        },
      ),
    );
  }

  void onAdLoaded(InterstitialAd ad) {
    _interstitialAd = ad;
    _isAdLoaded = true;
  }

  loadModel() async {
    String result;

    switch (_model) {
      case ssd2:
        print("altromodello");
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssdlite_mobilenet_v2.tflite");
        break;
      case ssd:
        print("Sono qui");
        result = await Tflite.loadModel(
            labels: "assets/ssd_mobilenet.txt",
            model: "assets/ssd_mobilenet.tflite");
        break;
    }
    print("Questo è il riultato bro " + result);
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
              width: double.infinity,
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: screen.height / 10,
                        ),
                        GestureDetector(
                            child: Text(
                                lingua[flaglingua] + "" + bandiere[flaglingua],
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white)),
                            onTap: () {
                              setState(() {
                                if (flaglingua == 1) {
                                  flaglingua = 0;
                                } else {
                                  flaglingua = 1;
                                }
                              });
                            }),
                        SizedBox(
                          height: screen.height / 7,
                        ),
                        Text(
                          "Reduce",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: screen.height / 30,
                        ),
                        Text(
                          "Ur",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: screen.height / 30,
                        ),
                        Text(
                          "Impact",
                          style: TextStyle(
                              fontSize: 60,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: screen.height / 1.3, left: screen.width / 3.6),
                    height: screen.height / 10,
                    width: screen.width / 2.16,
                    child: RaisedButton(
                        onPressed: () {
                          onSelectModel(ssd2);
                        },
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: Row(
                          children: <Widget>[
                            SizedBox(
                              width: screen.width / 20,
                            ),
                            Text(
                              start[flaglingua],
                              style:
                                  TextStyle(color: Colors.green, fontSize: 30),
                            ),
                            SizedBox(
                              width: screen.width / 24,
                            ),
                            Icon(
                              Icons.spa,
                              color: Colors.green,
                            ),
                            SizedBox(
                              width: screen.width / 20,
                            ),
                          ],
                        )),
                  ),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: isAdLoaded
                          ? Container(
                              height: _bannerAd.size.height.toDouble(),
                              width: _bannerAd.size.width.toDouble(),
                              child: AdWidget(ad: _bannerAd),
                            )
                          : SizedBox())
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
                    screen.width,
                    screen.height,
                    _model,
                    _interstitialAd,
                    _isAdLoaded,
                    flaglingua,
                    object)
              ],
            ),
    );
  }
}
