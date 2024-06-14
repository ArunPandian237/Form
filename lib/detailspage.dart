import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Details extends StatelessWidget {

String channelname,creatorname,email;

Details({super.key, required this.channelname,required this.creatorname,required this.email});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    'Channel Name: $channelname',
                    style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Creator\'s Name: $creatorname',
                    style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: $email',
                    style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 23, 21, 21),
                    ),
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Row(
        children: [
          Icon(
            Icons.verified,
            color: Color.fromARGB(255, 254, 255, 254),
          ),
          SizedBox(width: 15,),
          Text(
            'Subscribed',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
                  }, 
                  child: const Icon(Icons.subscriptions_outlined,color: Color.fromARGB(194, 255, 0, 0),))
                ],
              ),
            ),
          )

        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.pop(context);
      },
      child: const Icon(Icons.arrow_back_ios_outlined),
      ),
    );
  }
}