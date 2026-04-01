import 'package:flutter/material.dart';

class AttendanceAppbar extends StatelessWidget {
  const AttendanceAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/wpu_campus.png',
            fit: BoxFit.cover,
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.white.withOpacity(0.92),
                  Colors.white.withOpacity(0.50),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                top: 30, bottom: 16, left: 16, right: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/wpu_logo.jpg',
                    height: 64,
                    width: 64,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      height: 64,
                      width: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                            color: Colors.grey.shade300),
                      ),
                      child: const Icon(Icons.account_balance,
                          color: Color(0xFF1A3A6B), size: 32),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Republic of the Philippines',
                        style: TextStyle(
                            fontSize: 11, color: Colors.black87),
                      ),
                      Text(
                        'Western Philippines University',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1A3A6B),
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




