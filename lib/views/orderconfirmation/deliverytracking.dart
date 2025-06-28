import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'dart:async';
import 'dart:math';

import 'package:whitematrix_groupa_shopping_app/views/orderconfirmation/deliveryconirm.dart';

class LiveTracking extends StatefulWidget {
  const LiveTracking({super.key});

  @override
  State<LiveTracking> createState() => _LiveTrackingState();
}

class _LiveTrackingState extends State<LiveTracking> {
  final MapController _mapController = MapController();
  Timer? _deliveryTimer;

  static const LatLng _userLocation = LatLng(12.9352, 77.6245);
  static const LatLng _initialDeliveryLocation = LatLng(12.9007, 77.6055);
  LatLng _deliveryBoyLocation = _initialDeliveryLocation;

  String _estimatedTime = "30 min";
  double _progress = 0.0;
  String _deliveryStatus = "On the way";

  final List<LocationMarker> _bangaloreLocations = [
    LocationMarker(
      position: LatLng(12.9716, 77.5946),
      name: "Bangalore City Center",
      description: "Heart of Bangalore",
    ),
    LocationMarker(
      position: LatLng(12.9698, 77.7500),
      name: "Whitefield",
      description: "IT Hub",
    ),
    LocationMarker(
      position: LatLng(12.9279, 77.6271),
      name: "Electronic City",
      description: "Tech Park",
    ),
    LocationMarker(
      position: LatLng(12.9352, 77.6245),
      name: "Koramangala",
      description: "Your Location",
    ),
    LocationMarker(
      position: LatLng(12.9007, 77.6055),
      name: "BTM Layout",
      description: "Delivery Partner Location",
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startDeliverySimulation();
  }

  @override
  void dispose() {
    _deliveryTimer?.cancel();
    super.dispose();
  }

  void _startDeliverySimulation() {
    _deliveryTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        _progress = (timer.tick * 0.1).clamp(0.0, 1.0);

        double latDiff =
            _userLocation.latitude - _initialDeliveryLocation.latitude;
        double lngDiff =
            _userLocation.longitude - _initialDeliveryLocation.longitude;

        _deliveryBoyLocation = LatLng(
          _initialDeliveryLocation.latitude + (latDiff * _progress),
          _initialDeliveryLocation.longitude + (lngDiff * _progress),
        );

        if (_progress < 0.3) {
          _deliveryStatus = "Picked up your order";
          _estimatedTime = "25 min";
        } else if (_progress < 0.6) {
          _deliveryStatus = "On the way";
          _estimatedTime = "18 min";
        } else if (_progress < 0.9) {
          _deliveryStatus = "Nearby";
          _estimatedTime = "5 min";
        } else {
          _deliveryStatus = "Delivered";
          _estimatedTime = "0 min";
          timer.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Deliveryconirm()),
          );
        }
      });
    });
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    const double earthRadius = 6371;

    double lat1Rad = point1.latitude * (pi / 180);
    double lat2Rad = point2.latitude * (pi / 180);
    double deltaLatRad = (point2.latitude - point1.latitude) * (pi / 180);
    double deltaLngRad = (point2.longitude - point1.longitude) * (pi / 180);

    double a = sin(deltaLatRad / 2) * sin(deltaLatRad / 2) +
        cos(lat1Rad) *
            cos(lat2Rad) *
            sin(deltaLngRad / 2) *
            sin(deltaLngRad / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadius * c;
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    markers.add(
      Marker(
        point: _userLocation,
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(),
          child: Image.asset("assets/images/R.png"),
        ),
      ),
    );

    markers.add(
      Marker(
        point: _deliveryBoyLocation,
        width: 50,
        height: 50,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: ClipRRect(
            child: Image.asset(
                "assets/images/pngtree-delivery-boy-with-food-png-image_6528630.png"),
          ),
        ),
      ),
    );

    return markers;
  }

  List<Polyline> _buildPolylines() {
    // Simulate a realistic route with intermediate points
    List<LatLng> routePoints = _generateRoutePoints();

    // Split the route into completed and remaining portions based on progress
    int totalPoints = routePoints.length;
    int completedPointsCount = (_progress * totalPoints).floor();
    List<LatLng> completedPoints = routePoints.sublist(0, completedPointsCount);
    List<LatLng> remainingPoints = routePoints.sublist(completedPointsCount);

    return [
      // Completed route (gray)
      if (completedPoints.isNotEmpty)
        Polyline(
          points: completedPoints,
          strokeWidth: 6.0,
          color: Colors.grey[400]!.withOpacity(0.7),
          borderStrokeWidth: 1.0,
          borderColor: Colors.grey[600]!,
          // isDotted: false,
          strokeCap: StrokeCap.round,
        ),
      // Remaining route (blue, Google Maps style)
      if (remainingPoints.isNotEmpty)
        Polyline(
          points: remainingPoints,
          strokeWidth: 6.0,
          color: Colors.blue[700]!.withOpacity(0.9),
          borderStrokeWidth: 1.0,
          borderColor: Colors.blue[900]!,
          // isDotted: false,
          strokeCap: StrokeCap.round,
        ),
    ];
  }

  List<LatLng> _generateRoutePoints() {
    // Simulate a realistic route with intermediate points
    List<LatLng> points = [];
    int segments = 20; // Number of intermediate points for smoothness

    double latDiff = _userLocation.latitude - _initialDeliveryLocation.latitude;
    double lngDiff =
        _userLocation.longitude - _initialDeliveryLocation.longitude;

    for (int i = 0; i <= segments; i++) {
      double t = i / segments;
      // Add slight randomness to simulate road curves
      double randomOffsetLat = (Random().nextDouble() - 0.5) * 0.001;
      double randomOffsetLng = (Random().nextDouble() - 0.5) * 0.001;
      points.add(LatLng(
        _initialDeliveryLocation.latitude + (latDiff * t) + randomOffsetLat,
        _initialDeliveryLocation.longitude + (lngDiff * t) + randomOffsetLng,
      ));
    }

    // Ensure the route starts and ends at exact locations
    points[0] = _initialDeliveryLocation;
    points[segments] = _userLocation;

    return points;
  }

  void _showLocationDialog(LocationMarker location) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(location.name),
          content: Text(location.description),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _mapController.move(location.position, 16.0);
              },
              child: Text('Go to Location'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDeliveryStatusCard() {
    double distance = _calculateDistance(_deliveryBoyLocation, _userLocation);

    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/pngtree-delivery-boy-with-food-png-image_6528630.png",
                width: 40,
                height: 40,
              ),
              SizedBox(width: 8),
              Text(
                'Delivery Tracking',
                style: GoogleFonts.roboto(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            _deliveryStatus,
            style: GoogleFonts.roboto(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Time: $_estimatedTime',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
              Text(
                'Distance: ${distance.toStringAsFixed(1)} km',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          LinearProgressIndicator(
            value: _progress,
            backgroundColor: Colors.grey[200],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
            minHeight: 6,
          ),
          SizedBox(height: 8),
          Text(
            '${(_progress * 100).toInt()}% Complete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(
                (_userLocation.latitude + _initialDeliveryLocation.latitude) /
                    2,
                (_userLocation.longitude + _initialDeliveryLocation.longitude) /
                    2,
              ),
              initialZoom: 14.0,
              minZoom: 10.0,
              maxZoom: 18.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.delivery_tracking',
                maxZoom: 19,
                minZoom: 0,
              ),
              PolylineLayer(
                polylines: _buildPolylines(),
              ),
              MarkerLayer(
                markers: _buildMarkers(),
              ),
            ],
          ),
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: _buildDeliveryStatusCard(),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "user_location",
            mini: true,
            onPressed: () {
              _mapController.move(_userLocation, 16.0);
            },
            child: Icon(Icons.person_pin_circle, color: Colors.blue),
            backgroundColor: Colors.grey.withOpacity(0.8),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "delivery_location",
            mini: true,
            onPressed: () {
              _mapController.move(_deliveryBoyLocation, 16.0);
            },
            child: Image.asset(
              "assets/images/pngtree-delivery-boy-with-food-png-image_6528630.png",
              width: 24,
              height: 24,
            ),
            backgroundColor: Colors.grey.withOpacity(0.8),
          ),
          SizedBox(height: 8),
          FloatingActionButton(
            heroTag: "reset_simulation",
            onPressed: () {
              setState(() {
                _deliveryBoyLocation = _initialDeliveryLocation;
                _progress = 0.0;
                _deliveryStatus = "On the way";
                _estimatedTime = "15 min";
              });
              _deliveryTimer?.cancel();
              _startDeliverySimulation();
            },
            child: Icon(Icons.refresh, color: Colors.black),
            backgroundColor: Colors.grey.withOpacity(0.8),
          ),
        ],
      ),
    );
  }
}

class LocationMarker {
  final LatLng position;
  final String name;
  final String description;

  LocationMarker({
    required this.position,
    required this.name,
    required this.description,
  });
}
