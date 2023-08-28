import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sleep_monitor_admin/home.dart';
import 'firebase_options.dart';

Future<void> main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var emailController=TextEditingController();
  var passwordController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text('Sleep Monitor Admin'),
        backgroundColor: Colors.blue.shade300,
      ),
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 500,
            width: 400,
            child: Column(
              children: [
                Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 32, bottom: 16),
                    width: double.infinity,
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    width: double.infinity,
                    child: const Text(
                      "Email",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(color: Colors.blue.shade200),
                    width: double.infinity,
                    child: TextField(
                      controller: emailController,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Please Enter email",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                Container(
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    width: double.infinity,
                    child: const Text(
                      "Password",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Container(
                    margin: EdgeInsets.only(
                        left: 16, right: 16, top: 16, bottom: 16),
                    padding: EdgeInsets.only(left: 16),
                    decoration: BoxDecoration(color: Colors.blue.shade200),
                    width: double.infinity,
                    child:  TextField(
                      obscureText: true,
                      controller: passwordController,
                      style: TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Please Enter password",
                          hintStyle: TextStyle(color: Colors.white)),
                    )),
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.only(top: 32, left: 16, right: 16),
                  child: ElevatedButton(
                      onPressed: () {
                        if(emailController.text=='admin' && passwordController.text=='123456'){
                          FirebaseAuth.instance.signInWithEmailAndPassword(email: "admin@admin.com", password: "123456");
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Home()));
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        height: 50,
                        child: Text(
                          "Login",
                          textAlign: TextAlign.center,
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
