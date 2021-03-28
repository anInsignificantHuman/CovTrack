import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../home/menu.dart';
import '../home/text_section.dart';

class QCard extends StatelessWidget {
  final text1, text2, color;
  QCard(this.text1, this.text2, this.color);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 100,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: TextSection(this.text1, this.text2, color: this.color),
    );
  }
}

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CovTrack',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[900],
              centerTitle: true,
              title: Text('Info',
                  style: TextStyle(
                      fontFamily: 'Dosis',
                      fontWeight: FontWeight.w700,
                      fontSize: 30.0,
                      letterSpacing: 1.25)),
            ),
            body: ListView(
              children: [
                CardPad(),
                CardPad(),
                QCard(
                    "What Is COVID-19?",
                    "Coronavirus Disease 2019, COVID-19, or simply coronavirus is a disease caused by the SARS-CoV-2 virus. It has resulted in the current coronavirus pandemic. This app reports current statistics on the pandemic.",
                    Colors.greenAccent),
                CardPad(),
                QCard(
                    "What Are The Symptoms?",
                    "Of course, different people will have different symptoms. However, common symptoms include coughing, shortness of breath, muscle pains, loss of taste or smell, congestion, and fatigue. If you have any of these symptoms, immediately find a COVID-19 testing site near you.",
                    Colors.deepOrangeAccent[100]),
                CardPad(),
                QCard(
                    "What Are The Precautions I Should Take?",
                    "Make sure to wash your hands regularly and thoroughly. Stay inside as much as possible, too. If outside, stay 6 feet or 2 meters away from others and wear a mask. These steps will ensure your safety.",
                    Colors.lightBlueAccent[100]),
                CardPad(),
                QCard(
                    "Is There A Cure For This Disease?",
                    "As of now, there is no known cure for COVID-19. However, COVID-19 vaccines are being manufactured now. It is recommended that, if you are eligible and have access to them, you get a COVID-19 vaccine as soon as possible.",
                    Colors.amberAccent[100]),
                CardPad(), 
                QCard(
                    "Where Else Can I Find Info On COVID-19?",
                    "In the CovTrack \"Resources\" tab, you will find links to trusted online medical sources, as well as this app's data sources. Otherwise, you can always consult with your healthcare provider.",
                    Colors.purple[100])
              ],
            ),
            drawer: Menu("info")),
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark));
  }
}