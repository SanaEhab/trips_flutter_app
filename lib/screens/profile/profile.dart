import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constants/edit_text_box.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final currentUser = FirebaseAuth.instance.currentUser;
  final userCollection = FirebaseFirestore.instance.collection("Users");


  Future<void> editField (String field) async{
    String newValue = "";
    await showDialog(
        context: context,
        builder: (context)=>AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Edit" +field,
            style: const TextStyle(color: Colors.white),),
          content: TextField(
            autofocus: true,
            style: const TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
                hintText: "Enter new $field",
                hintStyle: const TextStyle(
                    color: Colors.grey
                )
            ),
            onChanged: (value){
              newValue = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel',style: TextStyle(color: Colors.white),)
            ),
            TextButton(
                onPressed: () => Navigator.of(context).pop(newValue),
                child: const Text('Save',style: TextStyle(color: Colors.white),)
            ),
          ],
        ));
    if(newValue.trim().length > 0){
      await userCollection.doc(currentUser!.email).update({field: newValue});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyle(color: Colors.white),),
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.grey[900],
          centerTitle: true,
        ),
        body: StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance.collection("Users").doc(currentUser!.email).snapshots(),
          builder: (context,snapshot){
            if(snapshot.hasData){
              final userData = snapshot.data!.data() as Map<String,dynamic>;
              return ListView(
                children: [
                  const SizedBox(height: 80.0),
                  const Icon(Icons.person, size: 72,),
                  Text(
                    currentUser!.email!,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500
                    ),
                  ),
                  const SizedBox(
                    height: 50.0,
                  ),
                  EditTextBox(
                      sectionName: 'User name',
                      text: userData['username'],
                      onPressed: ()=>editField('username')
                  ),
                ],
              );
            } else if(snapshot.hasError){
              return Center(
                child: Text('Error${snapshot.error}'),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        )
    );
  }
}
