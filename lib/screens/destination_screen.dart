import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../state/providers/selected_destination_provider.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class DestinationScreen extends ConsumerStatefulWidget {
  const DestinationScreen({super.key});

  @override
  ConsumerState<DestinationScreen> createState() => _DestinationScreenState();
}

class _DestinationScreenState extends ConsumerState<DestinationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    final name = ModalRoute.of(context)!.settings.arguments as String;

    return ref.watch(selectedDestinationProvider(name)).maybeWhen(
          orElse: () => const ErrorScreen(),
          error: (Object error, StackTrace stackTrace) => const ErrorScreen(),
          loading: () => const LoadingScreen(),
          data: (destination) {
            return Scaffold(
              appBar: AppBar(
                title: Column(
                  children: [
                    Text(
                      'Destination',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      destination?.name ?? '',
                      style: theme.textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              body: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    top: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        destination?.imageUrl ?? '',
                        fit: BoxFit.cover,
                        width: size.width,
                        height: size.height * 0.30,
                      ),
                      const SizedBox(height: 4.0),
                      SizedBox(
                        height: 75,
                        child: Row(
                          children: destination!.additionalImages.map((image) {
                            return Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 2.0,
                                  right: 2.0,
                                ),
                                child: Image.network(image, fit: BoxFit.cover),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                        style: theme.textTheme.bodyMedium,
                        maxLines: 5,
                      ),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: GoogleMap(
                          mapType: MapType.normal,
                          myLocationButtonEnabled: false,
                          initialCameraPosition: CameraPosition(
                            target: destination.latLng,
                            zoom: 10,
                          ),
                          onMapCreated: (GoogleMapController controller) {
                            _controller.complete(controller);
                          },
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(48.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/points-of-interest',
                            arguments: destination.name,
                          );
                        },
                        child: const Text('Find Route to common places'),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        );
  }
}
