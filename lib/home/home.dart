import 'int'
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fl_chart/fl_chart.dart';
import 'menu.dart';
import 'text_section.dart';
import 'loading.dart';

String whoCases, whoDeaths;
Map<String, List> dataTable;

class Home extends StatefulWidget {
  final String whoCases, whoDeaths;
  final Map dataTable;
  Home([this.whoCases, this.whoDeaths, this.dataTable]);

  @override
  _HomeState createState() => _HomeState(whoCases, whoDeaths, dataTable);
}

class _HomeState extends State<Home> {
  final String result1, result2;
  final Map countries;
  _HomeState([this.result1, this.result2, this.countries]);

  @override  
  void initState() {  
    super.initState(); 
    setState(() {
      whoCases = this.result1;
      whoDeaths = this.result2;
      dataTable = this.countries;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CovTrack',
      home: Scaffold(
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
        body: ListView(
          children: [
            SearchBar(),
            CardPad(),
            Card(     
              elevation: 100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: TextSection(
                "Keep Track of The Pandemic", 
                "In these times, it's important to keep updated on the situation. Get live stats on the ongoing COVID-19 pandemic here."
              ),
            ),
            CardPad(),
            Card(
              elevation: 25,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)
              ),
              child: Column(
                children: [
                  TextSection(
                    "Global Statistics", 
                    "These are the worldwide statistics for the coronavirus according to The World Health Organization.", 
                    size: 32.0,
                    size2: 20.0, 
                    spacing: 3.0,
                    color: Colors.greenAccent, 
                    padding2: const EdgeInsets.fromLTRB(16, 10, 16, 0)
                  ),
                  TextSection(
                    whoCases, 
                    "Cases", 
                    size: 29.0,
                    size2: 21.0, 
                    spacing: 7.5, 
                    color2: Colors.amberAccent, 
                    padding: const EdgeInsets.fromLTRB(16, 15, 16, 4), 
                    padding2: const EdgeInsets.fromLTRB(16, 0, 16, 16), 
                    weight: FontWeight.bold
                  ),
                  TextSection(
                    whoDeaths, 
                    "Deaths", 
                    size: 29.0,
                    size2: 21.0,
                    spacing: 7.5,  
                    color2: Colors.redAccent, 
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                    padding2: const EdgeInsets.fromLTRB(16, 0, 16, 16), 
                    weight: FontWeight.bold 
                  ), 
                  TextButton(
                    child: TextSection(  
                      "COVID-19 Stats By Country", 
                      "", 
                      size: 23.0,
                      size2: 0.0,
                      color: Colors.lightBlue[50],
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4), 
                      decoration: TextDecoration.underline
                    ),
                    onPressed: () {
                      Navigator.push(  
                        context, MaterialPageRoute(
                          builder: (context) => CountryList()
                        )
                      );
                    },
                  )
                ]
              )
            ),
            Padding(  
              padding: const EdgeInsets.only(  
                top: 20.0
              )
            ),
            Center(
              child: Card(
                shape: RoundedRectangleBorder( 
                  borderRadius: BorderRadius.circular(18.0)
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 16.0, 20.0, 0.0),
                  child: LineChart(
                    LineChartData(  
                      minX: 0,
                      maxX: 2,
                      minY: 40000000, 
                      maxY: 60000000,
                      borderData: FlBorderData(
                        border: Border.all(
                          color: Colors.white
                        )
                      ),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(  
                          showTitles: true, 
                          interval: 20000000 / 2,
                          getTextStyles: (value) {
                            return TextStyle(  
                              color: Colors.white, 
                              fontSize: 15.0, 
                              fontFamily: 'Dosis'  
                            );
                          }
                        ), 
                        bottomTitles: SideTitles(  
                          getTitles: (dynamic value) {
                            value = value.round();
                            switch (value) {
                              case 0:
                                return DateFormat()
                              case 1: 
                                return 'Yesterday'; 
                              case 2: 
                                return 'Today';
                            }
                          },
                          showTitles: true, 
                          getTextStyles: (value) {
                            return TextStyle(  
                              color: Colors.white, 
                              fontSize: 15.0, 
                              fontFamily: 'Dosis'  
                            );
                          }
                        )
                      ),
                      gridData: FlGridData(
                        horizontalInterval: 20000000 / 6, 
                        getDrawingHorizontalLine: (value) {
                          return FlLine(
                            color: Colors.white, 
                            strokeWidth: 1.0
                          );
                        },
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: [
                            FlSpot(0, 40004760), 
                            FlSpot(1, 51060609), 
                            FlSpot(2, 60000000)
                          ]
                        )
                      ]
                    )
                  ),
                ),
              ),
            )
          ]
        ),
        drawer: Menu("home"), 
        floatingActionButton: RefreshButton()
      ),
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark
      )
    );
  }
}

class CountryList extends StatelessWidget {
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
      body: ListView.builder(  
        itemCount: dataTable.keys.length, 
        itemBuilder: (context, index) {
          return Column(
            children: [
              Divider(  
                color: Colors.white
              ),
              ListTile( 
                leading: CellText("${index + 1}", 22.0),
                title: CellText('${dataTable.keys.toList()[index]}', 22.0),
                trailing: IconButton(
                  icon: Icon(
                    Icons.arrow_right, 
                    size: 30.0
                  ),
                  padding: const EdgeInsets.only(  
                    left: 10.0
                  ), 
                  onPressed: () {}
                ) 
              ),
            ],
          );
        }
      ),
    );
  }
}

class RefreshButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => Navigator.push(  
        context, LoadRoute(builder: (context) => GlobalLoading())
      ),
      child: Icon(
        Icons.refresh, 
        color: Colors.white
      ), 
      backgroundColor: Colors.blueGrey[900]
    );
  }
}

class LoadRoute extends MaterialPageRoute {
  final builder;

  LoadRoute({@required this.builder}) : super(builder: builder);

  @override  
  Duration get transitionDuration => const Duration(milliseconds: 0);
}

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final controller = TextEditingController();

  @override 
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller, 
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search, 
          size: 26.0
        ),
        suffixIcon: IconButton(
          onPressed: () => controller.clear(),
          icon: Icon(
            Icons.send,
            size: 18.0
          )
        ),
        labelText: "Search for a country"
      )
    );
  }
}