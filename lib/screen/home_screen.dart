import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("SQLite Database"),
      centerTitle: true,backgroundColor: Colors.blue,),

      body: Center(child: Padding(padding: EdgeInsets.all(15),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(padding: EdgeInsets.all(15)),
            TextField(decoration: InputDecoration(labelText: "Enter Your Text",
            border: OutlineInputBorder()),
              minLines: 1, maxLines: 3,),

            Align(alignment: Alignment.centerLeft,
                child: TextButton(onPressed: (){}, child: Text('Save'),
                    style: TextButton.styleFrom(backgroundColor: Colors.black26,),)),

            SizedBox(height: 20),


      ],),










    )));
  }

}