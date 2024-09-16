import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/destination.dart';
import '../state/providers/all_destinations_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final destinations = ref.watch(allDestinationsProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Spacer(),
            Text(
              'Welcome to Smart City System',
              textAlign: TextAlign.center,
              style: theme.textTheme.displaySmall!.copyWith(
                fontWeight: FontWeight.bold,
              ),
            )
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(
                  duration: 2400.ms,
                  color: theme.colorScheme.primary,
                )
                .animate()
                .fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad)
                .slide(),
            const Spacer(),
            CarouselSlider(
              options: CarouselOptions(
                height: size.height * 0.66,
                enlargeCenterPage: true,
              ),
              items: destinations.when(
                data: (destinations) {
                  return destinations.map(
                    (destination) {
                      return DestinationCard(
                        destination: destination,
                      );
                    },
                  ).toList();
                },
                loading: () => [
                  const Center(child: CircularProgressIndicator()),
                ],
                error: (err, stack) => [Text('Error: $err')],
              ),
            ).animate().fadeIn(duration: 1200.ms, curve: Curves.easeOutQuad),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  const DestinationCard({super.key, required this.destination});

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/destination',
          arguments: destination.name,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                destination.imageUrl,
                fit: BoxFit.cover,
              ),
            ).animate().shimmer(duration: 1200.ms),
            Align(
              alignment: Alignment.center,
              child: Text(
                destination.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
