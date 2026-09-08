import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/registration_bloc.dart';
import '../models/event.dart';
import '../services/local_storage_service.dart';
import 'registration_screen.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  State<EventDetailsScreen> createState() {
    return _EventDetailsScreenState();
  }
}

class _EventDetailsScreenState
    extends State<EventDetailsScreen> {

  // Controls expanded information
  bool showMore = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          'Event Details',
        ),
      ),

      body: SingleChildScrollView(

        padding:
            const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [

            // ==========================================
            // ANIMATED CATEGORY
            // ==========================================

            AnimatedContainer(

              duration:
                  const Duration(
                milliseconds: 400,
              ),

              curve:
                  Curves.easeInOut,

              padding:
                  EdgeInsets.symmetric(
                horizontal:
                    showMore ? 20 : 12,
                vertical:
                    showMore ? 10 : 6,
              ),

              decoration:
                  BoxDecoration(

                color:
                    showMore
                        ? Colors.blue
                        : Colors.blue.shade50,

                borderRadius:
                    BorderRadius.circular(25),
              ),

              child: Text(

                widget.event.category,

                style: TextStyle(

                  color:
                      showMore
                          ? Colors.white
                          : Colors.blue.shade700,

                  fontWeight:
                      FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(
              height: 16,
            ),


            // ==========================================
            // TITLE
            // ==========================================

            Text(
              widget.event.title,

              style: const TextStyle(
                fontSize: 28,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 24,
            ),


            // ==========================================
            // LOCATION
            // ==========================================

            _InfoRow(
              icon:
                  Icons.location_on,
              title:
                  'Location',
              value:
                  widget.event.location,
            ),

            const SizedBox(
              height: 16,
            ),


            // ==========================================
            // DATE
            // ==========================================

            _InfoRow(
              icon:
                  Icons.calendar_month,
              title:
                  'Date',
              value:
                  widget.event.date,
            ),

            const SizedBox(
              height: 16,
            ),


            // ==========================================
            // TIME
            // ==========================================

            _InfoRow(
              icon:
                  Icons.access_time,
              title:
                  'Time',
              value:
                  widget.event.time,
            ),

            const SizedBox(
              height: 30,
            ),


            // ==========================================
            // DESCRIPTION
            // ==========================================

            const Text(
              'About this event',

              style: TextStyle(
                fontSize: 20,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(
              height: 10,
            ),


            // ==========================================
            // ANIMATED SIZE
            // ==========================================

            AnimatedSize(

              duration:
                  const Duration(
                milliseconds: 400,
              ),

              curve:
                  Curves.easeInOut,

              child: showMore

                  ? Text(
                      widget.event.description,

                      style:
                          const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    )

                  : Text(
                      widget.event.description,

                      maxLines: 2,

                      overflow:
                          TextOverflow.ellipsis,

                      style:
                          const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
            ),

            const SizedBox(
              height: 10,
            ),


            // ==========================================
            // SHOW MORE BUTTON
            // ==========================================

            TextButton(
              onPressed: () {

                setState(() {

                  showMore =
                      !showMore;

                });
              },

              child: Text(
                showMore
                    ? 'Show Less'
                    : 'Show More',
              ),
            ),

            const SizedBox(
              height: 25,
            ),


            // ==========================================
            // ANIMATED REGISTER AREA
            // ==========================================

            AnimatedOpacity(

              duration:
                  const Duration(
                milliseconds: 500,
              ),

              opacity:
                  showMore ? 1.0 : 0.8,

              child: SizedBox(

                width:
                    double.infinity,

                height: 55,

                child:
                    ElevatedButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:
                            (context) {

                          return BlocProvider<
                              RegistrationBloc>(

                            create:
                                (context) {

                              return RegistrationBloc(

                                storageService:
                                    LocalStorageService(),
                              );
                            },

                            child:
                                RegistrationScreen(
                              event:
                                  widget.event,
                            ),
                          );
                        },
                      ),
                    );
                  },

                  child: const Text(
                    'Register Now',

                    style: TextStyle(
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// =====================================================
// INFO ROW
// =====================================================

class _InfoRow
    extends StatelessWidget {

  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(
      BuildContext context) {

    return Row(

      crossAxisAlignment:
          CrossAxisAlignment.start,

      children: [

        Icon(
          icon,
          color: Colors.blue,
        ),

        const SizedBox(
          width: 12,
        ),

        Expanded(

          child: Column(

            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style:
                    const TextStyle(
                  fontWeight:
                      FontWeight.bold,
                  fontSize: 14,
                ),
              ),

              const SizedBox(
                height: 3,
              ),

              Text(
                value,

                style:
                    const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}