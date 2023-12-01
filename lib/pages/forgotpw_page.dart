import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:letmecook/utils.dart';
import 'package:letmecook/widget_tree.dart';


class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void dispose () {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text('Forgot Password'),

    ),


    body: Padding(
      padding: EdgeInsets.all(16),
      child: Form(
        key:formKey,
        child: Column (
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Receive an email to reset your password',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            ),

            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: 'Email'),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                email != null && !EmailValidator.validate(email)
                      ? 'Enter a valid email'
                      :null,

            ),

            SizedBox(height: 20,),
            ElevatedButton.icon(
              style:ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50)
              ),
              icon: Icon(Icons.email_outlined),
              label:Text(
                'Reset Password',
                style: TextStyle(fontSize: 24),
              ),

              onPressed: resetPassword,
            )

          ],
          )
        ),
      )
    );


    Future resetPassword() async {

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: (emailController.text.trim()));
      //insert snackbar or popup to indicate email has been sent
      Utils.showSnackBar('Password Reset Email has been sent.');
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => WidgetTree()));

    } on FirebaseAuthException catch (e) {
      print(e);


      Utils.showSnackBar(e.message);
    }
    }
    }