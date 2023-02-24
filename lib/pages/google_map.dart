import 'package:e_commerce_app/theme/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({Key? key}) : super(key: key);

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  final LatLng _initialCameraPosition = const LatLng(20.5934, 78.9629);
  late GoogleMapController controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController _value) {
    controller = _value;
    _location.onLocationChanged.listen(
      (event) {
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(event.latitude!, event.longitude!),
              zoom: 15,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: _initialCameraPosition,
                ),
                mapType: MapType.normal,
                onMapCreated: (sa) {},
                myLocationEnabled: true,
              ),
              Positioned(
                bottom: 0,
                right: 0,
                left: 0,
                child: Container(
                  height: 50,
                  width: double.infinity,
                  margin: const EdgeInsets.only(
                      left: 10, right: 60, top: 40, bottom: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.grey.shade300,
                  ),
                  child: MaterialButton(
                    shape: const StadiumBorder(),
                    onPressed: () {},
                    child: const Text(
                      "Set Location",
                      style: TextStyle(
                        color: textColor,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: MediaQuery.of(context).size.width * 0.80,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_outlined,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
