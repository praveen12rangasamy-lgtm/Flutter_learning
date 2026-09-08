import 'package:flutter/material.dart';

import '../models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      elevation: 3,

      child: InkWell(
        onTap: onTap,

        borderRadius:
            BorderRadius.circular(12),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,

            children: [

              Container(
                padding:
                    const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),

                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius:
                      BorderRadius.circular(20),
                ),

                child: Text(
                  event.category,

                  style: TextStyle(
                    color:
                        Colors.blue.shade700,
                    fontWeight:
                        FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              Text(
                event.title,

                style: const TextStyle(
                  fontSize: 20,
                  fontWeight:
                      FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [

                  const Icon(
                    Icons.location_on,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Expanded(
                    child: Text(
                      event.location,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [

                  const Icon(
                    Icons.calendar_month,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    event.date,
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Row(
                children: [

                  const Icon(
                    Icons.access_time,
                    size: 18,
                    color: Colors.grey,
                  ),

                  const SizedBox(width: 6),

                  Text(
                    event.time,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,

                child: ElevatedButton(
                  onPressed: onTap,

                  child: const Text(
                    'View Details',
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