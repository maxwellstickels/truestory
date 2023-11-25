import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
int _counter = 0;
String _x = "CINS467 Hello World";

class DataStorage {

  bool _initialized = false;

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    _initialized = true;
    if (kDebugMode) {
      print("Initialized default Firebase app $app");
    }
  }
  DataStorage();

  bool get isInitialized => _initialized;

  Future<bool> writeCounter(int counter) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("ctest")
          .doc("ctest2")
          .set({"counter": counter}).then((value) {
        if (kDebugMode) {
          print("Counter set to $counter");
        }
        return true;
      }).catchError((error) {
        if (kDebugMode) {
          print("Failed to set counter: $error");
        }
        return false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<bool> writeX(String x) async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      await firestore
          .collection("ctest")
          .doc("ctest")
          .set({"x": x}).then((value) {
        if (kDebugMode) {
          print("X set to $x");
        }
        return true;
      }).catchError((error) {
        if (kDebugMode) {
          print("Failed to set x: $error");
        }
        return false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return false;
  }

  Future<int> readCounter() async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot ds =
          await firestore.collection("ctest").doc("ctest2").get();
      if (ds.exists && ds.data() != null) {
        Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
        if (data.containsKey("counter")) {
          return data["counter"];
        }
      }
      bool writeSuccess = await writeCounter(0);
      if (writeSuccess) {
        return 0;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return -1;
  }

  Future<String> readX() async {
    try {
      if (!isInitialized) {
        await initializeDefault();
      }
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot ds =
          await firestore.collection("ctest").doc("ctest").get();
      if (ds.exists && ds.data() != null) {
        Map<String, dynamic> data = (ds.data() as Map<String, dynamic>);
        if (data.containsKey("x")) {
          return data["x"];
        }
      }
      bool writeSuccess = await writeX("CINS467 Hello World");
      if (writeSuccess) {
        return "";
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return "error";
  }
}