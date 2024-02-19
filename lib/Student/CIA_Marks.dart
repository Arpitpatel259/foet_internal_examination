// ignore_for_file: prefer_const_constructors_in_immutables
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
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        elevation: 4,
        centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xff191bd2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        title: const Text(
          "CIA Exam Marks",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 14,
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Image(
                        image: AssetImage("assets/images/AULOGO.png"),
                        width: 100,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
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
                            fontSize: 25,
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
                            fontSize: 18,
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
                            fontSize: 18,
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
                padding: EdgeInsets.all(15.0),
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
                      children: ciaData["CIA_1"] != null && ciaData.isNotEmpty
                          ? [
                              Text(
                                'Name :- ${ciaData["CIA_1"]["NAME"]}',
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Text(
                                "Branch :- ${widget.enrollmentNumber}",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                              Text(
                                "Batch :- ${widget.enrollmentNumber}",
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.clip,
                                style: const TextStyle(
                                  fontStyle: FontStyle.normal,
                                  fontSize: 18,
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
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xffffffff),
                                ),
                              ),
                            ]
                          : [
                              Center(
                                child: Text("No Data Found !!"),
                              )
                            ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Color(0xFFC7B27D),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    border: Border.all(color: Color(0x4d9e9e9e), width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ciaData["CIA_1"] != null
                        ? SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ciaData.isEmpty
                                ? const Center(
                                    child: CircularProgressIndicator())
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
                                        for (int i = 3;
                                            i < CIA_1_Key.length;
                                            i++)
                                          DataRow(cells: [
                                            DataCell(Text(
                                              CIA_1_Key[i],
                                              style: const TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff),
                                              ),
                                            )),
                                            DataCell(Text(
                                              '${ciaData["CIA_1"][CIA_1_Key[i]]}',
                                              style: const TextStyle(
                                                fontStyle: FontStyle.normal,
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                color: Color(0xffffffff),
                                              ),
                                            )),
                                            DataCell(ciaData["CIA_2"] != 0
                                                ? Text(
                                                    '${ciaData["CIA_2"][CIA_1_Key[i]]}',
                                                    style: const TextStyle(
                                                      fontStyle:
                                                          FontStyle.normal,
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xffffffff),
                                                    ),
                                                  )
                                                : const Text("-")),
                                          ]),
                                      ],
                                    ),
                                  ),
                          )
                        : Container(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
