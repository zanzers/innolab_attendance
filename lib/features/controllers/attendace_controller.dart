// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class AttendanceController {
//   final formKey = GlobalKey<FormState>();
  
  
//   final fullName = TextEditingController();
//   final office = TextEditingController();
//   final position = TextEditingController();
//   final contact = TextEditingController();
//   final purpose = TextEditingController();
  
  
//   String selectedSex = 'M'; 
//   bool isLoading = false; 
//   bool hasAttemptedSubmit = false;

  
//   Future<String> submitAttendance(Uint8List? signatureBytes) async {
    
//     if (signatureBytes == null) {
//       return "Please provide a signature";
//     }

    
//     isLoading = true;

//     try {
      
//       final url = Uri.parse("YOUR_GOOGLE_SCRIPT_WEB_APP_URL_HERE");

      
//       final bodyData = jsonEncode({
//         "fullName": fullName.text.trim(),
//         "sex": selectedSex,
//         "office": office.text.trim(),
//         "position": position.text.trim(),
//         "contact": contact.text.trim(),
//         "purpose": purpose.text.trim(),
//         "signature": base64Encode(signatureBytes), 
//       });

      
//       final response = await http.post(
//         url,
//         body: bodyData,
//       );

//       isLoading = false;

//       if (response.statusCode == 200) {
        
//         clearForm();
//         return response.body; 
//       } else {
//         return "Server Error: ${response.statusCode}";
//       }
//     } catch (e) {
//       isLoading = false;
//       return "Connection Error: $e";
//     }
//   }

//   void clearForm() {
//     fullName.clear();
//     office.clear();
//     position.clear();
//     contact.clear();
//     purpose.clear();
//     selectedSex = 'M';
//   }

//   void dispose() {
//     fullName.dispose();
//     office.dispose();
//     position.dispose();
//     contact.dispose();
//     purpose.dispose();
//   }
// }