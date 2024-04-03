import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

class InternetCheckWidget extends StatefulWidget {
  const InternetCheckWidget({super.key});

  @override
  _InternetCheckWidgetState createState() => _InternetCheckWidgetState();
}

class _InternetCheckWidgetState extends State<InternetCheckWidget> {
  bool isConnected = true;

  @override
  void initState() {
    super.initState();
    checkInternetConnectivity();
  }

  Future<void> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connectivity Check'),
      ),
      body: Center(
        child: isConnected
            ? const Text('Connected to the Internet')
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Please connect to the network',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                checkInternetConnectivity();
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: InternetCheckWidget(),
  ));
}
