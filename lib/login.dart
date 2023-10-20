

import 'dart:convert';

import 'package:flutter/material.dart';
import 'test.dart' as test;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
// void main() {
//   runApp(const login());
// }

class login extends StatelessWidget {
  const login({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ARCHIVI APP',
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  // const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  Future login() async {
    
    var url = Uri.http("192.168.35.163", './lib/login.php', {'q': '{http}'});
    print("ok");
    var response = await http.post(url, body: {
      "username": user.text,
      "password": pass.text,
    });
    var data = json.decode(response.body);
    print(data);
    if (data.toString() == "Success") {
      Fluttertoast.showToast(
        msg: 'Login Successful',
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_SHORT,
      );
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  test.MyApp(),
        ),
      );
    } else {
      Fluttertoast.showToast(
        backgroundColor: Colors.red,
        textColor: Colors.white,
        msg: 'Username and password invalid',
        toastLength: Toast.LENGTH_SHORT,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(Icons.map),
          backgroundColor: Colors.blue,
          title: const Text("Login Page",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  )),
        ),
        body: SingleChildScrollView( 
            child : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            //  Padding(
            //  padding: const EdgeInsets.only(top: 0),
            //   child: Center(
                // child: 
                Container(
                    // child:  Text("GEORSEC APP",style: TextStyle(color: Colors.white,fontSize: 26),),
                   
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height*0.5,

                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage('assets/images/loginfinalBeraki.jpg'),fit: BoxFit.contain),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(50.0)),
                        
                        
                        
            ),
            
            // ),),

              TextField(
                
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Entrez votre addresse email",
                  icon: Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                keyboardType: TextInputType.text,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Entrez votre mot de passe",
                  icon: Icon(
                    Icons.lock,
                    color: Colors.blue,
                    size: 25,
                  ),
                ),
                keyboardType: TextInputType.text,
                obscureText: true,
              ),
              SizedBox(height: 20.0),
                Text(
          "FORGOT PASSWORD?",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1C1C1C),
            height: 1,
          ),),
               Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Center(
                child: Container(
                    width: 150,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(50.0)),
                        child: ElevatedButton(
                onPressed: () {
                  // login();
                  Navigator.push(
                              
                      context, MaterialPageRoute(builder: (_) => test.MyApp()));
                },
                    child: const Text("Log in",style: TextStyle(color: Colors.white,fontSize: 25),),
              ),
            ),
            ),),
              // ElevatedButton(
              //     onPressed: null,
              //     child: Text("Se Connecter",
              //         style: TextStyle(color: Colors.white, fontSize: 25))),
            
            ],
          ),
          
          
          )
          
         
        );
  }
}
