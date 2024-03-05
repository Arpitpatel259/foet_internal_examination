// ignore_for_file: prefer_const_constructors_in_immutables, avoid_unnecessary_containers
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CIA_Marks extends StatefulWidget {
  final String enrollmentNumber;
  final String type;

  // ignore: use_key_in_widget_constructors
  CIA_Marks(this.enrollmentNumber, this.type);

  @override
  State<CIA_Marks> createState() => _CIA_MarksState();
}

class _CIA_MarksState extends State<CIA_Marks> {
  Map<String, dynamic> ciaData = {};
  List cia1Key = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  /*Fetch Student CIA 1 and 2 Data*/
  Future<void> fetchData() async {
    isLoading = true;
    final response = await http.get(Uri.parse(
        'https://ciaapp.pythonanywhere.com/get_data/${widget.enrollmentNumber}/${widget.type}'));

    if (response.statusCode == 200) {
      final body = response.body;

      debugPrint(json.toString());

      setState(() {
        ciaData = jsonDecode(body);
        debugPrint("CIA-DATA -- ${ciaData["CIA_1"]}");

        if (ciaData["CIA_1"] != 0) {
          isLoading = false;
          cia1Key = ciaData["CIA_1"].keys.toList();
          debugPrint("IF PART $cia1Key");
        } else {
          isLoading = false;
          cia1Key = [0];
          debugPrint("ELSE PART $cia1Key");
        }
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    num totalCiaMarks1 = 0;
    num totalCiaMarks2 = 0;

    // Calculate the sum of CIA marks for each subject
    for (int i = 3; i < cia1Key.length; i++) {
      // Check if CIA_1 and CIA_2 data is available and not null
      if (ciaData["CIA_1"][cia1Key[i]] != null) {
        if (ciaData["CIA_1"][cia1Key[i]] == "AB") {
          totalCiaMarks1 += 0;
        } else {
          totalCiaMarks1 += ciaData["CIA_1"][cia1Key[i]];
        }
      }
      if (ciaData["CIA_2"][cia1Key[i]] != null) {
        if (ciaData["CIA_2"][cia1Key[i]] == "AB") {
          totalCiaMarks2 += 0;
        } else {
          totalCiaMarks2 += ciaData["CIA_2"][cia1Key[i]];
        }
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff3a57e8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "CIA Exam Marks",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            fontSize: 20,
            color: Color(0xffffffff),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Color(0xffffffff),
            size: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        /* decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Background.jpg"),
            fit: BoxFit.cover,
          ),
        ),*/
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Image(
                          image: AssetImage("assets/images/AUL.png"),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Atmiya University",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            fontSize: 23,
                            color: Color(0xff000000),
                          ),
                        ),
                        Text(
                          "Faculty of Engineering & Technology",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                        Text(
                          "Continuous Internal Assessment",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,
                            fontSize: 16,
                            color: Color(0xff000000),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const Center(
                child: Text(
                  "Result",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                    color: Color(0xff000000),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xff252048),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    // Add your desired padding
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      // Use min to allow the Column to take the minimum height needed
                      children: isLoading
                          ? [const Center(child: CircularProgressIndicator())]
                          : ciaData["CIA_1"] != 0
                              ? [
                                  Text(
                                    'Name :- ${ciaData["CIA_1"]["NAME"]}',
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  Text(
                                    "Enrollment :- ${widget.enrollmentNumber}",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  const Text(
                                    "Branch :- B.Tech (Information Technology)",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  const Text(
                                    "Batch :- 2020-2024",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                  Text(
                                    "Semester :- ${widget.type}",
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.clip,
                                    style: const TextStyle(
                                      fontStyle: FontStyle.normal,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xffffffff),
                                    ),
                                  ),
                                ]
                              : [Container()],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: const Color(0xFFC7B27D),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    border:
                        Border.all(color: const Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: isLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ciaData["CIA_1"] == 0
                              ? const Center(
                                  child: Text("No Data Found !!"),
                                )
                              : SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: DataTable(
                                    columns: const [
                                      DataColumn(
                                          label: Text(
                                        'Subject',
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff000000),
                                        ),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CIA 1',
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff000000),
                                        ),
                                      )),
                                      DataColumn(
                                          label: Text(
                                        'CIA 2',
                                        style: TextStyle(
                                          fontStyle: FontStyle.normal,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff000000),
                                        ),
                                      )),
                                    ],
                                    rows: [
                                      for (int i = 3; i < cia1Key.length; i++)
                                        DataRow(cells: [
                                          DataCell(Text(
                                            cia1Key[i],
                                            style: const TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffffffff),
                                            ),
                                          )),
                                          DataCell(Text(
                                            '${ciaData["CIA_1"][cia1Key[i]]}',
                                            style: const TextStyle(
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffffffff),
                                            ),
                                          )),
                                          DataCell(ciaData["CIA_2"] != 0
                                              ? Text(
                                                  '${ciaData["CIA_2"][cia1Key[i]]}',
                                                  style: const TextStyle(
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xffffffff),
                                                  ),
                                                )
                                              : const Text("-")),
                                        ]),
                                      DataRow(cells: [
                                        const DataCell(Text(
                                          'Total',
                                          style: TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffff0000),
                                          ),
                                        )),
                                        DataCell(Text(
                                          '$totalCiaMarks1',
                                          style: const TextStyle(
                                            fontStyle: FontStyle.normal,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xffff0000),
                                          ),
                                        )),
                                        DataCell(ciaData["CIA_2"] != 0
                                            ? Text(
                                                '$totalCiaMarks2',
                                                style: const TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffff0000),
                                                ),
                                              )
                                            : const Text(
                                                "-",
                                                style: TextStyle(
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xffff0000),
                                                ),
                                              )),
                                      ]),
                                    ],
                                  ),
                                ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
