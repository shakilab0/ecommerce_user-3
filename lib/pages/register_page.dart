import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

import '../auth/auth_service.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../utils/all_color_pro.dart';
import '../utils/helper_functions.dart';
import 'launcher_page.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _errMsg = '';
  late UserProvider userProvider;
  bool isAnonymous = false;

  @override
  void initState() {
    isAnonymous=AuthService.currentUser==null?false:AuthService.currentUser!.isAnonymous;
    //_passwordController.text = '123456';
    super.initState();
  }

  @override
  void didChangeDependencies() {
    userProvider = Provider.of<UserProvider>(context, listen: false);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/background.jpg'),
                    fit: BoxFit.cover)
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: transparentYellow,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 3),
                welcomeBack,
                subTitle,
                const Spacer(flex: 2),
                SizedBox(
                  height: 280,
                  child: Form(
                    key: _formKey,
                    child:Stack(
                      children: [
                        Container(
                          height: 180,
                          width: MediaQuery.of(context).size.width,
                          decoration:  BoxDecoration(
                            color: const Color.fromRGBO(255, 255, 255, 0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Column(
                            children: [
                              TextFormField(
                                controller: _emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  prefixIcon: Icon(Icons.email),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 5,),
                              TextFormField(
                                controller: _passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'This field must not be empty';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 65,
                          left: MediaQuery.of(context).size.width / 4,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                        colors: [
                                          Color.fromRGBO(236, 60, 3, 1),
                                          Color.fromRGBO(234, 60, 3, 1),
                                          Color.fromRGBO(216, 78, 16, 1),
                                        ],
                                        begin: FractionalOffset.topCenter,
                                        end: FractionalOffset.bottomCenter),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Color.fromRGBO(0, 0, 0, 0.16),
                                        offset: Offset(0, 5),
                                        blurRadius: 10.0,
                                      )
                                    ],
                                    borderRadius: BorderRadius.circular(9.0)),
                                height: 65,
                                width: MediaQuery.of(context).size.width / 2,
                                child: TextButton(
                                  onPressed: (){
                                    _authenticate(false);
                                  },
                                  child: const Text("Register",
                                    style: TextStyle(
                                        color: Color(0xfffefefe),
                                        fontWeight: FontWeight.w600,
                                        fontStyle: FontStyle.normal,
                                        fontSize: 25.0),
                                  ),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ) ,
                  ),
                ),

                const Spacer(flex: 1),
                Column(
                  children: [
                    const Text('You can sign in with',
                      style: TextStyle(fontSize: 15.0, fontStyle: FontStyle.italic, color: Colors.white),
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: (){},
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: 50,
                            child: Image.asset("assets/f.png",color: Colors.white,),
                          ),
                        ),
                        const SizedBox(width: 17,),
                        InkWell(
                          onTap: (){
                            _signInWithGoogleAccount();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: 50,
                            child: Image.asset("assets/g.png"),
                          ),
                        ),
                        const SizedBox(width: 17,),
                        InkWell(
                          onTap: () {
                            EasyLoading.show(status: "Please Wait");
                            AuthService.signInAnonymously().then((value){
                              EasyLoading.dismiss();
                              Navigator.pushReplacementNamed(context, LauncherPage.routeName);
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 50,
                            width: 50,
                            child: Column(
                              children: const [
                                Icon(Icons.directions_walk,size: 30,color: Colors.white,),
                                Text("Guest",style: TextStyle(color: Colors.white,fontSize: 15),)
                              ],
                            ),
                            //child: Icon(Icons.directions_walk,size: 30,color: Colors.white,)
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                const Spacer(),

              ],
            ),
          ),

        ],
      ),
    );
  }

  void _authenticate(bool tag) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: 'Please wait', dismissOnTap: false);
      final email = _emailController.text;
      final password = _passwordController.text;
      try {
        if (tag) {
          await AuthService.login(email, password);
          EasyLoading.dismiss();
        } else {
          if (AuthService.currentUser != null) {
            final credential =
            EmailAuthProvider.credential(email: email, password: password);
            await convertAnonymousUserIntoRealAccount(credential);
          } else {
            await AuthService.register(email, password);
            final userModel = UserModel(
              userId: AuthService.currentUser!.uid,
              email: AuthService.currentUser!.email!,
              userCreationTime: Timestamp.fromDate(
                  AuthService.currentUser!.metadata.creationTime!),
            );
            userProvider.addUser(userModel).then((value) {
              EasyLoading.dismiss();
            }).catchError((error) {
              EasyLoading.dismiss();
              showMsg(context, 'could not save user info');
            });
          }
        }
        if (mounted) {
          if (isAnonymous) {
            Navigator.pop(context);
          } else {
            Navigator.pushReplacementNamed(context, LauncherPage.routeName);
          }
        }
      } on FirebaseAuthException catch (error) {
        EasyLoading.dismiss();
        setState(() {
          _errMsg = error.message!;
        });
      }
    }
  }


  void _signInWithGoogleAccount() async {
    try {
      final credential = await AuthService.signInWithGoogle();
      final userExists = await userProvider.doesUserExist(credential.user!.uid);
      if (!userExists) {
        EasyLoading.show(status: 'Redirecting user...');
        final userModel = UserModel(
          userId: credential.user!.uid,
          email: credential.user!.email!,
          userCreationTime: Timestamp.fromDate(DateTime.now()),
          displayName: credential.user!.displayName,
          imageUrl: credential.user!.photoURL,
          phone: credential.user!.phoneNumber,
        );
        await userProvider.addUser(userModel);
        EasyLoading.dismiss();
      }
      if (mounted) {
        Navigator.pushReplacementNamed(context, LauncherPage.routeName);
      }
    } catch (error) {
      EasyLoading.dismiss();
      rethrow;
    }
  }


  Future<void> convertAnonymousUserIntoRealAccount(
      AuthCredential credential) async {
    try {
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential);
      if (userCredential!.user != null) {
        final userModel = UserModel(
          userId: AuthService.currentUser!.uid,
          email: AuthService.currentUser!.email!,
          userCreationTime: Timestamp.fromDate(
              AuthService.currentUser!.metadata.creationTime!),
        );
        userProvider.addUser(userModel).then((value) {
          EasyLoading.dismiss();
        }).catchError((error) {
          EasyLoading.dismiss();
          showMsg(context, 'could not save user info');
        });
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "provider-already-linked":
          print("The provider has already been linked to the user.");
          break;
        case "invalid-credential":
          print("The provider's credential is not valid.");
          break;
        case "credential-already-in-use":
          print("The account corresponding to the credential already exists, "
              "or is already linked to a Firebase User.");
          break;
      // See the API reference for the full list of error codes.
        default:
          print("Unknown error.");
      }
    }
  }
}



Widget welcomeBack = const Text('Glad To Meet You. ',
  style: TextStyle(
      color: Colors.white,
      fontSize: 34.0,
      fontWeight: FontWeight.bold,
      shadows: [
        BoxShadow(
          color: Color.fromRGBO(0, 0, 0, 0.15),
          offset: Offset(0, 5),
          blurRadius: 10.0,
        )
      ]),
);

Widget subTitle = const Padding(
    padding: EdgeInsets.only(right: 1.0),
    child: Text('Create your new account for \n future user',
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,
      ),
    ));





