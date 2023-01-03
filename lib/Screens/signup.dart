import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:online_job_portal/Screens/otp_input.dart';
import 'package:online_job_portal/utils.dart';

class SignupData {
  String? name;
  String? address;
  String? mobile;
  String? password;
  String? email;

  SignupData(this.name, this.address,this.mobile,this.password,this.email);
}

class SignupPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login5.dart";

  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  bool _isObscure = true;

  bool isValidate(BuildContext ctx) {
    Utils utils = Utils(context);
    var name = nameController.text.trim().toString();
    var address = addressController.text.toString();
    var email = emailController.text.toString();
    var phone = phoneController.text.toString();
    var password = passwordController.text.toString();
    if (name.isEmpty) {
      utils.showSnackbar("Name is required",2);
      return false;
    } else if (address.isEmpty) {
      utils.showSnackbar("Address is required",2);
      return false;
    } else if (phone.isEmpty) {
      utils.showSnackbar("Mobile number is required",2);
      return false;
    } else if (phone.length < 10) {
      utils.showSnackbar("Mobile number must be 10 digit",2);
      return false;
    } else if (!(phone.contains("98") || phone.contains("97"))) {
      utils.showSnackbar("Mobile number is invalid",2);
      return false;
    } else if (password.isEmpty) {
      utils.showSnackbar("Password is required",2);
      return false;
    }

    return true;
  }

  Future registerUser(BuildContext context) async {
    if (isValidate(context)) {
      var data = SignupData(nameController.text, addressController.text, "+977${phoneController.text}",
          passwordController.text, emailController.text);
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => OTPPage(data: data)));

    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient:
                LinearGradient(colors: [Colors.lightGreen, Colors.green])),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Container(
              //   margin: const EdgeInsets.only(top: 40.0,bottom: 20.0),
              //   height: 80,
              //   child: PNetworkImage('https://5.imimg.com/data5/TQ/QA/ZE/SELLER-41376584/job-portal-software-500x500.png')
              //   ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 2),
                alignment: Alignment.topLeft,
                child: Ink(
                  decoration: const ShapeDecoration(
                    color: Colors.blue,
                    shape: CircleBorder(),
                  ),
                  child: IconButton(
                      tooltip: 'Go Back',
                      iconSize: 30,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                "Create An Account",
                style: TextStyle(
                    color: Colors.white70,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 40.0),
              TextField(
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(
                    RegExp(r'[a-zA-Z ]'),
                  ),
                  FilteringTextInputFormatter.deny(RegExp('  '))
                ],
                keyboardType: TextInputType.text,
                controller: nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(10.0))),
                      child: const Icon(
                        Icons.person,
                        color: Colors.lightGreen,
                      )),
                  hintText: "Name",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(10.0))),
                      child: const Icon(
                        Icons.home,
                        color: Colors.lightGreen,
                      )),
                  hintText: "Address",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 10,
                controller: phoneController,
                decoration: InputDecoration(
                  counter: const SizedBox.shrink(),
                  contentPadding: const EdgeInsets.all(16.0),
                  prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(10.0))),
                      child: const Icon(
                        Icons.phone_android,
                        color: Colors.lightGreen,
                      )),
                  hintText: "Mobile number",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(10.0))),
                      child: const Icon(
                        Icons.email,
                        color: Colors.lightGreen,
                      )),
                  hintText: "Email (optional)",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 10.0),
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(16.0),
                  prefixIcon: Container(
                      padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                      margin: const EdgeInsets.only(right: 8.0),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30.0),
                              bottomLeft: Radius.circular(30.0),
                              topRight: Radius.circular(30.0),
                              bottomRight: Radius.circular(10.0))),
                      child: const Icon(
                        Icons.lock,
                        color: Colors.lightGreen,
                      )),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                    icon: Icon(
                        _isObscure ? Icons.visibility : Icons.visibility_off),
                    color: Colors.lightGreen,
                  ),
                  hintText: "Password",
                  hintStyle: const TextStyle(color: Colors.white54),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                ),
                obscureText: _isObscure,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(height: 30.0),
              ElevatedButton(
                style: raisedButtonStyle,
                child: const Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  registerUser(context);

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.lightGreen,
  backgroundColor: Colors.blueGrey,
  // minimumSize: Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 66),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
);

class PNetworkImage extends StatelessWidget {
  final String? image;
  final BoxFit? fit;
  final double? width, height;

  const PNetworkImage(this.image, {Key? key, this.fit, this.height, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image!,
      // placeholder: (context, url) => Center(child: CircularProgressIndicator()),
      // errorWidget: (context, url, error) => Image.asset('assets/placeholder.jpg',fit: BoxFit.cover,),
      fit: fit,
      width: width,
      height: height,
    );
  }
}
