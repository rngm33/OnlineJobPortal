import 'package:animator/animator.dart';
import 'package:flutter/material.dart';
import 'package:online_job_portal/Screens/signup.dart';
import 'package:online_job_portal/constants.dart';
import 'package:online_job_portal/utils.dart';

class LoginPage extends StatefulWidget {
  static final String path = "lib/src/pages/login/login9.dart";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isObscure = true;
  int _state = 0;
  double _width = 145.0;
  late Animation _animation;
  late AnimationController animationController;
  final GlobalKey _globalKey = GlobalKey();

  setUpButtonChild() {
    if (_state == 0) {
      return const Text(
        "LOGIN",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    } else if (_state == 1) {
      return const SizedBox(
        height: 20.0,
        width: 26.0,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }
    if (_state == 2) {
      return const Text(
        'LOGIN',
        style:  TextStyle(
          color: Colors.white,
          fontSize: 16.0,
        ),
      );
    }
  }

   void animateButton() {
    double initialWidth = (_globalKey.currentContext!.size!.width);

    animationController =
        AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(animationController)
      ..addListener(() {
        setState(() {
          _width = initialWidth - ((initialWidth - 48.0) * _animation.value);
        });
      });

    animationController.forward();

    setState(() {
      _state = 1;
      // controller.reverse();
    });
  }
  
void performLogin() {
    setState(() {
      if (_state == 0) {
        animateButton();
      }
    });
    String phone = phoneController.text;
    String password = passwordController.text;
    if (phone.isEmpty && password.isNotEmpty) {
      Utils(context).showSnackbar("Phone No. is required",2);
      setState(() {
        _state = 0;
        animationController.reverse();
      });
      return;
    } else if (password.isEmpty && phone.isNotEmpty) {
      Utils(context).showSnackbar('Password is required ',2);
      setState(() {
        _state = 0;
        animationController.reverse();
      });
      return;
    }
    if (phone.isEmpty && password.isEmpty) {
      Utils(context).showSnackbar('Phone and Password cannot be empty',2);
      setState(() {
        _state = 0;
        animationController.reverse();
      });
      return;
    } else {
      // validateLogin(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.pexels.com/photos/341970/pexels-photo-341970.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  foregroundDecoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                // if (MediaQuery.of(context).viewInsets == EdgeInsets.zero)
                //   const Padding(
                //     padding:  EdgeInsets.only(top: kToolbarHeight),
                //     child: Text(
                //       "Online Job Portal",
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontWeight: FontWeight.bold,
                //         fontSize: 20.0,
                //       ),
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                Animator<double>(
                  triggerOnInit: true,
                  curve: Curves.easeIn,
                  tween: Tween<double>(begin: -1, end: 0),
                  builder: (context, state, child) {
                    return FractionalTranslation(
                      translation: Offset(state.value,0),
                      child: child,
                    );
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Expanded(
                      child: ListView(
                        physics:
                        // const BouncingScrollPhysics(),
                            MediaQuery.of(context).viewInsets == EdgeInsets.zero
                                ? const NeverScrollableScrollPhysics()
                                : null,
                        padding: const EdgeInsets.all(32.0),
                        shrinkWrap: true,
                        children: [
                          const SizedBox(height: kToolbarHeight),
                          Text(
                            "Sign In",
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.lightBlue.shade100,letterSpacing: .6),
                            textAlign: TextAlign.center,
                            
                          ),
                    
                          const SizedBox(height: 20.0),
                          TextField(
                            keyboardType: TextInputType.number,
                            maxLength: 10,
                            style: const TextStyle(color: Colors.white),
                            controller: phoneController,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 16.0, horizontal: 32.0),
                              prefixIcon: const Icon(
                                Icons.phone_android_rounded,
                                color: Colors.blueGrey,
                              ),
                              counter: const SizedBox.shrink(),
                              hintText: "Mobile No.",
                              hintStyle:const TextStyle(color: Colors.blueGrey),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(40.0),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10.0,),
                          TextField(
                              scrollPhysics:const BouncingScrollPhysics(),
                              obscureText: _isObscure,
                              style: const TextStyle(color: Colors.white),
                              controller: passwordController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(top:8 ,left: 1,right: 1 ,bottom: 8),
                                prefixIcon: const Icon(Icons.lock,color: Colors.blueGrey,),
                                suffixIcon: IconButton(
                                 icon: Icon(_isObscure ? Icons.visibility: Icons.visibility_off,color: Colors.blueGrey,),
                                 onPressed: () {
                                 setState(() {
                                    _isObscure = !_isObscure;
                                 });
                                      }
                                ),
                                hintText: "Password",
                                hintStyle: const TextStyle(color: Colors.blueGrey),
                                border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide:const BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                              ),
                            ),
                          
                          const SizedBox(height: 20,),
                          Container(
                             key: _globalKey,
                             width: _width,
                            child: ElevatedButton(
                                style: raisedButtonStyle,
                                child: setUpButtonChild(),
                                onPressed: () {
                                  performLogin();
                                  print(phoneController.text + passwordController.text);
                                },
                              ),
                          ),
                          
                          const SizedBox(height: 15,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have a account? ",style: TextStyle(color: Colors.white)),
                               InkWell(
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => SignupPage()));
                                },
                                child:Text("Create an account",
                                style: TextStyle(color: Constant.secondary,fontWeight: FontWeight.bold))
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // if (MediaQuery.of(context).viewInsets == EdgeInsets.zero)
            // RaisedButton(
            //   padding: const EdgeInsets.all(32.0),
            //   elevation: 0,
            //   textColor: Colors.white,
            //   color: Colors.deepOrange,
            //   child: Text("Continue".toUpperCase()),
            //   onPressed: () {},
            // )
        ],
      ),
    );
  }

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.black87,
  backgroundColor: Constant.primary,
  // minimumSize: Size(88, 36),
  padding: EdgeInsets.symmetric(horizontal: 66),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(25)),
  ),
);
  
}
