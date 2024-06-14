import 'package:flutter/material.dart';
import 'package:form/detailspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  // User input values
  String chn = "";
  String email = "";
  String pw = "";
  String crn = "";

 /* bool entertainment = false;
  bool tech = false;
  bool others = false;
  bool education = false; */

  // TextEditingController controller's form clearing the textform fields
  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelOwnerController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  final FocusNode channelNameFocusNode = FocusNode();
  final FocusNode channelOwnerFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Function for Register button
  List<bool> channelTypes = [false, false, false, false];

// Function for Register button
void trysubmit() {
  // Check if all form fields are valid, password is not empty, and at least one checkbox is selected
  final isValid = formKey.currentState?.validate();
  final bool isPasswordNotEmpty = pw.isNotEmpty;
  final bool isAtLeastOneCheckboxSelected = channelTypes.contains(true);

  if (chn.isEmpty || crn.isEmpty || email.isEmpty || isValid == false || !isPasswordNotEmpty || !isAtLeastOneCheckboxSelected) {
    String message = '';
    if (isValid!) {
      message += 'Please fill in all fields correctly.\n';
    }
    if (!isPasswordNotEmpty) {
      message += 'Please enter a password.\n';
    }
    if (!isAtLeastOneCheckboxSelected) {
      message += 'Please select at least one channel type.';
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
    return;
  }

  // Registration successful
  formKey.currentState?.save();
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.verified,
            color: Colors.greenAccent,
          ),
          SizedBox(width: 15,),
          Text(
            'Registration Successful',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );

  setState(() {
    // Set the text of controllers to the entered values
    channelNameController.text = chn;
    channelOwnerController.text = crn;
    emailController.text = email;
    passwordController.text = pw;

    // Reset checkbox values
    channelTypes = [false, false, false, false];
  });

  // Move focus to channel name field
  channelNameFocusNode.requestFocus();

  // Navigate to the next page
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context)=>Details(
      channelname: channelNameController.text,
      creatorname: channelOwnerController.text,
      email: emailController.text,
    ),
  ));
}





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.subscriptions,color: Color.fromARGB(194, 255, 0, 0),),
        centerTitle: true,
        title: const Text(
          'CREATORS FORM',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.white,
            fontFamily: 'assets/fonts/JosefinSans-Bold.ttf',
           // fontStyle: FontStyle.italic,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [

                  // Channel name
                  const SizedBox(height: 10.0),
                  TextFormField(
                    controller: channelNameController,
                    focusNode: channelNameFocusNode,
                    cursorColor: Colors.black,
                    key: const ValueKey('chn'),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.video_library),
                      labelText: 'Your Channel Name *',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Channel Name ?";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      chn = value.toString();
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 15.0),

                  // Channel owner name
                  TextFormField(
                    controller: channelOwnerController,
                    focusNode: channelOwnerFocusNode,
                    cursorColor: Colors.black,
                    key: const ValueKey('crn'),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      labelText: 'Your Name',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return "Creator's Name ?";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      crn = value.toString();
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 15.0),

                  // Channel email
                  TextFormField(
                    controller: emailController,
                    focusNode: emailFocusNode,
                    cursorColor: Colors.black,
                    key: const ValueKey('email'),
                    decoration: const InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Your Email *',
                      labelStyle: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty ||
                          !RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return "eg : example@gmail.com";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (value) {
                      email = value.toString();
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 15.0),

                  // Password
                  TextFormField(
                    controller: passwordController,
                    focusNode: passwordFocusNode,
                    cursorColor: Colors.black,
                    key: const ValueKey('pw'),
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.password),
                      labelText: 'Password *',
                      labelStyle: const TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      } else if (!value.contains(RegExp(r'[A-Z]'))) {
                        return 'Password must contain at least one capital letter';
                      } else if (!value.contains(
                          RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                        return 'Password must contain at least one symbol';
                      } else if (!value.contains(RegExp(r'[0-9]'))) {
                        return 'Password must contain at least one number';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      pw = value.toString();
                    },
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                  const SizedBox(height: 15.0),

                  // check box for the channel type
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(padding: EdgeInsets.only(left: 40.0)),
                      Text(
                        'Choose Your Channel Type',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),


                  // Custom checkboxes for different channel types
                 /*Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomCheckbox(
                        value: channelTypes[0],
                        label: 'Entertainment',
                        onChanged: (bool? value) {
                          setState(() {
                            channelTypes[0] = value ?? false;;
                          });
                        },
                      ),
                      CustomCheckbox(
                        value: channelTypes[1],
                        label: 'Education',
                        onChanged: (bool? value) {
                          setState(() {
                            ch = value!;
                          });
                        },
                      ),
                      CustomCheckbox(
                        value: tech,
                        label: 'Tech',
                        onChanged: (bool? value) {
                          setState(() {
                            tech = value!;
                          });
                        },
                      ),
                      CustomCheckbox(
                        value: others,
                        label: 'Others',
                        onChanged: (bool? value) {
                          setState(() {
                            others = value!;
                          });
                        },
                      ),
                      
                    ],
                  ),*/

                  // Custom checkboxes for different channel types
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  channelTypes.length,
                  (index) => CustomCheckbox(
                    value: channelTypes[index],
                    label: index == 0
                        ? 'Entertainment'
                        : index == 1
                            ? 'Education'
                            : index == 2
                                ? 'Tech'
                                : 'Others',
                    onChanged: (bool? value) {
                      setState(() {
                        channelTypes[index] = value ?? false;
                      });
                    },
                  ),
                ),
              ),



                  const SizedBox(height: 15.0),

                  //register button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white, backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: (){

                          trysubmit();
                        //   Navigator.of(context).push(MaterialPageRoute(
                        // builder: (context)=>Details(
                        //   channelname: channelNameController.text, 
                        //   creatorname: channelOwnerController.text, 
                        //   email: emailController.text,)));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final String label;
  final ValueChanged<bool?> onChanged;

  const CustomCheckbox({
    required this.value,
    required this.label,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Checkbox(
            checkColor: Colors.greenAccent,
            activeColor: Colors.black,
            value: value,
            onChanged: onChanged,
          ),
          Text(label),
        ],
      ),
    );
  }
}