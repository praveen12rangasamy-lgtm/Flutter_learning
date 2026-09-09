import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
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
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  event.category,
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Title
              Text(
                event.title,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 14),

              // Location
              Row(
                children: [
                  const Icon(
                    Icons.location_on_outlined,
                    size: 18,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      event.location,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Date
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_outlined,
                    size: 17,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    event.date,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Time
              Row(
                children: [
                  const Icon(
                    Icons.access_time,
                    size: 17,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    event.time,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Action button
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
