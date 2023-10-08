import 'package:couplecupid/profile.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  _OtpPageState createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  int _remainingTime = 240;
  bool _isResendingOtp = false;
  final _focusNodes = List.generate(4, (_) => FocusNode());
  final _textControllers = List.generate(4, (_) => TextEditingController());
  bool _areAllFieldsFilled = false;
  bool canSubmit() {
    return _areAllFieldsFilled==true;
  }

  @override
  void initState() {
    super.initState();
    startTimer();
    for (int i = 0; i < _textControllers.length; i++) {
      _textControllers[i].addListener(() {
        setState(() {
          _areAllFieldsFilled = _textControllers.every((controller) => controller.text.isNotEmpty);
        });
        if (_textControllers[i].text.length == 1 && i < _focusNodes.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  void startTimer() {
    if (_remainingTime > 0) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          _remainingTime--;
        });
        startTimer();
      });
    } else {
      setState(() {
        _isResendingOtp = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final remainingDuration = Duration(seconds: _remainingTime);
    final minutes = remainingDuration.inMinutes;
    final seconds = remainingDuration.inSeconds % 60;
    final formattedTime = '$minutes:${seconds.toString().padLeft(2, '0')}';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'OTP Verification',
          style: TextStyle(color: Color(0xffCC323F)),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xffCC323F)),
      ),
      body: SingleChildScrollView(  // Wrap with SingleChildScrollView
        child: Container(
          decoration: const BoxDecoration(
            color: Color(0xff000000),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/ZNWa3TTTol.json', // Path to your animation JSON file
                width: 360,
                height: 360,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter the OTP sent to ( user number ) and ( user email ). Valid for 4 mins',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int i = 0; i < _focusNodes.length; i++)
                    ...[
                      _buildOtpField(
                          focusNode: _focusNodes[i],
                          controller: _textControllers[i]),
                      if (i != _focusNodes.length - 1) const SizedBox(width: 10),
                    ],
                ],
              ),
              const SizedBox(height: 60),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Change your number or email',
                    style: TextStyle(
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 1),
              TextButton(
                onPressed: _isResendingOtp
                    ? () {
                  // Implement your logic for resending the OTP here
                }
                    : null,
                child: Text(
                  _isResendingOtp
                      ? 'Did not receive OTP? Tap to resend.'
                      : 'Resend OTP in $formattedTime',
                  style: TextStyle(
                    color: _isResendingOtp ? Colors.white : Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _areAllFieldsFilled
                    ? () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const Profile()));
                }
                    : null,
                style: ButtonStyle(
                  backgroundColor: canSubmit()
                      ? MaterialStateProperty.all<Color>(const Color(0xffCC323F))
                      : MaterialStateProperty.all<Color>(Colors.grey),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white), 
                ),
                child: const Text(
                  'Submit OTP',
                  style: TextStyle(
                    fontFamily: 'Sk-Modernist',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField({
    required FocusNode focusNode,
    required TextEditingController controller,
  }) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffCC323F), width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        focusNode: focusNode,
        controller: controller,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(fontSize: 20, color: Colors.white),
        textAlign: TextAlign.center,
        cursorColor: Colors.white,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: OtpPage()));
