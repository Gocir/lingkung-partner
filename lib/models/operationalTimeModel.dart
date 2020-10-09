import 'package:cloud_firestore/cloud_firestore.dart';

class OperationalTimeModel {
  static const FULL_TIME = "fullTime";
  static const CLOSED = "closed";
  static const OPEN_TIME = "openTime";
  static const CLOSING_TIME = "closingTime";
  // static const SET_TIME = "setTime";

  String _fullTime;
  String _closed;
  String _openTime;
  String _closingTime;
  // String _setTime;

  //  getters
  String get fullTime => _fullTime;
  String get closed => _closed;
  String get openTime => _openTime;
  String get closingTime => _closingTime;
  // String get setTime => _setTime;

  //  public variable
  // SetTimeModel setTimeModel;

  OperationalTimeModel.fromSnapshot(DocumentSnapshot snapshot) {
    _fullTime = snapshot.data[FULL_TIME];
    _closed = snapshot.data[CLOSED];
    _openTime = snapshot.data[OPEN_TIME];
    _closingTime = snapshot.data[CLOSING_TIME];
    // (snapshot.data[SET_TIME] != null)
    //     ? setTimeModel = SetTimeModel.fromMap(snapshot.data[SET_TIME])
    //     : setTimeModel = snapshot.data[SET_TIME];
  }

}

// class SetTimeModel {
//   static const OPEN = "open";
//   static const CLOSE = "close";

//   String _open;
//   String _close;

//   //  getters
//   String get open => _open;
//   String get close => _close;

//   SetTimeModel.fromMap(Map data) {
//     _open = data[OPEN];
//     _close = data[CLOSE];
//   }

//   Map toMap() => {
//     OPEN : _open,
//     CLOSE : _close,
//   };
// }
