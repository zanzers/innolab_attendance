// ignore: file_names
import 'dart:convert';
import 'dart:typed_data';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:innolab_attendace/utils/constant/text_string.dart';

class AttendanceController extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();

  final fullName = TextEditingController();
  final office = TextEditingController();
  final position = TextEditingController();
  final contact = TextEditingController();
  final purpose = TextEditingController();

  
  String selectedSex = ''; 
  bool isLoading = false;
  bool isUserCheckedIn = false;
  bool hasAttemptedSubmit = false;

  Future<String> submitAttendance(Uint8List? signatureBytes) async {
    if (signatureBytes == null) return "Please provide a signature";

    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ATexts.urlUri);

      final bodyData = jsonEncode({
        "fullName": fullName.text.trim(),
        "male": selectedSex == 'M' ? 'M' : ' ',
        "female": selectedSex == 'F' ? 'F' : ' ',
        "office": office.text.trim(),
        "contact": contact.text.trim(), 
        "purpose": purpose.text.trim(),
        "signature": base64Encode(signatureBytes),
        "action": "checkIn",
      });

      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200 || response.statusCode == 302) {

        final responseBody = response.body;
        if(responseBody.contains("Error:")){
          return responseBody.replaceFirst("Error: ", "");
        }

        html.window.localStorage['attendance_contact'] = contact.text.trim();
        html.window.localStorage['attendance_fullName'] = fullName.text.trim();
        isUserCheckedIn = true;

        return "Attendance Submitted Successfully!";
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Connection Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

Future<String> handleTimeOut() async {
    isLoading = true;
    notifyListeners();

    try {
      final url = Uri.parse(ATexts.urlUri);
      final saveContact = html.window.localStorage['attendance_contact'];

      final bodyData = jsonEncode({
        "contact": saveContact,
        "action": 'checkOut',
      });

      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200 || response.statusCode == 302) {
       forceReset();
        return "Checked Out Successfully!";
      } else {
        return "Server Error: ${response.statusCode}";
      }
    } catch (e) {
      return "Connection Error: $e";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void forceReset() {
    html.window.localStorage.clear();
    isUserCheckedIn = false;
    clearForm();
    notifyListeners();
  }



  void checkExistingSession(){
    if(html.window.localStorage.containsKey('attendance_contact')){
      isUserCheckedIn = true;
      fullName.text = html.window.localStorage['attendance_fullName'] ?? '';
      notifyListeners();
    }
  }

  void clearForm() {
    fullName.clear();
    office.clear();
    position.clear();
    contact.clear();
    purpose.clear();
    selectedSex = '';
    notifyListeners();
  }

  @override
  void dispose() {
    fullName.dispose();
    office.dispose();
    position.dispose();
    contact.dispose();
    purpose.dispose();
    super.dispose();
  }


}