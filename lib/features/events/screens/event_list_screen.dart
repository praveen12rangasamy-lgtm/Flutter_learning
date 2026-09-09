import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_menu_actions.dart';
import '../../../core/widgets/skeleton_loading.dart';
import '../../../routes/route_names.dart';
import '../blocs/event_bloc.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({
    super.key,
  });

  void openEventDetails(
    BuildContext context,
    Event event,
  ) {
    Navigator.pushNamed(
      context,
      RouteNames.eventDetails,
      arguments: event,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 16,
        title: const Text(
          'Upcoming Events',
        ),
        centerTitle: false,
        actions: const [
          AppMenuActions(),
        ],
      ),
      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {
          // ==========================================
          // INITIAL & LOADING SKELETON
          // ==========================================
          if (state is EventInitial || state is EventLoading) {
            return const EventListSkeleton();
          }

          // ==========================================
          // ERROR
          // ==========================================
          if (state is EventError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: const BoxDecoration(
                        color: AppColors.errorSurface,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        context.read<EventBloc>().add(
                              LoadEvents(),
                            );
                      },
                      child: const Text(
                        'Try Again',
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          // ==========================================
          // LOADED
          // ==========================================
          if (state is EventLoaded) {
            final List<Event> events = state.events;

            if (events.isEmpty) {
              return const Center(
                child: Text(
                  'No events available',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 15,
                  ),
                ),
              );
            }

            return RefreshIndicator(
              color: AppColors.primary,
              onRefresh: () async {
                context.read<EventBloc>().add(
                      RefreshEvents(),
                    );
              },
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final Event event = events[index];

                  return AnimatedOpacity(
                    duration: Duration(
                      milliseconds: 300 + (index * 100),
                    ),
                    opacity: 1.0,
                    child: EventCard(
                      event: event,
                      onTap: () {
                        openEventDetails(
                          context,
                          event,
                        );
                      },
                    ),
                  );
                },
              ),
            );
          }

          return const SizedBox();
        },
      ),
    );
  }
}
