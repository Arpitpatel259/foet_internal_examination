// ignore_for_file: prefer_const_constructors_in_immutables
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CIADataPage extends StatefulWidget {
  final String enrollmentNumber;
  final String type;

  // ignore: use_key_in_widget_constructors
  CIADataPage(this.enrollmentNumber, this.type);

  @override
  _CIADataPageState createState() => _CIADataPageState();
}

class _CIADataPageState extends State<CIADataPage> {
  Map<String, dynamic> ciaData = {};
  List CIA_1_Key = [];

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://ciaapp.pythonanywhere.com/get_data/${widget.enrollmentNumber}/${widget.type}'));

    if (response.statusCode == 200) {
      final jsonString = response.body;
      final jsonData = json.decode(jsonString);
      debugPrint(jsonData.toString());
      setState(() {
        ciaData = jsonData;
        CIA_1_Key = ciaData["CIA_1"].keys.toList();
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              children: [
                TextSpan(
                  text: "FOET",
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                TextSpan(
                  text: " - CIA Data",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        // Transparent background
        elevation: 5,
        // No shadow
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.blue,
                Colors.blue,
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ciaData["CIA_1"] != 0
                ? Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ciaData.isNotEmpty
                        ? Text(
                            'Name :- ${ciaData["CIA_1"]["NAME"]} \nEnrollment :- ${widget.enrollmentNumber} \nSemester :- ${widget.type}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Container(),
                  )
                : Container(),
            ciaData["CIA_1"] != "0" || ciaData["CIA_2"] != "0"
                ? Expanded(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: ciaData.isEmpty
                          ? const Center(child: Text("No Data"))
                          : SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text('Subject')),
                                  DataColumn(label: Text('CIA 1')),
                                  DataColumn(label: Text('CIA 2')),
                                ],
                                rows: [
                                  for (int i = 3; i < CIA_1_Key.length; i++)
                                    DataRow(cells: [
                                      DataCell(Text(CIA_1_Key[i])),
                                      DataCell(Text(
                                          '${ciaData["CIA_1"][CIA_1_Key[i]]}')),
                                      DataCell(ciaData["CIA_2"] != 0
                                          ? Text(
                                              '${ciaData["CIA_2"][CIA_1_Key[i]]}')
                                          : const Text("0")),
                                    ]),
                                ],
                              ),
                            ),
                    ),
                  )
                : const Center(
                    child: Text("No Data Found"),
                  )
          ],
        ),
      ),
    );
  }
}
