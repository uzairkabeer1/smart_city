import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/place_autocomplete_prediction.dart';
import '../models/point_of_interest.dart';
import '../state/notifiers/user_location_provider.dart';
import '../state/providers/place_autocomplete_predictions_provider.dart';
import '../state/providers/selected_destination_provider.dart';
import '../state/providers/user_current_location_provider.dart';
import 'error_screen.dart';
import 'loading_screen.dart';

class PointsOfInterestScreen extends ConsumerStatefulWidget {
  const PointsOfInterestScreen({super.key});

  @override
  ConsumerState<PointsOfInterestScreen> createState() =>
      _PointsOfInterestScreenState();
}

class _PointsOfInterestScreenState
    extends ConsumerState<PointsOfInterestScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    final name = ModalRoute.of(context)!.settings.arguments as String;

    return ref.watch(selectedDestinationProvider(name)).maybeWhen(
          orElse: () => const ErrorScreen(),
          error: (Object error, StackTrace stackTrace) => const ErrorScreen(),
          loading: () => const LoadingScreen(),
          data: (destination) {
            final userLocation = ref.watch(userLocationProvider);
            final placePredictionsAsyncValue = ref.watch(
              placeAutocompletePredictionsProvider(userLocation),
            );

            final markers = destination!.pointsOfInterest.map(
              (pointOfInterest) {
                return Marker(
                  markerId: MarkerId(pointOfInterest.name),
                  position: pointOfInterest.latLng,
                );
              },
            ).toSet();

            return Scaffold(
              extendBodyBehindAppBar: true,
              body: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: size.height * 0.5,
                          child: GoogleMap(
                            mapType: MapType.normal,
                            myLocationButtonEnabled: false,
                            markers: markers,
                            initialCameraPosition: CameraPosition(
                              target: destination.latLng,
                              zoom: 12,
                            ),
                            onMapCreated: (GoogleMapController controller) {
                              _controller.complete(controller);
                            },
                          ),
                        ),
                        Positioned(
                          top: 56.0,
                          left: 16.0,
                          right: 16.0,
                          child: SizedBox(
                            height: 64,
                            child: AutocompleteSearchWidget(
                              placePredictionsAsyncValue:
                                  placePredictionsAsyncValue,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Image.network(
                            destination.imageUrl,
                            fit: BoxFit.cover,
                            height: 120,
                            width: 160,
                          ),
                          const SizedBox(width: 16.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                destination.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                destination.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    PointsOfInterestWidget(
                      pointsOfInterest: destination.pointsOfInterest,
                      userLocation: userLocation,
                      mapController: _controller,
                    ),
                  ],
                ),
              ),
            );
          },
        );
  }
}

class AutocompleteSearchWidget extends ConsumerWidget {
  const AutocompleteSearchWidget({
    super.key,
    required this.placePredictionsAsyncValue,
  });

  final AsyncValue<List<PlaceAutocompletePrediction>>
      placePredictionsAsyncValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RawAutocomplete<PlaceAutocompletePrediction>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<PlaceAutocompletePrediction>.empty();
        }
        return placePredictionsAsyncValue.when(
          data: (data) => data,
          loading: () => [],
          error: (error, stack) => [],
        );
      },
      displayStringForOption: (option) => option.description,
      fieldViewBuilder: (
        BuildContext context,
        TextEditingController textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return TextFormField(
          controller: textEditingController,
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          onChanged: (value) {
            ref.read(userLocationProvider.notifier).setUserLocation(value);
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Theme.of(context).colorScheme.surface,
            filled: true,
            labelText: 'Choose location',
            prefixIcon: IconButton(
              onPressed: () async {
                final currentLocation = await ref.read(
                  userCurrentLocationProvider.future,
                );

                if (currentLocation != null) {
                  ref
                      .read(userLocationProvider.notifier)
                      .setUserLocation(currentLocation);

                  textEditingController.text = currentLocation;
                }
              },
              icon: const Icon(Icons.location_on),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                textEditingController.clear();
              },
              icon: const Icon(Icons.clear),
            ),
          ),
        );
      },
      optionsViewBuilder: (
        BuildContext context,
        AutocompleteOnSelected<PlaceAutocompletePrediction> onSelected,
        Iterable<PlaceAutocompletePrediction> options,
      ) {
        return Align(
          alignment: Alignment.topLeft,
          child: Container(
            color: Theme.of(context).colorScheme.surface,
            width: MediaQuery.of(context).size.width * 0.75,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16.0),
              itemCount: options.length,
              separatorBuilder: (context, index) {
                return const SizedBox(height: 16.0);
              },
              itemBuilder: (BuildContext context, int index) {
                final PlaceAutocompletePrediction option =
                    options.elementAt(index);
                return GestureDetector(
                  onTap: () {
                    ref
                        .read(userLocationProvider.notifier)
                        .setUserLocation(option.description);
                    return onSelected(option);
                  },
                  child: Text(
                    option.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class PointsOfInterestWidget extends StatelessWidget {
  const PointsOfInterestWidget({
    super.key,
    required this.pointsOfInterest,
    required this.userLocation,
    required this.mapController,
  });

  final List<PointOfInterest> pointsOfInterest;
  final String userLocation;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: pointsOfInterest.map(
        (pointOfInterest) {
          return Container(
            margin: const EdgeInsets.only(bottom: 8.0),
            child: ListTile(
              tileColor: Colors.grey.shade100,
              leading: const Icon(Icons.attractions),
              title: Text(
                pointOfInterest.name,
                maxLines: 1,
              ),
              subtitle: Text(
                pointOfInterest.description,
                maxLines: 2,
              ),
              onTap: () async {
                if (userLocation.length > 5) {
                  Navigator.pushNamed(
                    context,
                    '/map',
                    arguments: {
                      'origin': userLocation,
                      'destination': pointOfInterest,
                    },
                  );
                } else {
                  final GoogleMapController controller =
                      await mapController.future;
                  controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        zoom: 14,
                        target: pointOfInterest.latLng,
                      ),
                    ),
                  );
                }
              },
            ),
          );
        },
      ).toList(),
    );
  }
}
