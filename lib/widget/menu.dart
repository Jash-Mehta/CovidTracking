import 'package:covid_tracking/screen/sendrequest.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const DrawerHeader(
              child: CircleAvatar(
            backgroundColor: Colors.grey,
            radius: 50.0,
          )),
          const Center(
            child: Text(
              'Jash Mehta',
              style: TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const ListTile(
            leading: Icon(
              Icons.home,
              color: Color(0xFFE53935),
              size: 33,
            ),
            title: Text(
              "Dashboard",
              style: TextStyle(
                  color: Color(0xFFE53935),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          ListTile(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => Sendrequest()));
            },
            leading: const Icon(
              CupertinoIcons.dot_radiowaves_left_right,
              color: Color(0xFFEF7C00),
              size: 33,
            ),
            title: Text(
              "Send Request",
              style: TextStyle(
                  color: Color(0xFFEF7C00),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.upload_circle,
              color: Color(0xFF689F38),
              size: 33,
            ),
            title: Text(
              "Profile",
              style: TextStyle(
                  color: Color(0xFF689F38),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          const ListTile(
            leading: Icon(
              CupertinoIcons.info,
              color: Color(0xFF1976D2),
              size: 33,
            ),
            title: Text(
              "About Me",
              style: TextStyle(
                  color: Color(0xFF1976D2),
                  fontSize: 17.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 110),
          ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(45.0))),
                  elevation: MaterialStateProperty.all<double>(10.0),
                  shadowColor: MaterialStateProperty.all<Color>(Colors.black87),
                  side: MaterialStateProperty.all(
                      BorderSide(color: Colors.blue.shade700, width: 3)),
                  backgroundColor: MaterialStateProperty.all(Colors.white)),
              child: Container(
                height: 50.0,
                width: 150.0,
                child: const Center(
                    child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.black),
                )),
              ))
        ],
      ),
    );
  }
}
