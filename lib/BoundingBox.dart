import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_mobile_ads/google_mobile_ads.dart';

class BoundingBox extends StatelessWidget {
  final List<dynamic> results;
  final int previewH;
  final int previewW;
  final double screenH;
  final double screenW;
  final String model;
  final InterstitialAd _interstitialAd;
  final bool _isAdLoaded;
  final int flaglingua;
  final Map object;

  List<String> emissions = ["CO2 EMISSIONS:", "EMISSIONI DI CO2:"];
  List<String> tips = [
    "TIPS ON HOW TO REDUCE UR IMPACT:",
    "CONSIGLI SU COME RIDURRE IL TUO IMPATTO:"
  ];
  List<String> description = [
    "humanity in 2020 emitted 35 billion tons of co2",
    "the bicycle has no particular co2 emissions other than those for its production",
    "the average CO2 consumption of a car is about 120g / km considering an average of 11000 kilometers the annual CO2 emission of a car is 1320Kg",
    "the average consumption of co2 of a motorcycle is about 80g / km considering an average of 11000 kilometers the annual emission of co2 of a motorcycle is 880Kg",
    "the aviation sector produces about 2% of the co2 emissions on the planet",
    "the bus is one of the best means of transport for CO2 emissions per passenger",
    "the train is one of the best means of transport for CO2 emissions per passenger",
    "the average CO2 consumption of a truck is about 160g / km considering an average of 150,000 km the annual CO2 emission of a truck is 24000kg transport of goods onroad emits 72% of co2 in the sector",
    "47 cruise ships emit 10 times more than all cars in europe, general co2 emissions from ships are around 4-5%",
    "this thing doesn't emit co2 particularly",
    "these animals if grown intensively produce co2 emissions, intensive farming emits 6% total gas emissions every year",
    "a plastic bottle takes 450 years to degrade",
    "A laptop uses between 50 and 100 W/hour when it is being used, depending on the model. A laptop that is on for eight hours a day emits between 44 and 88kgof CO2 per year",
    "to charge the mobile phone, an average of 400g of co2 is emitted every year",
    "a refrigerator emits an average of 104 kg of co2 per year, incorrect recycling causes serious problems for the environment",
    "a hairdryer emits an average of 9kg of co2 per year",
    "agricultural production and livestock production emit 20% of the greenhouse gases of the total ones",
    "an average TV emits 22kg of co2 every year"
  ];
  List<String> advice = [
    "use the tips of reduce ur impact",
    "prefer the use of bicycles as much as possible over the use of cars and motorcycles, especially for short-term journeys",
    "prefer public transport and bicycles to a car when possible, in case it is not possible consider purchasing an electric car",
    "prefer public transport and bicycles to a motorcycle when possible, in case it is not possible  consider the purchase of an electric scooter",
    "for short trips prefer to use less polluting trains and means of transport",
    "when possible, it is better to move on foot or by bicycle than by bus",
    "when possible, is better to move on foot or by bicycle than by train",
    "if possible, consume products transported by more eco-sustainable trains and vehicles",
    "do not go on holidays on cruise ships and consume products transported in an eco-sustainable way",
    "no tip is needed",
    "consume meat and derivatives that are not produced in intensive farming",
    "consume water and soft drinks in glass bottles",
    "Switch off your computer or put it in stand-by mode if you are not going to work on your PC for more than 30 minutes. A multiple socket makes it easy to switch off all your computing equipment.",
    "do not leave the mobile phone charging when not needed",
    "properly recycle the refrigerator",
    "use the hair dryer as little as possible",
    "eat locally produced food as much as possible and decrease the consumption of meat and fish",
    "turn off the tv when you are not watching it"
  ];
  List<String> descrizioni = [
    "l'umanita nel 2020 ha emesso 35 miliardi di tonnellate di co2",
    "la bicicletta non ha particolare emissioni di co2 oltre a quelli per la sua produzione",
    "il consumo medio di co2 di una macchina è di circa 120g/km considerando una media di 11000 chilometri l'emissione annua di co2 di una macchina è di 1320Kg",
    "il consumo medio di co2 di una moto è di circa 80g/km considerando una media di 11000 chilometri l'emissone annua di co2 di una motocicletta è di 880Kg",
    "il settore aereo produce circa 2% delle emizziosi di co2 nel pianeta",
    "il bus è uno dei migliori mezzi di trasporto per emissione di co2 per passeggero",
    "il treno  è uno dei migliori mezzi di trasporto per emission di co2 per passeggero",
    "il consumo medio  di co2 di un camion è di circa 160g/km considerando una media di 150000 km l'emissione annua di di co2 di un camion è di 24000kg il trasporto merci su strada emette il 72% di co2 nel settore",
    "47 navi da crociera emettono 10 volte di più di tutte le auto d'europa, le emissioni di co2 generali dovute alle navi si attestano attorno al 4-5% ",
    "questa cosa non emette co2 particolarmente",
    "questi animali se allevati in maniera intensiva producono emissioni di co2, l'allevamento intensivo emette il 6% totale di emissioni di gas ogni anno",
    "una bottiglia di plastica per degradarsi ci mette 450 anni",
    "Un laptop consuma tra 50 e 100 W/ora quando viene utilizzato, a seconda del modello. Un laptop acceso per otto ore al giorno emette tra i 44 e gli 88 kgdi CO2 all'anno",
    "per caricare il cellulare in media vengono emessi 400g di co2 per ogni anno",
    "un frigorifero emette in media 104 kg di co2 per ogni anno, l'errato riciclo causa seri problemi all'ambiente",
    "un asciugacapelli emette in media 9kg di co2 per ogni anno",
    "la produzione agricola e gli allevamenti emettono il 20% dei gas serra di quelle totali",
    "una tv mediamente emette ogni anno 22kg di co2"
  ];
  List<String> consigli = [
    "usare i consigli di reduce ur impact",
    "preferire il piu possibile l'utilizzo della bicicletta rispetto all'uso di autombili e motociclette sopratutto per tragitti di breve periodo",
    "preferire i mezzi di trasporto pubblici e biciclette ad una macchina quando possibile, nel caso non sia possibile considerare l'acquisto di una macchina elettrica",
    "preferire i mezzi di trasporto pubblici e biciclette ad una moto quando possibile, nel caso non sia possibile considerare l'acquisto di uno scooter elettrico",
    "per viaggi brevi preferire l'utilizzo di treni e mezzi di trasporto meno inquinanti",
    "quando possibile meglio muoversi a piedi o in bicicletta rispetto al bus",
    "quando possibile meglio muoversi a piedi o in bicicletta rispetto al treno",
    "se possibile consumare prodotti trasportati da treni e mezzi piu ecosostenibili",
    "non andare a fare vacanze in navi da crociera e consumare prodotti trasportati in maniera ecosostenibile",
    "non serve nessun consiglio",
    "consumare carne e derivati che non siano prodotti in allevamenti intensivi",
    "consumare acqua e bibite in bottiglie in vetro",
    "Spegni il computer o mettilo in modalità stand-by se non lavorerai sul PC per più di 30 minuti. Una presa multipla lo rende facile spegni tutte le tue apparecchiature informatiche",
    "non lasciare il cellulare in ricarica quando non serve",
    "riciclare in modo corretto il frigorifero",
    "usare il meno possibile l'asciugacapelli",
    "mangiare il piu possibile cibo di produzione locale e diminuire il consumo di carne e pesce",
    "spegnere la tv quando non la si guarda"
  ];
  BoundingBox(
      this.results,
      this.previewH,
      this.previewW,
      this.screenH,
      this.screenW,
      this.model,
      this._interstitialAd,
      this._isAdLoaded,
      this.flaglingua,
      this.object);

  @override
  Widget build(BuildContext context) {
    List<Widget> _renderBoxes() {
      return results.map((re) {
        var _x = re["rect"]["x"];
        var _w = re["rect"]["w"];
        var _y = re["rect"]["y"];
        var _h = re["rect"]["h"];
        var x, y, w, h;

        x = _x * previewW;
        x = x - x / 2.7;
        y = _y * previewH;
        y = y - y / 2.7;

        w = _w * previewW;
        w = w - w / 2.7;
        h = _h * previewH;
        h = h - h / 2.7;

        var titolo;
        var emission;
        var tip;

        if (flaglingua == 1) {
          titolo = object[re["detectedClass"]][0];
          emission = descrizioni[object[re["detectedClass"]][1]];
          tip = consigli[object[re["detectedClass"]][1]];
        } else {
          titolo = re["detectedClass"];
          emission = description[object[re["detectedClass"]][1]];
          tip = advice[object[re["detectedClass"]][1]];
        }
        return Positioned(
            left: math.max(0, x),
            top: math.max(0, y),
            width: w,
            height: h,
            child: GestureDetector(
              onTap: () {
                if (_isAdLoaded) {
                  _interstitialAd.show();
                }

                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          backgroundColor: Color(0xFF8FD5A6),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          content: SingleChildScrollView(
                              child: Column(
                            children: <Widget>[
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                titolo.toUpperCase(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF054E48),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(emissions[flaglingua],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF0C8346),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    )),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                child: Text(emission,
                                    style: TextStyle(
                                        color: Color(0xFF329F5B),
                                        fontSize: 15.0)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(tips[flaglingua],
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Color(0xFF0C8346),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15.0,
                                    )),
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Container(
                                child: Text(tip,
                                    style: TextStyle(
                                        color: Color(0xFF329F5B),
                                        fontSize: 15.0)),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                child: Text(
                                  "tap outside the box to close",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF054E48),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ));
              },
              child: Container(
                padding: EdgeInsets.only(left: 5, top: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFF8FD5A6),
                    width: 2,
                  ),
                ),
                child: Text(
                  "${titolo} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
                  style: TextStyle(
                    color: Color(0xFF8FD5A6),
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ));
      }).toList();
    }

    return Stack(
      children: _renderBoxes(),
    );
  }
}
