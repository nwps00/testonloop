import 'package:flutter/material.dart';
import 'package:testonloop/model.dart'; // Assuming the 'model.dart' file contains the necessary models.

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> availableVehiclesList = []; // For filtered vehicles
  final TextEditingController minSeatsController = TextEditingController();
  final TextEditingController maxSeatsController = TextEditingController();

  late VehicleModel vehicle1;
  late VehicleModel vehicle2;
  late VehicleModel vehicle3;
  late HostModel host1;
  late HostModel host2;
  late SubModel subModel1;
  late SubModel subModel2;
  late Model model1;
  late Model model2;
  late Data carData;

  bool isFilterApplied = false; // Flag to check if filter is applied

  @override
  void initState() {
    super.initState();

    vehicle1 = VehicleModel(title: 'Car 1', seat: 4);
    vehicle2 = VehicleModel(title: 'Car 2', seat: 7);
    vehicle3 = VehicleModel(title: 'Car 3', seat: 5);

    host1 = HostModel(title: 'Host 1', vehicleList: [vehicle1, vehicle2]);
    host2 = HostModel(title: 'Host 2', vehicleList: [vehicle3]);

    subModel1 = SubModel(title: 'SubModel 1', hostList: [host1]);
    subModel2 = SubModel(title: 'SubModel 2', hostList: [host2]);

    model1 = Model(title: 'Model 1', subList: [subModel1]);
    model2 = Model(title: 'Model 2', subList: [subModel2]);

    carData = Data(title: 'Car Data', modelList: [model1, model2]);
  }

  void checkSeat(int minSeats, int maxSeats) {
    List<VehicleModel> availableVehicles = [];

    for (var model in carData.modelList!) {
      for (var subModel in model.subList!) {
        for (var host in subModel.hostList!) {
          for (var vehicle in host.vehicleList!) {
            if (vehicle.seat! >= minSeats && vehicle.seat! <= maxSeats) {
              availableVehicles.add(vehicle);
            }
          }
        }
      }
    }

    setState(() {
      isFilterApplied = true; // Mark that filter is applied
      if (availableVehicles.isEmpty) {
        availableVehiclesList = [
          'No vehicles available with the required seats in the specified range.'
        ];
      } else {
        availableVehiclesList = availableVehicles
            .map((vehicle) => vehicle.title ?? 'Unknown vehicle')
            .toList();
      }
    });
  }

  // Method to retrieve all vehicle titles
  List<String> getAllVehicles() {
    List<String> allVehicles = [];
    for (var model in carData.modelList!) {
      for (var subModel in model.subList!) {
        for (var host in subModel.hostList!) {
          for (var vehicle in host.vehicleList!) {
            allVehicles.add(vehicle.title ?? 'Unknown vehicle');
          }
        }
      }
    }
    return allVehicles;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Input fields for minimum and maximum seat values
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: minSeatsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Min Seats',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: maxSeatsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Max Seats',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  final minSeats = int.tryParse(minSeatsController.text) ?? 0;
                  final maxSeats = int.tryParse(maxSeatsController.text) ?? 0;

                  checkSeat(
                      minSeats, maxSeats); // Check for vehicles in the range
                },
                child: const Text('Check for vehicles within seat range'),
              ),
              const SizedBox(height: 20),

              // Section to display all vehicles if no filter is applied
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.blue[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.blue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(isFilterApplied
                        ? 'Filtered Vehicles:'
                        : 'All Vehicles:'),
                    const SizedBox(height: 10),
                    // Display either filtered or all vehicles
                    ...isFilterApplied && availableVehiclesList.isNotEmpty
                        ? availableVehiclesList.map((vehicle) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Text(
                                vehicle,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList()
                        : getAllVehicles().map((vehicle) {
                            return Container(
                              padding: const EdgeInsets.all(10),
                              margin: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.green[50],
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.green),
                              ),
                              child: Text(
                                vehicle,
                                style: const TextStyle(fontSize: 16),
                              ),
                            );
                          }).toList(),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.red),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Car Models:'),
                    const SizedBox(height: 10),
                    // Iterate through models
                    ...carData.modelList!.map((model) {
                      return Container(
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Model: ${model.title}'),
                            const SizedBox(height: 8),
                            // Iterate through subModels
                            ...model.subList!.map((subModel) {
                              return Container(
                                padding: const EdgeInsets.all(10),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.yellow[50],
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(color: Colors.yellow),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('SubModel: ${subModel.title}'),
                                    const SizedBox(height: 8),
                                    // Iterate through hosts
                                    ...subModel.hostList!.map((host) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 8),
                                        decoration: BoxDecoration(
                                          color: Colors.orange[50],
                                          borderRadius:
                                              BorderRadius.circular(8.0),
                                          border:
                                              Border.all(color: Colors.orange),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Host: ${host.title}'),
                                            const SizedBox(height: 8),
                                            // Iterate through vehicles
                                            ...host.vehicleList!.map((vehicle) {
                                              return Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[50],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  border: Border.all(
                                                      color: Colors.blue),
                                                ),
                                                child: Text(
                                                    'Vehicle: ${vehicle.title}, Seats: ${vehicle.seat}'),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ],
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
