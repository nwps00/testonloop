import 'package:flutter/material.dart';

// Data class
class Data {
  String? title;
  List<Model>? modelList;

  // Constructor for Data class
  Data({this.title, this.modelList});
}

// CarModel class (which holds Data)
class Model {
  String? title;
  List<SubModel>? subList;

  // Constructor for CarModel class
  Model({this.title, this.subList});
}

// CarModel class (which holds Data)
class SubModel {
  String? title;
  List<HostModel>? hostList;

  // Constructor for CarModel class
  SubModel({this.title, this.hostList});
}

class HostModel {
  String? title;
  List<VehicleModel>? vehicleList;

  // Constructor for CarModel class
  HostModel({this.title, this.vehicleList});
}

class VehicleModel {
  String? title;
  int? seat;

  // Constructor for CarModel class
  VehicleModel({this.title, this.seat});
}
