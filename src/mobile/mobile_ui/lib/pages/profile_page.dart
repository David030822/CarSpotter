import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/pages/friends_page.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});


  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;   //the image is stored here
  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if(pickedFile != null)
    {
      setState((){
        _image=File(pickedFile.path);  //here the image is set
      }); 
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent, 
      ),
      drawer: const MyDrawer(),
  
      body: ListView(
         children:[
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Center (
              child: Text(
               'Profile page',
                style: GoogleFonts.dmSerifText(
                fontSize: 48,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
          ),
        ),
            const SizedBox(height: 40),
            GestureDetector(
              onTap: _pickImage, // to select the image
            
              child : CircleAvatar(
               radius: 80,
               backgroundImage: _image == null
                  ?  AssetImage('assets/images/DavidBysCars.png') //default image
                  : FileImage(_image!) as ImageProvider<Object>,
              ),
            ),
              
            const SizedBox(height: 20),
            itemProfile('Name','Demeter David', CupertinoIcons.person),
            const SizedBox(height: 20),
            itemProfile('Phone','0765176514', CupertinoIcons.phone),
            const SizedBox(height: 20),
            itemProfile('Email','demeterdavid@gmail.com', CupertinoIcons.mail),
          
        
           
            const SizedBox(height: 20),
        
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FriendsPage(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text(
                        'Go to Friends Page',
                        style: GoogleFonts.dmSerifText(
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ],
                      ),
                ),
              ),
            ],
          
        ),
    );
  }
  

    Widget itemProfile(String title, String subtitle, IconData iconData){
       return  Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0,5),
                      color: Colors.grey.withOpacity(.2),
                      spreadRadius: 5,
                      blurRadius: 10,
                    ),
                  ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: ListTile(
                title: Text(title),
                subtitle: Text(subtitle),
                leading: Icon(iconData),
                trailing: Icon(Icons.arrow_forward,color: Colors.grey),
              
                      
                      
              ),
              ),
            );
     }
  
}