import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final TextEditingController controllerToName = TextEditingController();
  final TextEditingController controllerFromName = TextEditingController();
  final TextEditingController controllerMessage = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
      ),
      home: HomePage(controllerToName: controllerToName, controllerFromName: controllerFromName, controllerMessage: controllerMessage),
    );
  }

 
}

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.controllerToName,
    required this.controllerFromName,
    required this.controllerMessage,
  });

  final TextEditingController controllerToName;
  final TextEditingController controllerFromName;
  final TextEditingController controllerMessage;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text('email app'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            const SizedBox(height: 25),
            TextField(
              controller: widget.controllerToName,
              decoration: const InputDecoration(
                hintText: 'To name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: widget.controllerFromName,
              decoration: const InputDecoration(
                hintText: 'From name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            TextField(
              controller: widget.controllerMessage,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'message',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(onPressed: sendMessage, child: const Text('Send'))
          ],
        ),
      ),
    );
  }

   void sendMessage() async {
    final Dio dio = Dio();
    final response = await dio.post(
      'https://api.emailjs.com/api/v1.0/email/send',
      data: {
        "service_id": "service_2acgsxa",
        "template_id": "template_bppvosa",
        "user_id": "J9LAawA5b-fr8EW0B",
        "accessToken": "qAeS3TUJvPXs7QruduTwA",
        "template_params": {
          "to_name": widget.controllerToName.text,
          "from_name": widget.controllerFromName.text,
          'message': widget.controllerMessage.text
        }
      },
    );
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Отправлено'),
        ),
      );
    }
  }
}
