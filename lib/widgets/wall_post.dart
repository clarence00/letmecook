import 'package:flutter/material.dart';

class WallPost extends StatelessWidget {
  final String message;
  //final String user;

  
  const WallPost({
    super.key,
    required this.message,
   // required this.user,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),

      margin: EdgeInsets.only(top: 25,left: 25,right: 25),
      padding: EdgeInsets.all(25),


      child: Row(
        children: [
          //Profile Picture
          Container(
            decoration: 
              BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[400]
              ),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.person,
              color: Colors.white,
            ),
          ),

          const SizedBox(width: 20,),


          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text(
              "Email@example.com",
              style: TextStyle(color: Color.fromARGB(255, 99, 98, 98))
              ),
            const SizedBox(height: 10),
            Text(message),
    
          ],
          )
    
        ],
      ),
    );


  }
}