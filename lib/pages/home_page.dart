import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letmecook/assets/icons/logos.dart';
import 'package:letmecook/assets/themes/app_colors.dart';
import 'package:letmecook/widgets/styled_text.dart';
import 'package:letmecook/widgets/textField.dart';
import 'package:letmecook/assets/icons/custom_icons.dart';
import 'package:letmecook/widgets/wall_post.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  
  

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // Username display (uncomment as needed)
  // final currentUSer = FirebaseAuth.instance.currentUser;
  
  //text controller
  final textController = TextEditingController();

  void postMessage() {
    if(textController.text.isNotEmpty){
      FirebaseFirestore.instance.collection("User Posts").add({
        'Message':textController.text,
        'TimeStamp': Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        
        // LET ME COOK TEXT //
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Logos.letMeCookLogoSmall,
              SizedBox(
                width: 15,
              ),
              StyledText(
                text: 'LET ME COOK',
                color: AppColors.light,
                size: 32,
                weight: FontWeight.w700,
              )
            ],
          ) 
        ),
      ),

      body: Center(
        child: Column(
          children: [
            
            // Wall Display (boxes)
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                .collection("User Posts")
                .orderBy(
                  "TimeStamp",
                  descending: false,
                )
                .snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: ((context, index) {
                      final post = snapshot.data!.docs[index];
                      return WallPost(
                        message: post['Message'], 
                        //user: post['UserName']
                        );

                    }
                    )
                    );
                  } else if (snapshot.hasError){
                    return Center(
                      child: Text('Error:' + snapshot.error.toString()),
                    );

                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );


                },
                ),
              ),
            
      
            // Post message section
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Row(
                children: [
                  Expanded(
                    child: MyTextField(
                      controller: textController,
                      hintText: 'Post a new recipe!',
                      obscureText: false,
                      )
                    ),
            
                    // Post button
                    IconButton(
                      onPressed: postMessage, 
                      icon: const Icon(Icons.arrow_circle_up))
            
            
            
                ],
              ),
            )
      
            // Logged in as : section
      
            //Text("Logged in as : " + currentUser.email )
      

      
          ],
        ),
      ),
      

    );
  }
}