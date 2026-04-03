import 'package:flutter/services.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';

class FormValidation {


// Name validation here
  static TextInputFormatter capitalizeWords() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) return newValue;

      final String text = newValue.text;
      final List<String> words = text.split(' ');
      final List<String> capitalizedWords = words.map((word) {
        if (word.isEmpty) return word;
        return word[0].toUpperCase() + word.substring(1);
      }).toList();

      final String newText = capitalizedWords.join(' ');
      
      return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length),
      );
    });
  }

  static String? validateFullName(String? value){
    if (value == null || value.trim().isEmpty) {
      return ATexts.errorName;
    }

    List<String> names = value.trim().split(RegExp(r'\s+'));
    if(names.length < 3) {
      return ATexts.errorFullName;
    }

    return null;
  }
// Name validation end here



// contact/account number validation here

  static TextInputFormatter contactFormatter(){

    return TextInputFormatter.withFunction((oldValue, newValue) {
      String text = newValue.text;


    if(text.startsWith('00')) return oldValue;


    if(text.startsWith('09')){
        text = '+63 9${text.substring(2)}';
      }

    if(text.startsWith('+63 9')){
        final digits = text.replaceAll(RegExp(r'\D'), '');
        if(digits.length > 12) return oldValue;

        var buffer = StringBuffer();
        buffer.write('+');
        for (int i = 0; i < digits.length; i++) {
          buffer.write(digits[i]);

          if(i == 1) buffer.write(' '); 
          if(i == 4 || i == 7) {
              if(i != digits.length - 1) buffer.write('-');
            }
        }
        String formatted = buffer.toString();
        return newValue.copyWith(
          text: formatted,
          selection: TextSelection.collapsed(offset: formatted.length),
        );
      }

      if(text.startsWith('0') && text.length > 1 && !text.startsWith('09')){ return oldValue; }
      

      return newValue;
    });
  }

static String? validateRequired(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    // Adding the asterisk here
    return '* $fieldName is required'; 
  }

  if(value.startsWith('00')){
    return ATexts.errorFormat;
  }
  return null;
 }


 static TextInputFormatter blockLeadingZeros(){
  return TextInputFormatter.withFunction((oldValue, newValue) {

    if (newValue.text.startsWith('0')) {
      return oldValue;
    }
    return newValue;
  });
 }
}





