
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foet_internal_examination/API/CIADataPage.dart';
import 'package:foet_internal_examination/validation.dart';
import '../constants.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  State<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends State<MemberPage> {
  final _formKey = GlobalKey<FormState>();

  String type = "none";

  List<Map<String, dynamic>> data = [];

  var enrollmentController = TextEditingController();
  var enrollment = "";
  var semester = "";
  String responseData = '';

  //Enrollment and Semester Data
  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Enrollment No.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              // Allow only numbers
              LengthLimitingTextInputFormatter(9),
              // Limit length to 9 digits
            ],
            style: const TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            validator: (val) {
              if (val == null || val.isEmpty) {
                return 'Please Enter Enrollment';
              } else if (!val.isValidPhone) {
                return 'Please Enter Valid Enrollment';
              }
              return null;
            },
            controller: enrollmentController,
            decoration: const InputDecoration(
              fillColor: Colors.white24,
              filled: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.drag_indicator_rounded,
                color: Colors.blue,
              ),
              hintText: 'Enter Your Enrollment',
              hintStyle: TextStyle(color: Colors.black38),
              errorStyle: TextStyle(fontSize: 15),
            ),
          ),
          const SizedBox(height: defaultPadding),
          const Text(
            'Semester.',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(
            height: defaultPadding,
          ),
          InputDecorator(
            decoration: const InputDecoration(
              fillColor: Colors.white24,
              filled: true,
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.keyboard_option_key,
                color: Colors.blue,
              ),
            ),
            child: DropdownButton(
              value: type,
              items: const [
                DropdownMenuItem(
                  value: "none",
                  child: Text("Select option"),
                ),
                DropdownMenuItem(
                  value: "1ST",
                  child: Text("Sem 1"),
                ),
                DropdownMenuItem(
                  value: "2ND",
                  child: Text("Sem 2"),
                ),
                DropdownMenuItem(
                  value: "3RD",
                  child: Text("Sem 3"),
                ),
                DropdownMenuItem(
                  value: "4TH",
                  child: Text("Sem 4"),
                ),
                DropdownMenuItem(
                  value: "5TH",
                  child: Text("Sem 5"),
                ),
                DropdownMenuItem(
                  value: "6TH",
                  child: Text("Sem 6"),
                ),
                DropdownMenuItem(
                  value: "7TH",
                  child: Text("Sem 7"),
                ),
                DropdownMenuItem(
                  value: "8TH",
                  child: Text("Sem 8"),
                ),
              ],
              onChanged: (value) {
                type = value.toString();
                setState(() {});
              },
              isDense: true,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: 'OpenSans', //Font color
              ),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              dropdownColor: Colors.white,
              underline: Container(),
              isExpanded: true,
            ),
          ),
        ],
      ),
    );
  }

  // Get and Clear Button in one ROW
  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.5, // Adjust width here
          child: ElevatedButton(
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  enrollment = enrollmentController.text;
                });
                if (enrollmentController.text.isNotEmpty &&
                    type.isNotEmpty &&
                    type != "none") {
                  // If form is valid, fetch data
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CIADataPage(
                        enrollmentController.text.toString(),
                        type.toString(),
                      ),
                    ),
                  );
                  debugPrint(
                      "Enrollment --------- ${enrollmentController.text}");
                  debugPrint("sem ---------------- $type");
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text(
                        "Please Enter Perfect Value",
                      ),
                      backgroundColor: Colors.teal,
                      behavior: SnackBarBehavior.floating,
                      action: SnackBarAction(
                        label: 'Dismiss',
                        disabledTextColor: Colors.white,
                        textColor: Colors.yellow,
                        onPressed: () {
                          //Do whatever you want
                        },
                      ),
                    ),
                  );
                }
                const CircularProgressIndicator();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              'Get',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.5, // Adjust width here
          child: ElevatedButton(
            onPressed: () {
              setState(() {
                enrollmentController.clear();
                type = "none";
                responseData = '';
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
            ),
            child: const Text(
              'Clear',
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1.5,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
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
                  text: " - Internal Examination",
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white12,
                      Colors.white12,
                      Colors.white12,
                      Colors.white12,
                    ],
                    stops: [0.1, 0.4, 0.6, 0.9],
                  ),
                ),
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 20.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      _buildForm(),
                      const SizedBox(height: 20.0),
                      _buildActionButtons(),
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              )
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
