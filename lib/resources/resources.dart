import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart' as url;
import '../home/text_section.dart';
import '../home/menu.dart';

class Resources extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'CovTrack',
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blueGrey[900],
              centerTitle: true,
              title: Text('Resources',
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
                Card(
                  elevation: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      TextSection("Data Sources", "",
                          size: 28.0,
                          size2: 0.0,
                          color: Colors.deepOrangeAccent[100]),
                      LinkText(
                          "Global Statistics: ", "https://covid19.who.int/"),
                      LinkText("Country Statistics: ",
                          "https://www.worldometers.info/coronavirus/")
                    ],
                  ),
                ),
                CardPad(),
                Card(
                  elevation: 100,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  child: Column(
                    children: [
                      TextSection("Trusted COVID-19 Info Sources", "",
                          size: 28.0,
                          size2: 0.0,
                          color: Colors.amberAccent[100]),
                      LinkText("Centers For Disease Control And Prevention: ",
                          "https://www.cdc.gov/coronavirus/"),
                      LinkText("National Institutes Of Health: ",
                          "https://covid19.nih.gov/news/"),
                      LinkText("World Health Organization: ",
                          "https://www.who.int/emergencies/diseases/novel-coronavirus-2019/"),
                    ],
                  ),
                ),
              ],
            ),
            drawer: Menu("resources")),
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            brightness: Brightness.dark));
  }
}

class LinkText extends StatelessWidget {
  final String prefix, link;
  LinkText(this.prefix, this.link);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(children: [
        WidgetSpan(child: Center(child: CellText(this.prefix, 24.0))),
        WidgetSpan(
            child: InkWell(
                child: TextSection(this.link, "",
                    spacing: 1.0,
                    size2: 0.0,
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                    color: Colors.cyan[300],
                    decoration: TextDecoration.underline),
                onTap: () => url.launch(this.link)))
      ]),
    );
  }
}