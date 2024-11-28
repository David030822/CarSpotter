import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_ui/components/my_drawer.dart';
import 'package:mobile_ui/constants.dart';
import 'package:mobile_ui/models/user.dart';
import 'package:mobile_ui/pages/friends_page.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  final User user;
  const ProfilePage({super.key, required this.user});

  @override
  // ignore: library_private_types_in_public_api
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;   //the image is stored here
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

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

  void Function()? editProfile(User user) {
    // set the current name, phone and email
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _phoneController.text = user.phoneNum;
    _emailController.text = user.email;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          children: [
            TextField(
              controller: _firstNameController,
            ),
            TextField(
              controller: _lastNameController,
            ),
            TextField(
              controller: _phoneController,
            ),
            TextField(
              controller: _emailController,
            ),
          ],
        ),
        actions: [
          // save button
          MaterialButton(
            onPressed: () {
              // get the new first name
              String newFirstName = _firstNameController.text;
              String newLastName = _lastNameController.text;
              String newPhone = _phoneController.text;
              String newEmail = _emailController.text;

              // save to constants (replace with save to db later)
              setState(() {
                users[0].firstName = newFirstName;
                users[0].lastName = newLastName;
                users[0].email = newEmail;
                users[0].phoneNum = newPhone;
              });

              // pop box
              Navigator.pop(context);

              // clear controllers
              _firstNameController.clear();
              _lastNameController.clear();
              _phoneController.clear();
              _emailController.clear();
            },
            child: const Text('Save'),
          ),

          // cancel button
          MaterialButton(
            onPressed: () {
              // pop box
              Navigator.pop(context);

              // clear controllers
              _firstNameController.clear();
              _lastNameController.clear();
              _phoneController.clear();
              _emailController.clear();
            },
            child: const Text('Cancel'),
          ),
        ],
      )
    );
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
              backgroundImage: _image != null ? FileImage(_image!) as ImageProvider<Object> : null,
              child: _image == null
                  ? ClipOval(
                      child: Image.asset(
                        widget.user.profileImagePath,
                        width: 160, // Set a width for the image
                        height: 160, // Set a height for the image
                        fit: BoxFit.cover, // Ensures the image fits well within the circular frame
                      ),
                    )
                  : null,
              ),
            ),
              
            const SizedBox(height: 10),
            itemProfile('Name', '${widget.user.firstName} ${widget.user.lastName}' , CupertinoIcons.person),
            const SizedBox(height: 10),
            itemProfile('Phone', widget.user.phoneNum, CupertinoIcons.phone),
            const SizedBox(height: 10),
            itemProfile('Email', widget.user.email, CupertinoIcons.mail),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: () => editProfile(widget.user),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.edit,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      'Edit Profile',
                      style: GoogleFonts.dmSerifText(
                        fontSize: 24,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 15),

            GestureDetector(
                onTap: () {
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
                        'Go to Friends Page ',
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
       return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        offset: const Offset(0,5),
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
                  // trailing: const Icon(Icons.arrow_forward,color: Colors.grey),     
                ),
              ),
            );
     }
}