import 'package:employee_app/ui/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  const Profile({
    Key? key,
  }) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late SharedPreferences logindata;
  String name = '';
  String email = '';
  String phone = '';
  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      // name = logindata.getString('name')!;
      email = logindata.getString('email')!;
      //  phone = logindata.getString('phone')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Profile Details",
        style: TextStyle(color: Colors.white),
      )),
      body: Center(
        child: Column(
          children: [
            Text(name.toString()),
            Text(
              'WELCOME $email',
            ),
            Text(phone),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: Colors.grey.shade700,
              onPressed: () {
                logindata.setBool('login', true);
                Navigator.pushReplacement(context,
                    new MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
