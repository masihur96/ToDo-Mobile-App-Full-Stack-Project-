import 'package:flutter/foundation.dart';

import '../user_model.dart';


class DataProvider extends ChangeNotifier {
  // User
  User? _user;
  User? get user => _user;
  setUser({User? user}) {
    _user = user;
    notifyListeners();
  }

  // int? _selectedCustomer;
  // int? get customer => _selectedCustomer;
  // setCustomer({int? selectedCustomer}) {
  //   _selectedCustomer = selectedCustomer;
  //   notifyListeners();
  // }
  //
  // int? _selectedShipment;
  // int? get shipment => _selectedShipment;
  // setShipment({int? selectedShipment}) {
  //   _selectedShipment = selectedShipment;
  //   notifyListeners();
  // }
  //
  // //Recieve Box
  // List<Box> _scannedBoxes = [];
  // List<String> _boxUid = [];
  // List<Box> get boxes => _scannedBoxes;
  //
  // addBox({required Box box}) {
  //   _scannedBoxes.add(box);
  //   _boxUid.add(box.uid!);
  //   notifyListeners();
  // }
  //
  // removeFromBox({required Box box}) {
  //   _boxUid.remove(box.uid);
  //   _scannedBoxes.remove(box);
  //   notifyListeners();
  // }
  //
  // clearBox() {
  //   _scannedBoxes = [];
  //   _boxUid = [];
  //   notifyListeners();
  // }
  //
  // bool isContains(String indBoxUid) {
  //   return _boxUid.contains(indBoxUid);
  // }
  //
  // String getBoxIds() {
  //   String boxIds = "";
  //   for (int i = 0; i < _scannedBoxes.length; i++) {
  //     boxIds += _scannedBoxes[i].id.toString();
  //     boxIds += ",";
  //   }
  //
  //   return boxIds.substring(0, boxIds.length - 1);
  // }
  //
  // //Distpatch Box
  // List<Box> _dispatchableBoxes = [];
  // List<String> dBoxUid = [];
  // List<Box> get dBoxes => _dispatchableBoxes;
  // addDBox({required Box box}) {
  //   _dispatchableBoxes.add(box);
  //   dBoxUid.add(box.uid!);
  //   notifyListeners();
  // }
  //
  // removeFromDBox({required Box box}) {
  //   _dispatchableBoxes.remove(box);
  //   dBoxUid.remove(box.uid);
  //   notifyListeners();
  // }
  //
  // clearDBox() {
  //   _dispatchableBoxes = [];
  //   dBoxUid = [];
  //   notifyListeners();
  // }
  //
  // bool isDContains(String indDBoxUid) {
  //   return dBoxUid.contains(indDBoxUid);
  // }
  //
  // String getDBoxIds() {
  //   String boxIds = "";
  //   for (int i = 0; i < _dispatchableBoxes.length; i++) {
  //     boxIds += _dispatchableBoxes[i].id.toString();
  //     boxIds += ",";
  //   }
  //
  //   return boxIds.substring(0, boxIds.length - 1);
  // }
  //
  // //TrasferBox Box
  // List<Box> _scannedTBoxes = [];
  // List<String> _boxTUid = [];
  // List<Box> get tBoxes => _scannedTBoxes;
  //
  // addTBox({required Box box}) {
  //   _scannedTBoxes.add(box);
  //   _boxTUid.add(box.uid!);
  //   notifyListeners();
  // }
  //
  // removeFromTBox({required Box box}) {
  //   _boxTUid.remove(box.uid);
  //   _scannedTBoxes.remove(box);
  //   notifyListeners();
  // }
  //
  // clearTBox() {
  //   _scannedTBoxes = [];
  //   _boxTUid = [];
  //   notifyListeners();
  // }
  //
  // bool isTContains(String indBoxUid) {
  //   return _boxTUid.contains(indBoxUid);
  // }
  //
  // String getTBoxIds() {
  //   String boxTIds = "";
  //   for (int i = 0; i < _scannedTBoxes.length; i++) {
  //     boxTIds += _scannedTBoxes[i].id.toString();
  //     boxTIds += ",";
  //   }
  //
  //   return boxTIds.substring(0, boxTIds.length - 1);
  // }
}