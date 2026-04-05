import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'package:innolab_attendace/utils/constant/text_string.dart'; // For Web LocalStorage

class AttendanceProvider extends ChangeNotifier {
  final formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final office = TextEditingController();
  final contact = TextEditingController();
  final purpose = TextEditingController();
  final url = Uri.parse(ATexts.urlUri);
  
  String selectedSex = 'M';
  bool isUserCheckedIn = false;
  bool isLoading = false;
  bool hasAttemptedSubmit =false;

  AttendanceProvider() {
    // This runs immediately when the app starts
    initCheckInStatus();
  }

  // --- INITIALIZATION LOGIC ---
  void initCheckInStatus() {
    final savedContact = html.window.localStorage['attendance_contact'];
    final savedDate = html.window.localStorage['attendance_date'];
    final savedName = html.window.localStorage['attendance_fullName'];
    
    final today = DateTime.now().toString().split(' ')[0]; // e.g., "2026-04-04"

    // 1. If it's a new day, force a reset even if data exists
    if (savedDate != null && savedDate != today) {
      forceReset();
      return;
    }

    // 2. If data exists for today, restore the session
    if (savedContact != null && savedContact.isNotEmpty) {
      isUserCheckedIn = true;
      contact.text = savedContact;
      fullName.text = savedName ?? "";
      notifyListeners();
    }
  }

  // --- CHECK-IN LOGIC ---
  Future<String> submitAttendance(Uint8List? signatureBytes) async {
    if (signatureBytes == null) return "Please provide a signature";

    isLoading = true;
    notifyListeners();

    try {
      final today = DateTime.now().toString().split(' ')[0];

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
        if (response.body.contains("Error:")) {
          return response.body.replaceFirst("Error: ", "");
        }

        // SAVE TO LOCAL STORAGE
        html.window.localStorage['attendance_contact'] = contact.text.trim();
        html.window.localStorage['attendance_fullName'] = fullName.text.trim();
        html.window.localStorage['attendance_date'] = today;
        
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

  // --- CHECK-OUT LOGIC ---
  Future<String> handleTimeOut() async {
    isLoading = true;
    notifyListeners();

    try {
      final savedContact = html.window.localStorage['attendance_contact'];

      final bodyData = jsonEncode({
        "contact": savedContact,
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

  // --- RESET LOGIC ---
  void forceReset() {
    html.window.localStorage.remove('attendance_contact');
    html.window.localStorage.remove('attendance_fullName');
    html.window.localStorage.remove('attendance_date');

    isUserCheckedIn = false;
    fullName.clear();
    contact.clear();
    office.clear();
    purpose.clear();
    notifyListeners();
  }
}