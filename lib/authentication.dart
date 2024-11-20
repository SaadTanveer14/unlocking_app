import 'dart:io';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:unlocking_app/bloc/login_bloc.dart';
import 'package:unlocking_app/bloc/login_event.dart';
import 'package:unlocking_app/bloc/login_state.dart';
import 'package:unlocking_app/helper.dart';
import 'package:unlocking_app/utilities.dart';



// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key, required this.title});
//   final String title;

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   TextEditingController nameController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   bool _obscureText = true;
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   String _biometricState = 'Not authenticated';
//   String? _loginId ;
//   String? _password ;
//   bool authenticated = false;
//   bool isBiometricAvailable = false;
//   bool isLoggedIn = false;
//   bool? offlineStatus;

//   @override
//   void initState() {
//     super.initState();
//     // _initializeDeviceId();

//   }


//   @override
//   Widget build(BuildContext context) {
//    double screenWidth = MediaQuery.of(context).size.width;    
//    return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(width: 1*screenWidth,),
//           Container(
//             width: 0.8 * screenWidth,
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               // mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: nameController,
//                   style: const TextStyle(color: Colors.black),
//                   decoration: const InputDecoration(
//                     labelText: 'Userid',
//                     helperText: 'Enter a valid userid',
//                     labelStyle: TextStyle(color: Colors.grey),
//                     helperStyle: TextStyle(color: Colors.grey),
//                     enabledBorder: OutlineInputBorder(
//                         borderSide:
//                         BorderSide(color: Colors.grey, width: 2.0)),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(color: const Color.fromARGB(255, 36, 36, 36), width: 0.5),
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 20,),

//                 TextField(
//                   obscureText: _obscureText,
//                   style: TextStyle(color: Colors.black),
//                   controller: passwordController,
//                   decoration: InputDecoration(
//                     labelText: 'Passwords',
//                     helperText: 'Password must contain 6 digits',
//                     labelStyle: TextStyle(color: Colors.grey),
//                     helperStyle: TextStyle(color: Colors.grey),
//                     suffixIcon: GestureDetector(
//                       onTap: () {
//                         setState(() {
//                           _obscureText = !_obscureText;
//                         });
//                       },
//                       child: Icon(
//                         color: Colors.grey,
//                         _obscureText
//                             ? Icons.visibility_off
//                             : Icons.visibility,
//                       ),
//                     ),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(color: Colors.grey, width: 2.0),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(color: Colors.grey, width: 0.5),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
        
//           ElevatedButton(child:Text("Login"), onPressed: () {
//             String userid = nameController.text;
//             String password = passwordController.text;
//             _validation(userid, password,);
//           },),
                    
//           SizedBox(height: 20.0,),
//           if(isLoggedIn)
//           GestureDetector(
//             onTap: _authenticate,
//             child: const Icon(
//               Icons.fingerprint,
//               size: 70,
//               color: Colors.blue,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//   // Future<void> _initializeDeviceId() async {
//   //   _loginId = await Storage().getLoginId();
//   //   _password = await Storage().getPassword();
//   //   offlineStatus = await Storage().getOfflineStatus();

//   //   if(_loginId != null){
//   //     setState(() {
//   //       isLoggedIn = true;
//   //       _checkBiometric();
//   //     });
//   //   }
//   // }

//   void _validation(String userid, String password) async{
//     bool isConnected = await Helper().checkInternetConnectivity();
//     if (!isConnected) {
//       Utilities.showSnackbar('Alert', 'Please connect to internet');
//     }else if(nameController.text.isEmpty){
//       Utilities.showSnackbar('Alert', 'Please enter userid');
//     }else if(passwordController.text.isEmpty){
//       Utilities.showSnackbar('Alert', 'Please enter password');
//     }else{
//       _loginPressed(userid, password);
//     }
//   }

//   void _loginPressed(String userid, String passowrd)async {
//     _checkBiometric();
//     print("Login Api Called");
//     // Helper().showLoader(context);
//     // ApiService.userLogin(userid, passowrd, _deviceId,Constants.VersionCode).then((response) async {
//     //   Helper().hideLoader(context);
//     //   if(response is LoginResponse){
//     //     // Utilities.showSnackbar(response.httpCode.toString(), response.httpMessage);
//     //     String? deviceId = await Utilities.getDeviceID();

//     //     // await Storage().storeDeviceId(deviceId!);
//     //     // await Storage().storeToken(response.accessToken!);
//     //     // await Storage().storeFullname(response.fullname!);
//     //     // await Storage().storeHRID(response.hrid!.toString());
//     //     // await Storage().storAudioLimit(response.audioSec.toString());
//     //     // await Storage().storeLoginId(userid);
//     //     // await Storage().storePassword(passowrd);
//     //     // await Storage().storeSuperId(response.superId.toString());

//     //     Get.off(HomePageNew());

//     //   }else if(response is ErrorResponse){
//     //     Utilities.showSnackbar(response.httpCode.toString(), response.httpMessage);
//     //     if(response.httpCode == 406)
//     //     {
//     //       const UpdateApp();
//     //     }
        
//     //   }else{
//     //     Utilities.showSnackbar('400', 'Request Failed');
//     //   }
//     // }).catchError((error) {
//     //   Helper().hideLoader(context);
//     //   // Utilities.showSnackbar('Error', error.toString());
//     //   throw Exception(error);
//     // });
//   }

//   Future<void> _checkBiometric() async {
//     try{
//       isBiometricAvailable = await _localAuthentication.canCheckBiometrics;
//       if(isBiometricAvailable){
//         _authenticate();
//       } else{
//         Utilities.showSnackbar('Alert', 'Biometric authentication is not available on this device');
//       }
//     }catch(e){
//       Utilities.showSnackbar('Alert', e.toString());
//       print(e.toString());
//       throw Exception(e);
//     }
//   }

//   Future<void> _authenticate()async{
//     try{
//       authenticated = await _localAuthentication.authenticate(
//           localizedReason: 'Authenticate to access your account',
//           options: AuthenticationOptions(
//               stickyAuth: true,
//               biometricOnly: true
//           )
//       );
//     }catch(e){
//       Utilities.showSnackbar('Alert', e.toString());
//       print(e.toString());
//       throw Exception(e);
//     }

//     if(authenticated){
//       // offlineStatus! ?  Get.off(HomePageNew()) : _loginPressed(_loginId!, _password!);
//       print('Authenticated');
//     }else{
//       Utilities.showSnackbar('Alert', 'Biometric authentication failed');
//     }

//     setState(() {
//       _biometricState = authenticated ? 'authenticated' : 'Not authenticated';
//     });
//   }

// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc()..add(CheckBiometricAvailability()),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocConsumer<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is AuthenticationSuccess) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Authentication Successful")));
            } else if (state is AuthenticationFailure ||
                state is PasswordValidationFailure) {
              String message =
                  (state is AuthenticationFailure) ? state.message : (state as PasswordValidationFailure).message;
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(message)));
            }
          },
          builder: (context, state) {
            if (state is BiometricCheckSuccess && !state.showInputFields) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state.isBiometricAvailable)
                      GestureDetector(
                        onTap: () => context.read<LoginBloc>().add(AuthenticateUser()),
                        child: const Icon(Icons.fingerprint, size: 70, color: Colors.blue),
                      ),
                    if (state.isFaceAvailable)
                      ElevatedButton(
                        onPressed: () => context.read<LoginBloc>().add(AuthenticateUser()),
                        child: const Text("Use Face ID"),
                      ),
                  ],
                ),
              );
            }

            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: "Chef ID"),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<LoginBloc, LoginState>(
                      builder: (context, state) {
                        bool obscureText = (state is PasswordVisibilityToggled)
                            ? state.obscureText
                            : true;
                        return TextField(
                          controller: passwordController,
                          obscureText: obscureText,
                          decoration: InputDecoration(
                            labelText: "Password",
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () =>
                                  context.read<LoginBloc>().add(TogglePasswordVisibility()),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        String chefId = nameController.text.trim();
                        String password = passwordController.text.trim();
                        if (chefId.isEmpty || password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please fill in all fields")),
                          );
                        } else {
                          context.read<LoginBloc>().add(
                              ValidatePassword(chefId, password));
                        }
                      },
                      child: const Text("Login"),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}