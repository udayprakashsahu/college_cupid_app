import 'package:couplecupid/services/firebase_services.dart';
import 'package:flutter/material.dart';
import 'package:couplecupid/otp.dart';
import 'package:couplecupid/homepage.dart';
import 'package:lottie/lottie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> with TickerProviderStateMixin {
  late TabController _tabController;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  bool _isAgreeChecked = false;
  String _loginEmail = '';
  String _loginPassword = '';
  String _password = '';
  String _confirmPassword = '';
  String _passwordError = '';
  String _phoneNumber = '';
  String _phoneNumberError = '';
  String _email = '';
  String _emailError = '';
  final TextEditingController _usernameController = TextEditingController();
  String _usernameError = '';

  bool canSignUp() {
    return _usernameController.text.isNotEmpty &&
        _password.isNotEmpty &&
        _phoneNumber.isNotEmpty &&
        _email.isNotEmpty &&
        _phoneNumberError.isEmpty &&
        _emailError.isEmpty &&
        _confirmPassword.isNotEmpty &&
        _isAgreeChecked &&
        _password == _confirmPassword &&
        _usernameError.isEmpty &&
        _passwordError.isEmpty &&
        _usernameController.text.length >= 2 &&
        _password.length >= 8 &&
        _password.length <= 18;
  }
  bool canLogIn() {
    return _loginEmail.isNotEmpty && _loginPassword.isNotEmpty;
  }



  bool _isValidEmailFormat(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _isValidPhoneNumberFormat(String phoneNumber) {
    final RegExp phoneRegex = RegExp(
      r'^[0-9]{10}$',
    );
    return phoneRegex.hasMatch(phoneNumber);
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    double fem = 1.0;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(40 * fem, 20 * fem, 40 * fem, 48 * fem),
        decoration: const BoxDecoration(
          color: Color(0xff000000),
        ),
        child: Column(
          children: [
            const SizedBox(height: 20),
            TabBar(
              controller: _tabController,
              indicatorColor: const Color(0xffCC323F),
              tabs: const [
                Tab(text: 'Login'),
                Tab(text: 'Sign Up'),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildLoginTab(fem),
                  _buildSignUpTab(fem),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpTab(double fem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 80 * fem),
          TextField(
            controller: _usernameController,
            onChanged: (text) {
              setState(() {
                if (text.length < 2) {
                  _usernameError = 'Username must be at least 2 characters long';
                } else {
                  _usernameError = '';
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Username',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          if (_usernameError.isNotEmpty)
            Column(
              children: [
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    _usernameError,
                    style: const TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              ],
            ),
          SizedBox(height: 12 * fem),
          TextField(
            decoration: InputDecoration(
              hintText: 'Email',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(color: Colors.white),
            onChanged: (value) {
              setState(() {
                _email = value;
                _emailError = '';
                if (!_isValidEmailFormat(value)) {
                  _emailError = 'Invalid email format';
                }
              });
            },
          ),
          if (_emailError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _emailError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14 * fem,
                ),
              ),
            ),
          SizedBox(height: 12 * fem),
          Row(
            children: [
              Container(
                width: 70 * fem,
                padding: const EdgeInsets.all(19),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: const Color(0xffCC323F),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: const Center(
                  child: Text(
                    '+91',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 10 * fem),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Mobile Number',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xffCC323F)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Color(0xffCC323F)),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  style: const TextStyle(color: Colors.white),
                  onChanged: (value) {
                    setState(() {
                      _phoneNumber = value;
                      _phoneNumberError = '';
                      if (!_isValidPhoneNumberFormat(value)) {
                        _phoneNumberError = 'Invalid phone number format';
                      }
                    });
                  },
                ),
              ),
            ],
          ),
          if (_phoneNumberError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _phoneNumberError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14 * fem,
                ),
              ),
            ),
          SizedBox(height: 12 * fem),
          TextField(
            onChanged: (value) {
              setState(() {
                _password = value;
                _passwordError = '';
                if (value.length < 8 || value.length > 18) {
                  _passwordError = 'Password must be between 8 and 18 characters.';
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                color: Colors.white,
              ),
            ),
            obscureText: !_passwordVisible,
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(height: 16 * fem),
          TextField(
            onChanged: (value) {
              setState(() {
                _confirmPassword = value;
                _passwordError = '';
                if (value.length < 8 || value.length > 18) {
                  _passwordError = 'Password must be between 8 and 18 characters.';
                }
                if (_confirmPassword != _password) {
                  setState(() {
                    _passwordError = 'Passwords do not match. Please make sure the passwords match.';
                  });
                  return;
                }
              });
            },
            decoration: InputDecoration(
              hintText: 'Confirm Password',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
                icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                color: Colors.white,
              ),
            ),
            obscureText: !_confirmPasswordVisible,
            style: const TextStyle(color: Colors.white),
          ),
          if (_passwordError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                _passwordError,
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 14 * fem,
                ),
              ),
            ),
          SizedBox(height: 24 * fem),
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red),
                  borderRadius: BorderRadius.circular(4.0),
                ),
                padding: const EdgeInsets.all(2.0),
                child: SizedBox(
                  width: 13.0,
                  height: 13.0,
                  child: Checkbox(
                    value: _isAgreeChecked,
                    onChanged: (value) {
                      setState(() {
                        _isAgreeChecked = value!;
                      });
                    },
                    activeColor: Colors.red,
                    checkColor: Colors.white,
                    fillColor: MaterialStateProperty.resolveWith<Color>((Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected)) {
                        return Colors.red;
                      }
                      return Colors.transparent;
                    }),
                  ),
                ),
              ),
              Text(
                '   I agree with the terms and conditions of the app ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.2 * fem,
                ),
              ),
            ],
          ),
          SizedBox(height: 24 * fem),
          ElevatedButton(
            onPressed: canSignUp()
                ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const OtpPage()));
            }
                : null,
            style: ButtonStyle(
              backgroundColor: canSignUp()
                  ? MaterialStateProperty.all<Color>(const Color(0xffCC323F))
                  : MaterialStateProperty.all<Color>(Colors.grey),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12 * fem)),
            ),
            child: Text(
              'Sign Up',
              style: TextStyle(
                fontFamily: 'Sk-Modernist',
                fontSize: 14 * fem,
                fontWeight: FontWeight.w700,
                height: 1.5 * fem,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 20 * fem),
          Text(
            'Or sign up with',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Sk-Modernist',
              fontSize: 14 * fem,
              fontWeight: FontWeight.w400,
              height: 1.5 * fem,
              color: const Color(0xffcc323f),
            ),
          ),
          SizedBox(height: 23 * fem),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Add your desired functionality here (Facebook signup)
                },
                icon: Icon(
                  Icons.facebook,
                  color: const Color(0xff1877F2),
                  size: 30 * fem,
                ),
              ),
              SizedBox(width: 20 * fem),
              IconButton(
                onPressed: () async {
                  bool signInSuccessful = await FirebaseServices().signInWithGoogle();
                  if (signInSuccessful) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpPage()),
                    );
                  }
                },
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red, size: 27 * fem),
              ),
              SizedBox(width: 20 * fem),
              IconButton(
                onPressed: () {
                  
                },
                icon: FaIcon(FontAwesomeIcons.apple, color: Colors.grey, size: 30 * fem),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoginTab(double fem) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 4 * fem),
          SizedBox(
            height: 300 * fem,
            child: Lottie.asset(
              'assets/LOGIN.json',
              height: 300 * fem,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 20 * fem),
          TextField(
            onChanged: (value) {
              setState(() {
                _loginEmail = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Email/Phone Number',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(height: 20 * fem),
          TextField(
            onChanged: (value) {
              setState(() {
                _loginPassword = value;
              });
            },
            decoration: InputDecoration(
              hintText: 'Password',
              hintStyle: const TextStyle(
                color: Colors.white,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: const BorderSide(color: Color(0xffCC323F)),
              ),
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                color: Colors.white,
              ),
            ),
            obscureText: !_passwordVisible,
            style: const TextStyle(color: Colors.white),
          ),
          SizedBox(height: 10 * fem),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                onPressed: () {
                  // Add your forgot password functionality here
                },
                child: const Text(
                  'Forgot Password?',
                  style: TextStyle(
                    color: Color(0xffCC323F),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12 * fem),
          ElevatedButton(
            onPressed: canLogIn() ? () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const DatingAppHomePage()));
            } : null,
            style: ButtonStyle(
              backgroundColor: canLogIn()
                  ? MaterialStateProperty.all<Color>(const Color(0xffCC323F))
                  : MaterialStateProperty.all<Color>(Colors.grey),
              foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(12 * fem)),
            ),
            child: Text(
              'Log In',
              style: TextStyle(
                fontFamily: 'Sk-Modernist',
                fontSize: 14 * fem,
                fontWeight: FontWeight.w700,
                height: 1.5 * fem,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 12 * fem),
          Text(
            'Or sign in with',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Sk-Modernist',
              fontSize: 14 * fem,
              fontWeight: FontWeight.w400,
              height: 1.5 * fem,
              color: const Color(0xffcc323f),
            ),
          ),
          SizedBox(height: 16 * fem),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  // Add your desired functionality here (Facebook sign-in)
                },
                icon: Icon(
                  Icons.facebook,
                  color: const Color(0xff1877F2),
                  size: 30 * fem,
                ),
              ),
              SizedBox(width: 20 * fem),
              IconButton(
                onPressed: () async {
                  bool signInSuccessful = await FirebaseServices().signInWithGoogle();
                  if (signInSuccessful) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OtpPage()),
                    );
                  }
                },
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.red, size: 27 * fem),
              ),
              SizedBox(width: 12 * fem),
              IconButton(
                onPressed: () {
                },
                icon: FaIcon(FontAwesomeIcons.apple, color: Colors.grey, size: 30 * fem),
              ),
            ],
          ),
        ],
      ),
    );
  }
}