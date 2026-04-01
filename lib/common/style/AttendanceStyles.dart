import 'package:flutter/material.dart';

class AttendanceStyles {
  
  static TextStyle get labelStyle => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: Color(0xFF1A1A2E),
      );

  
  static InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 0.8),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Color(0xFF1A3A6B), width: 1.2),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Colors.grey.shade300, width: 0.8),
      ),
    );
  }

  
  static Widget outlineCheckbox({
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        width: 20,
        height: 20,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: value ? const Color(0xFF1A3A6B) : Colors.grey.shade400,
            width: 1.2,
          ),
        ),
        child: value
            ? const Icon(
                Icons.check,
                size: 14,
                color: Color(0xFF1A3A6B),
              )
            : null,
      ),
    );
  }

  
  static Widget buildSexOption(String label, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        outlineCheckbox(value: value, onChanged: (v) => onChanged(v!)),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 13, color: Colors.black87)),
      ],
    );
  }
}