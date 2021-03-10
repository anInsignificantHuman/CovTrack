import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as html;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home.dart';

http.Client client;
String intOf(number) {
  try {
    var defaultLocalizations = DefaultMaterialLocalizations();
    return defaultLocalizations.formatDecimal(int.parse(number));
  } catch (e) {
    return "N/A";
  }
}

class GlobalLoading extends StatefulWidget {
  @override
  _GlobalLoadingState createState() => _GlobalLoadingState();
}

class _GlobalLoadingState extends State<GlobalLoading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(  
      title: 'CovTrack',
      home: GlobalLoadScreen(), 
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,  
        brightness: Brightness.dark
      )
    );
  }
}

class GlobalLoadScreen extends StatefulWidget {
  @override
  _GlobalLoadScreenState createState() => _GlobalLoadScreenState();
  GlobalLoadScreen() {
    if (client != null) {  
      client.close();
    }
    client = http.Client();
  }
}

class _GlobalLoadScreenState extends State<GlobalLoadScreen> {
  Future<void> getData() async {
    print("A");
    Stopwatch stopwatch = Stopwatch()..start();
    http.Response response = await client.get("https://covid19.who.int/");
    var document = html.parse(response.body);
    var text = document.querySelector("p").text;
    var matches = RegExp(r"[\d,]+").allMatches(text);
    List finalMatches = [];
    for (var element in matches) {
      finalMatches.add(element.group(0));
    }
    finalMatches = finalMatches.sublist(6);
    List totals = [finalMatches[0], finalMatches[2]];
    response = await client.get("https://www.worldometers.info/coronavirus/");
    document = html.parse(response.body);
    List links = document.querySelectorAll("a[href^=\"country/\"]");
    List rows = [
      for (var link in links) 
        link.parent.parent
    ];
    List children = [for (var row in rows) row.children];
    List elements = [
      for (var ls in children)
        [
          for (var el in ls)
            if (el.text != "\n") 
              el.text
        ]
    ];
    elements = [
      for (var element in elements)
        [
          element[1].trim(),
          intOf(element[2].trim().replaceAll(",", "")),
          intOf(element[4].trim().replaceAll(",", ""))
        ]
    ];
    elements.sort((a, b) => int.parse(a[1].replaceAll(",", ""))
      .compareTo(int.parse(b[1].replaceAll(",", ""))));
    elements = List.from(elements.reversed);
    Map<String, List> table = Map();
    for (var element in elements) {
      if (!table.containsKey(element[0])) {
        table[element[0]] = element.sublist(1);
      } else {
        table[element[0]].addAll(element.sublist(1));
      }
    }
    Navigator.push(
      context, LoadRoute(builder: (context) => Home(totals[0], totals[1], table))
    );
    print("process finished in ${stopwatch.elapsed}");
  }

  @override 
  void initState() { 
    super.initState(); 
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(  
      appBar: AppBar(
        backgroundColor: Colors.blueGrey[900],
        centerTitle: true,
        title: Text(
          'CovTrack',
          style: TextStyle(
            fontFamily: 'Dosis',
            fontWeight: FontWeight.w700,
            fontSize: 30.0,
            letterSpacing: 1.25
          )
        )
      ),
      body: Column(  
        mainAxisAlignment: MainAxisAlignment.center, 
        crossAxisAlignment: CrossAxisAlignment.center, 
        children: [  
          SpinKitPouringHourglass(  
            color: Colors.white, 
            size: 80.0
          )
        ]
      )
    );
  }
}