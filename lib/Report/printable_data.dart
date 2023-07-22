import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

buildPrintableData(int i, int j, int k, int m, int n, String username, Map datascore, image, String textreview, double pos, double neg, String AvgUsage) =>
    pw.Container(
      decoration: pw.BoxDecoration(
          borderRadius: pw.BorderRadius.circular(20),
          color: PdfColor.fromInt(0xffffffff),
          boxShadow: const [
            pw.BoxShadow(
              blurRadius: 2,
            )
          ]),
      padding: const pw.EdgeInsets.all(18.0),
      margin: const pw.EdgeInsets.all(18.0),
      child: pw.Column(
        children: [
          pw.Text(
            'Intelligent Learning for preschoolers',
            style: pw.TextStyle(fontSize: 20),
          ),
          pw.SizedBox(height: 15),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Column(
                children: [
                  pw.Text(DateFormat("hh:mm:ss a").format(DateTime.now())),
                  pw.Text(DateFormat("dd-MM-yyyy").format(DateTime.now())),
                  pw.SizedBox(height: 10,),
                  pw.Text("Welcome"),
                  pw.Text("Attention to: $username"),
                ],
                crossAxisAlignment: pw.CrossAxisAlignment.start,
              ),
              pw.SizedBox(
                height: 150,
                width: 150,
                child: pw.Image(image),
              )
            ],
          ),
          pw.SizedBox(height: 15),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColor.fromInt(0xff000000)),
            children: [
              pw.TableRow(
                children: [
                  pw.Padding(
                    child: pw.Text(
                      'Question Type',
                      textAlign: pw.TextAlign.center,
                    ),
                    padding: pw.EdgeInsets.all(20),
                  ),
                  pw.Padding(
                    child: pw.Text(
                      'SCORE',
                      textAlign: pw.TextAlign.center,
                    ),
                    padding: pw.EdgeInsets.all(20),
                  ),
                ],
              ),
              ...datascore.entries.map(
                    (e) => pw.TableRow(
                  children: [
                    pw.Expanded(
                      child: PaddedText(e.key),
                      flex: 2,
                    ),
                    pw.Expanded(
                      child: PaddedText(e.value.toString()),
                      flex: 1,
                    )
                  ],
                ),
              ),
              pw.TableRow(
                children: [
                  PaddedText('TOTAL', align: pw.TextAlign.right),
                  PaddedText('${i + j + k + m + n} from 500')
                ],
              )
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Divider(
            height: 1,
            thickness: 3,
            borderStyle: pw.BorderStyle.solid,
          ),
          pw.Container(height: 30),
          pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.start,
              children: [
                pw.Text('Application Rating and calc AvgUsage', style: pw.TextStyle(fontSize: 20),),
              ]
          ),
          pw.SizedBox(height: 15),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColor.fromInt(0xff000000)),
            children: [
              pw.TableRow(
                children: [
                  PaddedText('Review Text'),
                  PaddedText(
                    textreview,
                  )
                ],
              ),
              pos>=neg?
              pw.TableRow(
                children: [
                  PaddedText(
                    'Happy',
                  ),
                  PaddedText(
                    pos.toStringAsFixed(2),
                  )
                ],
              ):
              pw.TableRow(
                children: [
                  PaddedText(
                    'Sad',
                  ),
                  PaddedText(neg.toStringAsFixed(2))
                ],
              ),
              pw.TableRow(
                children: [
                  PaddedText('Average usage'),
                  PaddedText(AvgUsage)
                ],
              )
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text(
            'THANK YOU FOR USING THE APP.',
            textAlign: pw.TextAlign.center,
          ),
        ],
      ),
    );

pw.Widget PaddedText(
    final String text, {
      final pw.TextAlign align = pw.TextAlign.left,
    }) =>
    pw.Padding(
      padding: pw.EdgeInsets.all(10),
      child: pw.Text(
        text,
        textAlign: align,
      ),
    );
