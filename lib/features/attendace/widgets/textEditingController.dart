// ignore: file_names
import 'dart:convert';
import 'dart:typed_data';
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

  Future<String> submitAttendance(Uint8List? signatureBytes) async {
    if (selectedSex.isEmpty) return "Please select a sex";
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
      });

      final response = await http.post(url, body: bodyData);

      if (response.statusCode == 200 || response.statusCode == 302) {
        clearForm();
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