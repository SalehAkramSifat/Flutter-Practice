import 'package:flutter/material.dart';
import 'package:flutter_practice/back_end/auth.dart';
import 'login_screen.dart';

class CreateScreen extends StatefulWidget{
  @override
  _CreateScreenState createState()=> _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen>{
  final _auth = AuthSetup();

  TextEditingController _user = TextEditingController();
  TextEditingController _password = TextEditingController();


  @override
  void dispose(){
    _user.dispose();
    _password.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child:Padding(padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text("Create Account",
                  style: TextStyle(color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 40),),


                SizedBox(height: 10),
                TextField(
                  controller: _user,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Please Enter your username"),),


                SizedBox(height: 15),
                TextField(
                   controller: _password,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Please Enter Password"),obscureText: true,),


                SizedBox(height: 20,),
                SizedBox(width: double.infinity,
                  child: ElevatedButton(onPressed: _SignUp, child: Text('SignUp',
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold),)),),


                SizedBox(height: 30),
                Center(child:
                TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));},
                    child: Text('Already you have account?',
                      style: TextStyle(color: Colors.green,),))

                )],),
          ),
        ));
  }
  _SignUp() async {
    if (_user.text.isEmpty || _password.text.isEmpty) {
      return;
    }
    try {
      final user = await _auth.createUserWithEmailAndPassword(
          _user.text.trim(), _password.text.trim());
      if (user == null) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Verification email sent. Please check your inbox.")));
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.toString()}")));
    }
  }
}