import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,body: Column(
      children: const [
         DrawerHeader(child: CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 50.0,
        )),
        Center(child: Text('Jash Mehta',style: TextStyle(color: Colors.black,fontSize:23,),),

       ),
       SizedBox(
         height: 20.0,
       ),
       ListTile(
         leading: Icon(Icons.home,color: Color(0xFFE53935),size: 33,),
         title: Text("Dashboard",style: TextStyle(
           color: Color(0xFFE53935),
           fontSize: 17.0,
           fontWeight: FontWeight.w500
         ),),
       ),
              SizedBox(
         height: 15.0,
       ),
       ListTile(
         leading:Icon(CupertinoIcons.dot_radiowaves_left_right,color: Color(0xFFEF7C00),size: 33,),
         title: Text("Send Request",style: TextStyle(
           color: Color(0xFFEF7C00),
           fontSize:17.0,
           fontWeight: FontWeight.w500
         ),),
        
       ),
                     SizedBox(
         height: 15.0,
       ),
       ListTile(
         leading:Icon(CupertinoIcons.upload_circle,color: Color(0xFF689F38),size: 33,),
         title: Text("Profile",style: TextStyle(
           color: Color(0xFF689F38),
           fontSize:17.0,
           fontWeight: FontWeight.w500
         ),),
        
       ),
                    SizedBox(
         height: 15.0,
       ),
       ListTile(
         leading:Icon(CupertinoIcons.person_fill,color: Color(0xFF1976D2),size: 33,),
         title: Text("About Me",style: TextStyle(
           color: Color(0xFF1976D2),
           fontSize:17.0,
           fontWeight: FontWeight.w500
         ),),
        
       ),

        ],
    ),);
  }
}
