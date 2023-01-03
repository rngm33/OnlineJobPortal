import 'dart:async';
import 'package:flutter/material.dart';
import 'package:online_job_portal/Screens/home_view.dart';
import 'package:online_job_portal/Screens/signup.dart';
import 'package:online_job_portal/constants.dart';
import 'package:online_job_portal/utils.dart';
import 'package:online_job_portal/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

final inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(8.0),
  borderSide: BorderSide(color: Constant.primary),
);

final inputDecoration = InputDecoration(
  counter: const SizedBox.shrink(),
  contentPadding: EdgeInsets.symmetric(vertical: 16.0),
  border: inputBorder,
  focusedBorder: inputBorder,
  enabledBorder: inputBorder,
);

TextEditingController p1controller = TextEditingController();
TextEditingController p2controller = TextEditingController();
TextEditingController p3controller = TextEditingController();
TextEditingController p4controller = TextEditingController();
TextEditingController p5controller = TextEditingController();
TextEditingController p6controller = TextEditingController();

class OTPPage extends StatefulWidget {
  static final String path = "lib/src/pages/misc/otp.dart";

  OTPPage({super.key, required this.data});

  SignupData data;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> {
  late Timer _timer;
  int _start = 90;
  bool isLoading = false;
  FirebaseAuth? _auth;
  String vid = "";
  var ctime;

  void initializeFlutterFire() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.android,
    ).whenComplete(() {
      setState(() {
        startTimer();
      });
    });
  }

  Future sendOtp() async {
    print("${widget.data.mobile}");
    _auth = FirebaseAuth.instance;
    return await _auth?.verifyPhoneNumber(
        phoneNumber: "${widget.data.mobile}",
        timeout: const Duration(seconds: 60),
        verificationCompleted: _onVerificationCompleted,
        verificationFailed: (FirebaseAuthException e) {
          Utils(context).showSnackbar(e.message.toString(), 3);
          setState(() {
            isLoading = true;
          });
        },

        codeSent: (String verificationId, int? resendToken) {
          vid = verificationId;
          print("code sent");
          setState(() {
            isLoading = true;
          });
        },
        codeAutoRetrievalTimeout: (_) {
          setState(() {
            isLoading = true;
          });
        });
  }

  _onVerificationCompleted(PhoneAuthCredential phoneAuthCredential) {
    var code = phoneAuthCredential.smsCode;
    if (code != null) {
      setState(() {
        p1controller.text = code[0];
        p2controller.text = code[1];
        p3controller.text = code[2];
        p4controller.text = code[3];
        p5controller.text = code[4];
        p6controller.text = code[5];
      });
      verifyCode(code);
    }
  }

  void verifyCode(String code) {
    var credential =
        PhoneAuthProvider.credential(verificationId: vid, smsCode: code);
    signInWithCredential(credential);
  }

  void signInWithCredential(PhoneAuthCredential credential) async {
    try {
      await _auth?.signInWithCredential(credential);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => SchoolList(), maintainState: true),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      Utils(context).showSnackbar(e.message.toString(), 4);
    }
  }

  void startTimer() {
    setState(() {
      isLoading = false;
    });
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
            isLoading = true;
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
    sendOtp();
  }

  void verifyOtp(BuildContext ctx) {
    if (isOtpFieldOk()) {
      String code = p1controller.text +
          p2controller.text +
          p3controller.text +
          p4controller.text +
          p5controller.text +
          p6controller.text;
      verifyCode(code);
    } else {
      Utils(ctx).showSnackbar("One of the OTP field is blank", 2);
    }
  }

  bool isOtpFieldOk() {
    var p1 = p1controller.text;
    var p2 = p2controller.text;
    var p3 = p3controller.text;
    var p4 = p4controller.text;
    var p5 = p5controller.text;
    var p6 = p6controller.text;
    if (p1.isEmpty ||
        p2.isEmpty ||
        p3.isEmpty ||
        p4.isEmpty ||
        p5.isEmpty ||
        p6.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    initializeFlutterFire();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    p1controller.text = "";
    p2controller.text = "";
    p3controller.text = "";
    p4controller.text = "";
    p5controller.text = "";
    p6controller.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: WillPopScope(
        onWillPop: () {
          if (_start != 0) {
            Utils(context).showSnackbar(
                "Please wait $_start seconds before going back", 2);
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 30.0),
              const Text(
                "Please enter the 6-digit OTP",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const Text(
                "sent to",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              Text(
                "${widget.data.mobile}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(height: 20.0),
              OTPFields(),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Didn't received a code? ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.normal,
                        fontSize: 16),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  _start != 0
                      ? Text(
                          "  Resend in $_start sec",
                          style: const TextStyle(
                              color: Colors.amberAccent,
                              fontWeight: FontWeight.normal,
                              fontSize: 16),
                        )
                      : TextButton(
                          child: const Text(
                            "Resend OTP",
                            style: TextStyle(
                              color: Constant.primary,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _start = 90;
                              isLoading = true;
                              startTimer();
                            });
                          },
                        ),
                ],
              ),
              const SizedBox(height: 30.0),
              isLoading
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constant.primary,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0)),
                        padding: const EdgeInsets.all(12.0),
                        minimumSize: const Size(200, 40),
                      ),
                      child: const Text(
                        "Verify",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      onPressed: () {
                        verifyOtp(context);
                      },
                    )
                  : const Center(child: CircularProgressIndicator())
            ],
          ),
        ),
      ),
    );
  }
}

class OTPFields extends StatefulWidget {
  const OTPFields({
    Key? key,
  }) : super(key: key);

  @override
  _OTPFieldsState createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  FocusNode? pin2FN;
  FocusNode? pin3FN;
  FocusNode? pin4FN;
  FocusNode? pin5FN;
  FocusNode? pin6FN;
  final pinStyle = const TextStyle(fontSize: 32, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    pin2FN = FocusNode();
    pin3FN = FocusNode();
    pin4FN = FocusNode();
    pin5FN = FocusNode();
    pin6FN = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    pin2FN?.dispose();
    pin3FN?.dispose();
    pin4FN?.dispose();
    pin5FN?.dispose();
    pin6FN?.dispose();
  }

  void nextField(String value, FocusNode? focusNode) {
    if (value.length == 1) {
      focusNode!.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          const SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 50,
                child: TextField(
                  controller: p1controller,
                  maxLength: 1,
                  autofocus: false,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    nextField(value, pin2FN);
                  },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: p2controller,
                  maxLength: 1,
                  focusNode: pin2FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) => nextField(value, pin3FN),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: p3controller,
                  maxLength: 1,
                  focusNode: pin3FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) => nextField(value, pin4FN),
                ),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: p4controller,
                  maxLength: 1,
                  focusNode: pin4FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) => nextField(value, pin5FN),
                  // {
                  //   if (value.length == 1) {
                  //     pin4FN!.unfocus();
                  //   }
                  // },
                ),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                    controller: p5controller,
                    maxLength: 1,
                    focusNode: pin5FN,
                    style: pinStyle,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    decoration: inputDecoration,
                    onChanged: (value) => nextField(value, pin6FN)),
              ),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: p6controller,
                  maxLength: 1,
                  focusNode: pin6FN,
                  style: pinStyle,
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    if (value.length == 1) {
                      pin6FN!.unfocus();
                    }
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
