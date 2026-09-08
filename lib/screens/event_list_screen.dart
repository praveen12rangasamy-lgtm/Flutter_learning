import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/event_bloc.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import 'event_details_screen.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({
    super.key,
  });

  void openEventDetails(
    BuildContext context,
    Event event,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return EventDetailsScreen(
            event: event,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upcoming Events',
        ),
        centerTitle: true,
      ),

      body: BlocBuilder<EventBloc, EventState>(
        builder: (context, state) {

          // ==========================================
          // INITIAL
          // ==========================================

          if (state is EventInitial) {
            return const Center(
              child: Text(
                'Preparing events...',
              ),
            );
          }


          // ==========================================
          // LOADING
          // ==========================================

          if (state is EventLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }


          // ==========================================
          // ERROR
          // ==========================================

          if (state is EventError) {
            return Center(
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center,
                children: [

                  const Icon(
                    Icons.error_outline,
                    size: 50,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  Text(
                    state.message,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<EventBloc>()
                          .add(
                            LoadEvents(),
                          );
                    },
                    child: const Text(
                      'Try Again',
                    ),
                  ),
                ],
              ),
            );
          }


          // ==========================================
          // LOADED
          // ==========================================

          if (state is EventLoaded) {

            final List<Event> events =
                state.events;

            if (events.isEmpty) {
              return const Center(
                child: Text(
                  'No events available',
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: () async {
                context
                    .read<EventBloc>()
                    .add(
                      RefreshEvents(),
                    );
              },

              child: ListView.builder(
                padding:
                    const EdgeInsets.all(16),

                itemCount:
                    events.length,

                itemBuilder:
                    (context, index) {

                  final Event event =
                      events[index];

                  return AnimatedOpacity(
                    duration: Duration(
                      milliseconds:
                          300 + (index * 100),
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