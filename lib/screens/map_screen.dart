import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:location/location.dart';
import '../models/point_of_interest.dart';
import '../state/providers/place_details_provider.dart';
import '../state/providers/directions_provider.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends ConsumerState<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LocationData? _currentLocation;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentLocation = await location.getLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final arguments = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final destination = arguments['destination'] as PointOfInterest;

    if (_currentLocation == null) {
      return const LoadingScreen();
    }

    final origin = LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!);

    return ref.watch(directionsProvider('${origin.latitude},${origin.longitude}', destination.name)).maybeWhen(
      orElse: () => const ErrorScreen(),
      error: (Object error, StackTrace stackTrace) => const ErrorScreen(),
      loading: () => const LoadingScreen(),
      data: (directions) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              destination.name,
              style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          extendBodyBehindAppBar: true,
          body: Stack(
            children: [
              SizedBox(
                height: size.height,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  polylines: {
                    Polyline(
                      polylineId: const PolylineId('route1'),
                      visible: true,
                      points: directions.route,
                      color: theme.colorScheme.secondary,
                      width: 5,
                    )
                  },
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(directions.route[0].latitude, directions.route[0].longitude),
                    zoom: 12,
                  ),
                ),
              ),
              Positioned(
                bottom: 48.0,
                left: 16.0,
                right: 16.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: size.width * 0.33,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.directions),
                            const SizedBox(width: 8.0),
                            Text(
                              directions.distanceText,
                              style: theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4.0),
                            const Text('km')
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad).slide(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Container(
                        width: size.width * 0.33,
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Icon(Icons.schedule),
                            const SizedBox(width: 8.0),
                            Text(
                              directions.durationText,
                              style: theme.textTheme.headlineMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 4.0),
                            const Text('mins')
                          ],
                        ),
                      ),
                    ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad).slide(
                          begin: const Offset(1, 0),
                          end: const Offset(0, 0),
                        ),
                    const SizedBox(height: 8),
                    PointOfInterestDetails(
                      size: size,
                      theme: theme,
                      destination: destination,
                    ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad).slide(
                          begin: const Offset(0, 1),
                          end: const Offset(0, 0),
                        ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class PointOfInterestDetails extends ConsumerWidget {
  const PointOfInterestDetails({
    super.key,
    required this.size,
    required this.theme,
    required this.destination,
  });

  final Size size;
  final ThemeData theme;
  final PointOfInterest destination;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(placeDetailsProvider(destination.name, destination.latLng)).maybeWhen(
          orElse: () => const SizedBox(),
          data: (placeDetails) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Image.memory(
                      placeDetails.$2.imageData,
                      fit: BoxFit.cover,
                      width: size.width * 0.25,
                      height: size.width * 0.25,
                    ).animate().shimmer(duration: 1000.ms),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            placeDetails.$1.name,
                            style: theme.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(placeDetails.$1.formattedAddress),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        );
  }
}
