import 'package:flutter/material.dart';
import 'package:truestory_app/storage.dart';
import 'package:truestory_app/profile_self.dart';
import 'package:truestory_app/notifications.dart';
import 'package:truestory_app/scroll.dart';
import 'package:geolocator/geolocator.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 7, 69, 144)),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'TrueStory'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  final String title;
  final DataStorage storage = DataStorage();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  String _x = "__________";
  String _output = "";
  var myController = TextEditingController();
  late Future<Position> _position;

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, app cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }
  
  @override
  void initState() {
    super.initState();
    _position = _determinePosition();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    await widget.storage.writeX(myController.text);
    setState(() {
      _x = myController.text;
      _output = "";
    });
    return;
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color.fromARGB(255, 188, 208, 255),
        onDestinationSelected: (int index) {
          if (index == 0) {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScrollRoute()),
            );
          }
          if (index == 2) {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NotifRoute()),
            );
          }
          if (index == 3) {
            Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfileRoute()),
            );
          }
        },
        indicatorColor: const Color.fromARGB(0, 0, 0, 0),
        selectedIndex: 1,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.list),
            label: 'Scroll',
          ),
          NavigationDestination(
            icon: Icon(Icons.messenger_sharp),
            label: 'Create Post',
          ),
          NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Most recent message: $_x",
            ),
            Text(
              _output,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height:10),
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 251, 167, 175),
                  ),
                  onPressed: _decrementCounter,
                  child: const Icon(Icons.remove),
                ),
                const SizedBox(width:30),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 111, 166, 255),
                  ),
                  onPressed: _incrementCounter,
                  child: const Icon(Icons.add),
                ),
              ],
            ),
            */
            const SizedBox(height:30),
            SizedBox(
              width: 200,
              child: TextField(
                controller: myController,
                decoration: const InputDecoration(
                  hintText: 'Send text post',
                ),
              ),
            ),
            const SizedBox(height:10),
            ElevatedButton(
                  onPressed: () {
                    // Validate will return true if the form is valid, or false if
                    // the form is invalid.
                    _submit();
                  },
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                    backgroundColor: const Color.fromARGB(255, 128, 232, 246)               ),
                  child: const Text('Update'),
                ),
                const SizedBox(height:30),
                FutureBuilder(
                future: _position,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                        "Your coordinates are ${snapshot.data!.latitude}, ${snapshot.data!.longitude} :)");
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const CircularProgressIndicator();
                }),
                
          ],
        ),
      ),
    );
  }
}