import 'package:flutter/material.dart';
import 'package:flutter_practice/back_end/auth.dart';
import 'package:flutter_practice/screen/signup_screen.dart';

class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState()=> _LoginScreenState();

}

class _LoginScreenState extends State<LoginScreen>{
  final _auth = AuthSetup();

  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  void dispose(){
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text("Login",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),),

                SizedBox(height: 10),
                TextField(
                  controller: _userName,
                  decoration: InputDecoration
                  (border: OutlineInputBorder(),
                    labelText: "Please Enter your email address"),),

                SizedBox(height: 15),
                TextField(
                  controller: _password,
                  decoration: InputDecoration
                  (border: OutlineInputBorder(),
                    labelText: "Please Enter your Password"),obscureText: true,),

                SizedBox(height: 20),
                SizedBox(width: double.infinity,child:
                ElevatedButton(onPressed: _login,child: Text("Login"),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlueAccent,elevation: 3),),),

                SizedBox(height: 20,),
                Center(child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateScreen()));

                  },
                  child: Text("Create a new Account"),)

                )],),),)
    );
  }
  _login() async {
    if (_userName.text.isEmpty || _password.text.isEmpty){
      return;
    }
    try {
      final user = await _auth.loginUserWithEmailAndPassword(_userName.text.trim(), _password.text.trim());
      if (user == null){
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Invalid email or password")),);
        return;
      }

    }catch (e) {ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Error: ${e.toString()}")),
    );
  }
}
}