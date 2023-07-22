import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:intelligent_learning/Report/dataChart.dart';
import 'package:intelligent_learning/Report/printable_data.dart';
import 'package:pdf/pdf.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

class Charts extends StatefulWidget {

  @override
  State<Charts> createState() => _ChartsState();
}

class _ChartsState extends State<Charts> {
  static int i = 0, j = 0, k = 0, m = 0, n = 0;
  int index = 0;
  List? list2;
  String appBarText = 'bar graph';
  Map<String, double> datascore = {};
  CollectionReference userref = FirebaseFirestore.instance.collection('users');
  List users = [];
  @override
  void initState() {
    calcScore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List title = [
      '  bar graph  ',
      'doughnut chart',
      '    report    ',
    ];

    datascore = {
      "Choose": i.toDouble(),
      "Complete": j.toDouble(),
      "Match": k.toDouble(),
      "Listen": m.toDouble(),
      "Read": n.toDouble(),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText),
        centerTitle: true,
      ),
      bottomNavigationBar: GNav(
        rippleColor: Colors.grey.shade800, // tab button ripple color when pressed
        hoverColor: Colors.grey.shade700, // tab button hover color
        haptic: true, // haptic feedback
        tabBorderRadius: 15,
        tabActiveBorder: Border.all(color: Colors.black, width: 1), // tab button border
        tabBorder: Border.all(color: Colors.grey, width: 1), // tab button border
        tabShadow: [ BoxShadow(color: Colors.grey.withOpacity(0.5), blurRadius: 8)], // tab button shadow
        curve: Curves.easeInOutQuart, // tab animation curves
        gap: 8, // the tab button gap between icon and text
        color: Colors.grey[800], // unselected icon color
        activeColor: Colors.purple, // selected icon and text color
        iconSize: 24, // tab button icon size
        tabBackgroundColor: Colors.purple.withOpacity(0.1), // selected tab background color
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: 5), //h 25
        onTabChange: (index) {
          this.index = index;
          appBarText = title[index];
          setState(() {});
        },
        tabs: [
          GButton(
            icon: Icons.bar_chart,
            text: title[index],
          ),
          GButton(
            icon: Icons.pie_chart,
            text: title[index],
          ),
          GButton(
            icon: Icons.report_gmailerrorred,
            text: title[index],
          ),
        ],
      ),
      body: showing(i, j, k, m, n),
    );
  }

  Widget showing(int i, int j, int k, int m, int n) {
    List<Color> color = [
      Colors.red,
      Colors.blueGrey,
      Colors.green,
      Colors.orange,
      Colors.indigo,
    ];
    switch (index) {
      case 0:
        int indexColorBar = 0;
        List<BarChartModel> data = [
          ...datascore.entries.map(
            (e) => BarChartModel(
              questionType: e.key,
              score: e.value.toInt(),
              color: charts.ColorUtil.fromDartColor(
                  color[(indexColorBar++) % color.length]),
            ),
          ),
        ];
        List<charts.Series<BarChartModel, String>> series = [
          charts.Series(
            id: "score",
            data: data,
            domainFn: (BarChartModel series, _) => series.questionType,
            measureFn: (BarChartModel series, _) => series.score,
            colorFn: (BarChartModel series, _) => series.color,
          ),
        ];
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
          child: charts.BarChart(
            series,
            animate: true,
          ),
        );

      case 1:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: PieChart(
                  dataMap: datascore,
                  chartType: ChartType.ring,
                  colorList: color,
                  baseChartColor: Colors.grey.withOpacity(0.15),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValuesInPercentage: true,
                  ),
                  totalValue: i + j + k + m + n.toDouble(),
                ),
              ),
            ],
          ),
        );

      case 2:
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: printDoc,
            child: Icon(Icons.picture_as_pdf),
          ),
          body: makePDF(),
        );

      default:
        return CircularProgressIndicator();
    }
  }

  calcScore() async {
    List<int> Ques1 = [], Ques2 = [], Ques3 = [], Ques4 = [], Ques5 = [];
    users=[];

    var response = await userref.where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    response.docs.forEach((element) {
      users.add(element.data());
    });

    for (int i = 0; i < users[0]['scores'].length; i += 5) {
      Ques1.add(users[0]['scores'][i]);
    }
    for (int i = 1; i < users[0]['scores'].length; i += 5) {
      Ques2.add(users[0]['scores'][i]);
    }
    for (int i = 2; i < users[0]['scores'].length; i += 5) {
      Ques3.add(users[0]['scores'][i]);
    }
    for (int i = 3; i < users[0]['scores'].length; i += 5) {
      Ques4.add(users[0]['scores'][i]);
    }
    for (int i = 4; i < users[0]['scores'].length; i += 5) {
      Ques5.add(users[0]['scores'][i]);
    }
    setState(() {
      i = Ques1.fold(0, (p, c) => p + c);
      j = Ques2.fold(0, (p, c) => p + c);
      k = Ques3.fold(0, (p, c) => p + c);
      m = Ques4.fold(0, (p, c) => p + c);
      n = Ques5.fold(0, (p, c) => p + c);
    });
  }

  Widget makePDF() {
    return users.length == 0 ? Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.9),
            boxShadow: const [
              BoxShadow(
                blurRadius: 2,
              )
            ]),
        padding: const EdgeInsets.all(18.0),
        margin: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Text(
              'Intelligent Learning for preschoolers',
              style: TextStyle(fontSize: MediaQuery.of(context).size.width/21.8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(DateFormat("hh:mm:ss a").format(DateTime.now())),
                    Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
                    SizedBox(height: 10,),
                    Text("Welcome"),
                    Text("Attention to: ${users[0]['username'] }"),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                ),
                SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.asset('assets/image/icon/login.png'),
                )
              ],
            ),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      child: Text(
                        'Question Type',
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                    Padding(
                      child: Text(
                        'SCORE',
                        textAlign: TextAlign.center,
                      ),
                      padding: EdgeInsets.all(20),
                    ),
                  ],
                ),
                ...datascore.entries.map(
                  (e) => TableRow(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${e.key}',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            flex: 2,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text(
                                '${e.value.toInt().toString()}',
                                textAlign: TextAlign.left,
                              ),
                            ),
                            flex: 1,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'TOTAL',
                        textAlign: TextAlign.right,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        '${i + j + k + m + n} from 500',
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              thickness: 5,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text("Application Rating",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Review Text',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['review'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                users[0]['positive']>=users[0]['negative']?
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Happy',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['positive'].toStringAsFixed(2),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ):
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Sad',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['negative'].toStringAsFixed(2),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              thickness: 5,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text("Average usage of the app",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Average usage',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['AvgUsage'].split('.').first,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Divider(
              height: 1,
              thickness: 5,
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Text("Account Info",
                  textAlign: TextAlign.left, style: TextStyle(fontSize: 20)),
            ),
            SizedBox(height: 10),
            Table(
              border: TableBorder.all(color: Colors.black),
              children: [
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Account Name',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['username'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Account E-mail',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['email'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Gender',
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        users[0]['gender'],
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),

              ],
            ),
            Padding(
              child: Text(
                "THANK YOU FOR USING THE APP.",
              ),
              padding: EdgeInsets.only(top: 18),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> printDoc() async {
    final image = await imageFromAssetBundle(
      "assets/image/icon/login.png",
    );
    final doc = pw.Document();
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return buildPrintableData(i, j, k, m, n, users[0]['username'], datascore, image, users[0]['review'], users[0]['positive'], users[0]['negative'], users[0]['AvgUsage'].split('.').first);
        }));
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
  }
}
