import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:innolab_attendace/features/attendace/widgets/textEditingController.dart';
import 'package:innolab_attendace/utils/constant/size.dart';
import 'package:innolab_attendace/utils/constant/text_string.dart';
import 'package:signature/signature.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final controller = AttendanceController();

  late SignatureController _signatureController;
  bool _isMale = false;
  bool _isFemale = false;
  bool _agreedToPrivacy = false;

  @override
  void initState() {
    super.initState();
    _signatureController = SignatureController(
      penStrokeWidth: 3,
      penColor: Colors.black,
      exportBackgroundColor: Colors.white,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    _signatureController.dispose();
    super.dispose();
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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

  TextStyle get _labelStyle => const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.5,
        color: Color(0xFF1A1A2E),
      );

  // Custom checkbox: white background, thin border, checkmark only — no fill
  Widget _outlineCheckbox({
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD6E8F5),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header with Campus Background ──────────────────────
            SizedBox(
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
            ),

            // ── Form Card ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Title ──
                      const Center(
                        child: Text(
                          'ATTENDANCE FORM',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.5,
                            color: Color(0xFF1A1A2E),
                          ),
                        ),
                      ),
                      const Center(
                        child: Text(
                          'OFFICE OF THE VICE PRESIDENT FOR THE\nRESEARCH DEVELOPMENT & EXTENTION',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 9,
                            color: Colors.grey,
                            letterSpacing: 0.3,
                            height: 1.5,
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // ── Full Name ──
                      Text('FULL NAME', style: _labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.fullName,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 13),
                        decoration: _fieldDecoration(
                            'e.g. Marcelo R. Manzano Jr.'),
                      ),

                      const SizedBox(height: 16),

                      // ── Sex ──
                      Row(
                        children: [
                          Text('SEX:', style: _labelStyle),
                          const SizedBox(width: 20),
                          Row(
                            children: [
                              _outlineCheckbox(
                                value: _isMale,
                                onChanged: (v) => setState(() {
                                  _isMale = v!;
                                  if (v) _isFemale = false;
                                  controller.selectedSex = v ? 'M' : '';
                                }),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Male',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black87),
                              ),
                            ],
                          ),
                          const SizedBox(width: 16),
                          Row(
                            children: [
                              _outlineCheckbox(
                                value: _isFemale,
                                onChanged: (v) => setState(() {
                                  _isFemale = v!;
                                  if (v) _isMale = false;
                                  controller.selectedSex = v ? 'F' : '';
                                }),
                              ),
                              const SizedBox(width: 6),
                              const Text(
                                'Female',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black87),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // ── Office/Agency ──
                      Text('OFFICE/AGENCY', style: _labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.office,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 13),
                        decoration: _fieldDecoration('e.g. OVPRED'),
                      ),

                      const SizedBox(height: 16),

                      // ── Position/Designation ──
                      Text('POSITION/DESIGNATION', style: _labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.position,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 13),
                        decoration: _fieldDecoration('e.g. Faculty'),
                      ),

                      const SizedBox(height: 16),

                      // ── Email / Contact ──
                      Text('EMAIL or CONTACT NUMBER', style: _labelStyle),
                      const SizedBox(height: 6),
                      TextFormField(
                        controller: controller.contact,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(
                            color: Colors.black87, fontSize: 13),
                        decoration:
                            _fieldDecoration('e.g. email@wpu.edu.ph'),
                      ),

                      const SizedBox(height: 20),

                      // ── Digital Signature ──
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('DIGITAL SIGNATURE', style: _labelStyle),
                          TextButton(
                            onPressed: () => _signatureController.clear(),
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              minimumSize: Size.zero,
                              tapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            child: const Text(
                              'Clear',
                              style: TextStyle(
                                color: Color(0xFF1A3A6B),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Signature(
                            controller: _signatureController,
                            height: 140,
                            backgroundColor: Colors.grey.shade50,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // ── Privacy Notice ──
                      Text('Privacy Notice', style: _labelStyle),
                      const SizedBox(height: 6),
                      Container(
                        height: 80,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Colors.grey.shade300, width: 0.8),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const SingleChildScrollView(
                          child: Text(
                            'For this Technical Working Group Workshop, we collect your names, sex, office/agency affiliation, position/designation, and email address or mobile number when you register for purposes of coordination, printing of certificates, and in compliance to GAD requirements. Through this attendance sheet, we also collect your signature as proof of attendance. To the extent permitted or required by law, we may also share photos and videos of this activity/meeting/event to promote WPU through brochures, website posts, and social media. All personal information collected will be stored in a secure location and only authorized staff will have access to them.',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black87,
                                height: 1.5),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ── Privacy Checkbox ──
                      Row(
                        children: [
                          _outlineCheckbox(
                            value: _agreedToPrivacy,
                            onChanged: (v) =>
                                setState(() => _agreedToPrivacy = v!),
                          ),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Text(
                              'I have read and agree to the data privacy policy',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ── Submit Button ──
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1A1A2E),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor:
                                const Color(0xFF1A1A2E).withOpacity(0.4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            elevation: 0,
                          ),
                          onPressed:
                              (!_agreedToPrivacy || controller.isLoading)
                                  ? null
                                  : () async {
                                      if (controller.formKey.currentState!
                                          .validate()) {
                                        final bytes =
                                            await _signatureController
                                                .toPngBytes();
                                        final message = await controller
                                            .submitAttendance(bytes);
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(content: Text(message)),
                                        );
                                        setState(() {});
                                      }
                                    },
                          child: controller.isLoading
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                      color: Colors.white, strokeWidth: 2.5),
                                )
                              : const Text(
                                  'SUBMIT ATTENDANCE',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 1.2,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}