import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fl_chart/fl_chart.dart';
import '../home/home.dart';
import '../home/text_section.dart';
import '../home/loading.dart';

class CountryPage extends StatefulWidget {
  final String countryName;
  final num point1, point2, point3, point4;
  CountryPage(
      this.countryName, this.point1, this.point2, this.point3, this.point4);

  @override
  _CountryPageState createState() => _CountryPageState(
      this.countryName, this.point1, this.point2, this.point3, this.point4);
}

class _CountryPageState extends State<CountryPage> {
  final String countryName;
  final num point1, point2, point3, point4;
  _CountryPageState(
      this.countryName, this.point1, this.point2, this.point3, this.point4);
  bool isSwitched = true;
  get maxY => (this.point4 >= this.point3) ? this.point4 : this.point3;
  get lineBarsIndex => (this.point4 >= this.point3) ? 1 : 0;
  get flIndex => (this.point4 >= this.point3) ? 1 : 2;

  String dayOfWeek(dynamic value) {
    switch (value) {
      case 2:
        return DateFormat('EEEE')
            .format(DateTime.now().toUtc())
            .substring(0, 3);
      case 1:
        return DateFormat('EEEE')
            .format(DateTime.now().toUtc().subtract(Duration(days: 1)))
            .substring(0, 3);
      default:
        return DateFormat('EEEE')
            .format(DateTime.now().toUtc().subtract(Duration(days: 2)))
            .substring(0, 3);
    }
  }

  @override
  Widget build(BuildContext context) {
    String rate;
    if (this.point4 > this.point3) {
      rate = "Decelerating";
    } else if (this.point4 == this.point3) {
      rate = "Stable";
    } else {
      rate = "Accelerating";
    }
    var lineBarsData = [
      LineChartBarData(spots: [
        FlSpot(0, this.point1),
        FlSpot(1, this.point2),
        FlSpot(2, this.point3)
      ]),
      LineChartBarData(
          dashArray: [5, 5],
          colors: [Colors.red[400]],
          spots: [FlSpot(1, this.point2), FlSpot(2, this.point4)])
    ];
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey[900],
            centerTitle: true,
            title: Text('CovTrack',
                style: TextStyle(
                    fontFamily: 'Dosis',
                    fontWeight: FontWeight.w700,
                    fontSize: 30.0,
                    letterSpacing: 1.25))),
        body: ListView(
          children: [
            CardPad(),
            CardPad(),
            Card(
              elevation: 100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: TextSection("COVID-19 in ${this.countryName}",
                  "Here are the up-to-date statistics for this country or region according to Worldometers."),
            ),
            CardPad(),
            Card(
                elevation: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Column(children: [
                  TextSection("Cases and Deaths", "",
                      size: 32.0,
                      size2: 0.0,
                      spacing: 3.0,
                      color: Colors.greenAccent,
                      padding2: const EdgeInsets.fromLTRB(16, 10, 16, 0)),
                  TextSection(dataTable[this.countryName][0], "Cases",
                      size: 29.0,
                      size2: 21.0,
                      spacing: 7.5,
                      color2: Colors.amberAccent,
                      padding: const EdgeInsets.fromLTRB(16, 15, 16, 4),
                      padding2: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      weight: FontWeight.bold),
                  TextSection(dataTable[this.countryName][1], "Deaths",
                      size: 29.0,
                      size2: 21.0,
                      spacing: 7.5,
                      color2: Colors.redAccent,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                      padding2: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      weight: FontWeight.bold),
                ])),
            CardPad(),
            Card(
                elevation: 25,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)),
                child: Column(
                  children: [
                    TextSection(
                      "At This Rate Of Increase, This Country Would Have",
                      "",
                      size: 24.0,
                      size2: 0.0,
                      color: Colors.greenAccent,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    ),
                    TextSection(intOf(this.point4.truncate().toString()),
                        "Cases By The End Of Today",
                        size: 29.0,
                        size2: 21.0,
                        spacing: 7.5,
                        color2: Colors.lightBlue[100],
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                        padding2: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        weight: FontWeight.bold),
                    TextSection(
                        (rate == "Decelerating" || rate == "Stable")
                            ? "Based On Current Stats, The Rate Is $rate. This Is Subject To Change As Time Progresses."
                            : "Based On Current Stats, The Rate Is $rate.",
                        "The Statistics Are Shown In The Graph Below (All Dates Are Based On Greenwich Mean Time)",
                        size: 23.0,
                        size2: 21.0,
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
                        weight: FontWeight.bold),
                  ],
                )),
            Column(
              children: [
                CardPad(),
                Divider(color: Colors.white),
                Padding(padding: EdgeInsets.only(top: isSwitched ? 30.0 : 0.0)),
                Center(
                  child: Card(
                    color: Color(0xff020227),
                    elevation: 50,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0)),
                    child: Padding(
                      padding:
                          const EdgeInsets.fromLTRB(22.0, 32.0, 46.0, 10.0),
                      child: LineChart(LineChartData(
                          minX: 0,
                          maxX: 2,
                          minY: this.point1,
                          maxY: maxY + 6,
                          borderData: FlBorderData(
                              border: Border.all(color: Colors.white)),
                          titlesData: FlTitlesData(
                              leftTitles: SideTitles(
                                  margin: 14.0,
                                  showTitles: true,
                                  interval: maxY + 6 - this.point1,
                                  getTitles: (dynamic value) {
                                    var formatter = NumberFormat.compact();
                                    return formatter.format(value);
                                  },
                                  getTextStyles: (value) {
                                    return TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontFamily: 'Dosis');
                                  }),
                              bottomTitles: SideTitles(
                                  margin: 20.0,
                                  getTitles: (dynamic value) {
                                    value = value.round();
                                    return dayOfWeek(value);
                                  },
                                  showTitles: true,
                                  getTextStyles: (value) {
                                    return TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontFamily: 'Dosis');
                                  })),
                          gridData: FlGridData(
                            horizontalInterval: (maxY + 6 - this.point1) / 6,
                            getDrawingHorizontalLine: (value) {
                              return FlLine(
                                  color: Colors.white, strokeWidth: 1.0);
                            },
                          ),
                          showingTooltipIndicators: isSwitched
                              ? [0, 1, 2].map((index) {
                                  if (index != 2) {
                                    return ShowingTooltipIndicators(index, [
                                      LineBarSpot(lineBarsData[0], 0,
                                          lineBarsData[0].spots[index])
                                    ]);
                                  } else {
                                    return ShowingTooltipIndicators(index, [
                                      LineBarSpot(
                                          lineBarsData[lineBarsIndex],
                                          lineBarsIndex,
                                          lineBarsData[lineBarsIndex]
                                              .spots[flIndex])
                                    ]);
                                  }
                                }).toList()
                              : null,
                          lineTouchData: LineTouchData(
                            enabled: false,
                            touchTooltipData: isSwitched
                                ? LineTouchTooltipData(
                                    tooltipBgColor: Color(0xff020236),
                                    tooltipRoundedRadius: 6.0,
                                    getTooltipItems: (values) {
                                      return values.map((value) {
                                        if (value.x != 2) {
                                          return LineTooltipItem(
                                              "${dayOfWeek(value.x.round())}: ${intOf(value.y.truncate().toString())}",
                                              TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Dosis'));
                                        } else {
                                          return LineTooltipItem(
                                              "${dayOfWeek(value.x.round())}: ${intOf(this.point3.truncate().toString())}\nPath: ${intOf(this.point4.truncate().toString())}",
                                              TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.0,
                                                  fontFamily: 'Dosis'));
                                        }
                                      }).toList();
                                    })
                                : null,
                          ),
                          lineBarsData: lineBarsData)),
                    ),
                  ),
                ),
                SwitchListTile(
                    title: CellText(
                        "Show Data Labels", 22.0, false, 1.0, TextAlign.left),
                    value: isSwitched,
                    onChanged: (value) {
                      setState(() {
                        isSwitched = value;
                      });
                    }),
                Padding(padding: EdgeInsets.only(top: isSwitched ? 24.0 : 0.0)),
                Divider(color: Colors.white),
              ],
            ),
          ],
        ));
  }
}

class CountryList extends StatelessWidget {
  final String search;
  CountryList([this.search]);

  @override
  Widget build(BuildContext context) {
    List<String> keys;
    if (search != null && search != "") {
      keys = dataTable.keys.toList();
      keys = keys.where((value) {
        return value
            .toLowerCase()
            .contains(RegExp(this.search.trim(), caseSensitive: false));
      }).toList();
    }
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.blueGrey[900],
          centerTitle: true,
          title: Text('CovTrack',
              style: TextStyle(
                  fontFamily: 'Dosis',
                  fontWeight: FontWeight.w700,
                  fontSize: 30.0,
                  letterSpacing: 1.25))),
      body: (keys != null && keys.length == 0)
          ? Column(
              children: [
                Divider(color: Colors.white),
                ListTile(
                    title: CellText(
                        "No Results For \'${toBeginningOfSentenceCase(this.search.toLowerCase())}\'",
                        28.0)),
                Divider(color: Colors.white)
              ],
            )
          : ListView.builder(
              itemCount: (keys != null) ? keys.length : dataTable.keys.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    (index == 0)
                        ? Column(
                            children: [
                              Divider(color: Colors.white),
                              ListTile(
                                  title: CellText(
                                      (keys != null)
                                          ? "Search Results For \'${toBeginningOfSentenceCase(this.search.toLowerCase())}\'"
                                          : "Country-By-Country Statistics",
                                      28.0)),
                              Divider(color: Colors.white)
                            ],
                          )
                        : Padding(padding: const EdgeInsets.only(top: 0.0)),
                    ListTile(
                        leading: CellText(
                            (keys != null)
                                ? "${dataTable.keys.toList().lastIndexOf(keys[index]) + 1}"
                                : "${index + 1}",
                            22.0),
                        title: CellText(
                            (keys != null)
                                ? '${keys[index]}'
                                : '${dataTable.keys.toList()[index]}',
                            22.0),
                        trailing: IconButton(
                            icon: Icon(Icons.arrow_right, size: 30.0),
                            padding: const EdgeInsets.only(left: 10.0),
                            onPressed: () {
                              try {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CountryPage(
                                            dataTable.keys.toList()[index],
                                            double.parse(
                                                dataTable[dataTable.keys.toList()[index]][4]
                                                    .replaceAll(",", "")),
                                            double.parse(
                                                dataTable[dataTable.keys.toList()[index]]
                                                        [2]
                                                    .replaceAll(",", "")),
                                            double.parse(
                                                dataTable[dataTable.keys.toList()[index]]
                                                        [0]
                                                    .replaceAll(",", "")),
                                            double.parse(dataTable[dataTable.keys.toList()[index]][2].replaceAll(",", "")) +
                                                (double.parse(dataTable[dataTable.keys.toList()[index]][2].replaceAll(",", "")) -
                                                    double.parse(dataTable[dataTable.keys.toList()[index]][4].replaceAll(",", ""))))));
                              } catch (e) {}
                            })),
                    Divider(color: Colors.white),
                  ],
                );
              }),
    );
  }
}
