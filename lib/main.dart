import 'package:flutter/material.dart';
import 'package:testonloop/model.dart';

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
  int _counter = 0;
  List<String> availableVehiclesList =
      []; // To store available vehicles as strings

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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void checkSeat(int input) {
    List<VehicleModel> availableVehicles = [];

    for (var model in carData.modelList!) {
      for (var subModel in model.subList!) {
        for (var host in subModel.hostList!) {
          for (var vehicle in host.vehicleList!) {
            if (vehicle.seat! >= input) {
              availableVehicles.add(vehicle);
            }
          }
        }
      }
    }

    // Update the UI with available vehicles
    setState(() {
      if (availableVehicles.isEmpty) {
        availableVehiclesList = [
          'No vehicles available with the required seats.'
        ];
      } else {
        availableVehiclesList = availableVehicles
            .map((vehicle) => vehicle.title ?? 'Unknown vehicle')
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                checkSeat(5); // Check for vehicles with at least 5 seats
              },
              child: const Text('Check for vehicles with 5+ seats'),
            ),
            const SizedBox(height: 20),
            // Display the available vehicles in a Container
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
                  Text(
                    'Available Vehicles:',
                  ),
                  const SizedBox(height: 10),
                  // Show a message if no vehicles are available
                  ...availableVehiclesList.map((vehicle) {
                    return Text(
                      vehicle,
                    );
                  }).toList(),
                ],
              ),
            ),

            // Display the model, submodels, hosts, and vehicles in nested containers
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
                                              padding: const EdgeInsets.all(10),
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              decoration: BoxDecoration(
                                                color: Colors.blue[50],
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
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
    );
  }
}
