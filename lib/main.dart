import 'dart:developer';
import 'package:bastionex_task/widgets/AlertDIalog/custiom_alert_dialog.dart';
import 'package:bastionex_task/widgets/Buttons/CustomFlatButton.dart';
import 'package:bastionex_task/widgets/CustomTextFormField/CustomTextFormFIeld.dart';
import 'package:bastionex_task/widgets/CustomTextFormField/CustomTextFormFIeldOTP.dart';
import 'package:bastionex_task/widgets/loading_indicator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jailbreak_detection/flutter_jailbreak_detection.dart';
import 'api_manager/api_manager.dart';
import 'configs/app_colors.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final loginKey = GlobalKey<FormState>();
  final userKey = GlobalKey<FormState>();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController otpPhoneController = TextEditingController();
  bool isTryingLoLogin = false;
  bool isOTPSend = false;

  bool? jailbroken;
  bool? developerMode;
  String? _verificationId;
  int? _resendToken;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      checkJailBreak(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Image.asset(
                      "assets/images/welcome_background.png",
                      fit: BoxFit.contain,
                    ),
                  )),
                  Expanded(
                    child: Form(
                      key: loginKey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: const EdgeInsets.all(16),
                              color: lightBackgroundColor,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 32,
                                  ),
                                  CustomTextFieldWidget(
                                      controller: userPhoneController,
                                      fieldType: 1,
                                      readOnly: isOTPSend,
                                      hintText: "Phone",
                                      validator: (val) {
                                        if (val == null || val.isEmpty) {
                                          return "Phone should not be empty";
                                        } else if (val.length != 10) {
                                          return "Phone should contains 10 digits";
                                        }
                                        return null;
                                      },
                                      title: "Phone"),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  isOTPSend == false
                                      ? const SizedBox()
                                      : CustomTextFieldWidgetOTP(
                                          controller: otpPhoneController,
                                          hintText: "OTP",
                                          validator: (val) {
                                            if (val == null || val.isEmpty) {
                                              return "Enter a valid otp";
                                            } else if (val.length != 6) {
                                              return "Enter a valid otp";
                                            }
                                            return null;
                                          },
                                          title: "OTP"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomFlatButton(
                                      text: isOTPSend == false
                                          ? "Get OTP"
                                          : "Verify OTP",
                                      buttonWidth: double.maxFinite,
                                      onTap: () {
                                        if (isTryingLoLogin == true) {
                                          return;
                                        }
                                        if (loginKey.currentState!.validate()) {
                                          isTryingLoLogin = true;
                                          if (isOTPSend == true) {
                                            signInWithPhoneNumber();
                                          } else {
                                            login();
                                          }
                                        }
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomFlatButton(
                                      text: "Run jail break and root detection",
                                      buttonWidth: double.maxFinite,
                                      onTap: () async {
                                        bool? jailbroken;
                                        bool? developerMode;
                                        try {
                                          jailbroken =
                                              await FlutterJailbreakDetection
                                                  .jailbroken;
                                          developerMode =
                                              await FlutterJailbreakDetection
                                                  .developerMode;
                                        } catch (e) {}

                                        if (jailbroken != false &&
                                            developerMode != false) {
                                          log("Device is either on developer mode or jail broken");
                                          showDialog(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return showAlert(
                                                  context: context,
                                                  content:
                                                      "Device is either on developer mode or jail broken",
                                                  submit: "Okay",
                                                  onPressed: (() async {
                                                    Navigator.pop(context);
                                                  }));
                                            },
                                          );
                                          return;
                                        } else {
                                          log("Device is not on developer mode or jail broken");
                                          showDialog(
                                            context: context,
                                            barrierColor: Colors.transparent,
                                            builder: (BuildContext context) {
                                              return showAlert(
                                                  context: context,
                                                  content:
                                                      "Device is not jail broken, developer mode or rooted",
                                                  submit: "Okay",
                                                  onPressed: (() async {
                                                    Navigator.pop(context);
                                                  }));
                                            },
                                          );
                                        }
                                      }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomFlatButton(
                                      text: "Check SSL Pining API",
                                      buttonWidth: double.maxFinite,
                                      onTap: () async {
                                        var data = await ApiManager().getData();
                                        showDialog(
                                          context: context,
                                          barrierColor: Colors.transparent,
                                          builder: (BuildContext context) {
                                            return showAlert(
                                                context: context,
                                                content: data.body.toString(),
                                                submit: "Okay",
                                                onPressed: (() async {
                                                  Navigator.pop(context);
                                                }));
                                          },
                                        );
                                      }),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom))
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              isTryingLoLogin == true
                  ? const LoadingIndicator()
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  void checkJailBreak(BuildContext context) async {
    try {
      jailbroken = await FlutterJailbreakDetection.jailbroken;
      developerMode = await FlutterJailbreakDetection.developerMode;
    } catch (e) {}

    if (jailbroken != false && developerMode != false) {
      log("Device is either on developer mode or jail broken");
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return showAlert(
              content: "Device is either on developer mode or jail broken",
              submit: "Okay",
              context: context,
              onPressed: (() async {
                Navigator.pop(context);
              }));
        },
      );
      return;
    }

    checkLoggedInUser();
  }

  void checkLoggedInUser() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    isTryingLoLogin = true;
    setState(() {});
    User? user = await _auth.currentUser;
    isTryingLoLogin = false;
    if (user != null) {
      await _auth.signOut();
      log(user.phoneNumber.toString());
    }
    setState(() {});
  }

  void login() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    isTryingLoLogin = true;
    setState(() {});
    //
    await _auth
        .verifyPhoneNumber(
      phoneNumber: '+91${userPhoneController.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // Auto-retrieve verification code
        await _auth.signInWithCredential(credential);
        isTryingLoLogin = false;
        log('Verification Success auto');

        setState(() {});
        checkLoggedInUser();
      },
      verificationFailed: (FirebaseAuthException e) {
        log('Verification failed: ${e.message}');
        isTryingLoLogin = false;
        isOTPSend = false;

        setState(() {});
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return showAlert(
                content: "Phone verification failed",
                submit: "Okay",
                context: context,
                onPressed: (() async {
                  Navigator.pop(context);
                }));
          },
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        _resendToken = resendToken;
        isTryingLoLogin = false;
        isOTPSend = true;

        setState(() {});
        log('Verification code sent $_verificationId');
        showDialog(
          context: context,
          barrierColor: Colors.transparent,
          builder: (BuildContext context) {
            return showAlert(
                content:
                    "Verification code send to ${userPhoneController.text}",
                submit: "Okay",
                context: context,
                onPressed: (() async {
                  Navigator.pop(context);
                }));
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        isTryingLoLogin = false;

        setState(() {});
        log('Verification timeout1');
      },
    )
        .onError((error, stackTrace) {
      isTryingLoLogin = false;

      setState(() {});
    });
  }

  void signInWithPhoneNumber() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    isTryingLoLogin = true;
    setState(() {});
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: otpPhoneController.text,
      );
      await _auth.signInWithCredential(credential);
      isTryingLoLogin = false;
      log('Verification Success');

      setState(() {});
      showDialog(
        context: context,
        barrierColor: Colors.transparent,
        builder: (BuildContext context) {
          return showAlert(
              content: "OTP Verification Successes.",
              submit: "Logout",
              context: context,
              onPressed: (() async {
                Navigator.pop(context);
                isOTPSend = false;
                isTryingLoLogin = false;
                userPhoneController.clear();
                otpPhoneController.clear();
                setState(() {});
              }));
        },
      );
    } catch (e) {
      isTryingLoLogin = false;
      log('Error signing in: $e');

      setState(() {});
    }
  }
}
