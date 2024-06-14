import 'package:flutter/material.dart';
import 'package:form/detailspage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FormScreen(),
    );
  }
}

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String chn = "";
  String email = "";
  String pw = "";
  String crn = "";

  TextEditingController channelNameController = TextEditingController();
  TextEditingController channelOwnerController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  final formKey = GlobalKey<FormState>();

  List<bool> channelTypes = [false, false, false, false];

  void trysubmit() {
    final isValid = formKey.currentState?.validate();
    final bool isPasswordNotEmpty = pw.isNotEmpty;
    final bool isAtLeastOneCheckboxSelected = channelTypes.contains(true);

    if (chn.isEmpty ||
        crn.isEmpty ||
        email.isEmpty ||
        isValid == false ||
        !isPasswordNotEmpty ||
        !isAtLeastOneCheckboxSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Please fill in all fields correctly.',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }

    formKey.currentState?.save();

    channelNameController.clear();
    channelOwnerController.clear();
    emailController.clear();
    passwordController.clear();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Details(
        channelname: chn,
        creatorname: crn,
        email: email,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(235, 247, 247, 247),
      appBar: AppBar(
        leading: const Icon(Icons.subscriptions,color: Color.fromARGB(194, 255, 0, 0),),
        centerTitle: true,
        title: const Text(
          'CREATORS FORM',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 0, 0, 0),
            //fontFamily: 'assets/fonts/JosefinSans-Bold.ttf',
           // fontStyle: FontStyle.italic,
           //fontStyle: FontStyle.
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: channelNameController,
                decoration: const InputDecoration(
                  labelText: 'Your Channel Name *',
                  icon: Icon(Icons.video_library,),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Channel Name ?";
                  }
                  return null;
                },
                onSaved: (value) {
                  chn = value!;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: channelOwnerController,
                decoration: const InputDecoration(
                  labelText: 'Your Name',
                  icon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Creator's Name ?";
                  }
                  return null;
                },
                onSaved: (value) {
                  crn = value!;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Your Email *',
                  icon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                  ),
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                    return "eg : example@gmail.com";
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
              ),
              const SizedBox(height: 15.0),
              TextFormField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Password *',
                  icon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color.fromARGB(255, 0, 0, 0),
                      width: 2,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  } else if (!value.contains(RegExp(r'[A-Z]'))) {
                    return 'Password must contain at least one capital letter';
                  } else if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                    return 'Password must contain at least one symbol';
                  } else if (!value.contains(RegExp(r'[0-9]'))) {
                    return 'Password must contain at least one number';
                  }
                  return null;
                },
                onSaved: (value) {
                  pw = value!;
                },
              ),
              const SizedBox(height: 15.0),
               const Padding(
                 padding: EdgeInsets.only(left: 40.0),
                 child: Text(
                   'Choose Your Channel Type',
                   style: TextStyle(
                     fontWeight: FontWeight.bold,
                   ),
                 ),
               ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  channelTypes.length,
                  (index) => Padding(
                    padding: const EdgeInsets.only(left: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(
                          checkColor: Color.fromARGB(194, 255, 0, 0),
                          activeColor: Colors.transparent,

                          value: channelTypes[index],
                          onChanged: (value) {
                            setState(() {
                              channelTypes[index] = value!;
                            });
                          },
                        ),
                        Text(
                          index == 0
                              ? 'Entertainment'
                              : index == 1
                                  ? 'Education'
                                  : index == 2
                                      ? 'Tech'
                                      : 'Others',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15.0),

              Center(
                child: ElevatedButton(
                  //iconAlignment: IconAlignment.end,
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      formKey.currentState!.save();
                      trysubmit();
                    }
                  },
                  child: const Text('Submit',style: TextStyle(color: Color.fromARGB(194, 255, 0, 0)),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}