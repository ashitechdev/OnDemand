import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Step 1 -  shared_preferences: ^0.5.12+4
/// 2 - pub get
/// 3 Start following from the code below
///

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool logged = false;
  // getting isloggedin? data from shared prefs as soon as app starts
  @override
  void initState() {
    getShredValued();
  }

  getShredValued() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    logged = prefs.getBool('isLoggedIn');
    print(logged);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: logged == true ? MyHomePage2() : LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  String email = "ashi123@gmail.com";
  String password = 'passwordie';

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login please")),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.lightBlueAccent[100],
              Colors.deepPurpleAccent[100],
              Colors.white70
            ], end: Alignment.bottomRight, begin: Alignment.topLeft),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("use email - $email"),
              Text("use password - $password"),
              SizedBox(
                height: 100,
              ),
              TextField(
                controller: emailController,
              ),
              TextField(
                controller: passController,
              ),
              SizedBox(
                height: 100,
              ),
              FlatButton(
                onPressed: () async {
                  if (emailController.text == email &&
                      passController.text == password) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setBool('isLoggedIn', true);
                    print(
                        'Is the bool isLoggedIn saved in shared prefs ? - ${prefs.getBool("isLoggedIn")}');
                    prefs.setString('user1mail', emailController.text);
                    prefs.setString('user1pass', passController.text);
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return MyHomePage2();
                    }));
                  } else {
                    Scaffold.of(context).showSnackBar(
                        SnackBar(content: Text('Fill correct details')));
                  }
                },
                child: Text("Login "),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyHomePage2 extends StatefulWidget {
  @override
  _MyHomePage2State createState() => _MyHomePage2State();
}

class _MyHomePage2State extends State<MyHomePage2> {
  bool isuserloggedin = false;

  String userEmail;

  String userPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Screen 1"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            // user is logged-in in the app but we are just fetching data on a new screen with the click of a button
            isuserloggedin == false
                ? FlatButton(
                    child: Text("get saved user details"),
                    onPressed: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      // key must be same as when we saved the value
                      // key is the unique identity used to create , read , update or delete any value
                      setState(() {
                        isuserloggedin = prefs.getBool('isLoggedIn');
                        userEmail = prefs.getString('user1mail');
                        userPassword = prefs.getString('user1pass');
                      });
                    },
                  )
                : Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("yes user is logged in"),
                        Text("users stored credentials"),
                        userEmail == null
                            ? Text("Email deleted")
                            : Text(userEmail),
                        userPassword == null
                            ? Text("password deleted")
                            : Text(userPassword),
                        SizedBox(height: 150),
                        FlatButton(
                          child: Text("Logout"),
                          onPressed: () async {
                            /// setting is logged in value as false -> results in
                            /// appearing of login screen when user again opens the app
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setBool('isLoggedIn', false);
                            prefs.setString("user1mail", null);
                            prefs.setString("user1pass", null);
                            // user logged out and we push him to Loggin Screen
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return LoginPage();
                            }));
                          },
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
