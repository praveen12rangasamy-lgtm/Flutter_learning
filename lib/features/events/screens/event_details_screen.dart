import 'dart:async';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_menu_actions.dart';
import '../../../core/widgets/skeleton_loading.dart';
import '../../../routes/route_names.dart';
import '../models/event.dart';

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

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  // Controls expanded information
  bool showMore = false;
  bool _isLoading = true;
  Timer? _loadingTimer;

  @override
  void initState() {
    super.initState();
    _loadingTimer = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _loadingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 44,
        titleSpacing: 4,
        leading: IconButton(
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Event Details',
        ),
        centerTitle: false,
        actions: const [
          AppMenuActions(),
        ],
      ),
      body: _isLoading
          ? const EventDetailsSkeleton()
          : SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ==========================================
            // ANIMATED CATEGORY
            // ==========================================
            AnimatedContainer(
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.easeInOut,
              padding: EdgeInsets.symmetric(
                horizontal: showMore ? 20 : 14,
                vertical: showMore ? 10 : 6,
              ),
              decoration: BoxDecoration(
                color: showMore ? AppColors.primary : AppColors.primaryLight,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                widget.event.category,
                style: TextStyle(
                  color: showMore ? Colors.white : AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
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
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
            ),
            const SizedBox(
              height: 24,
            ),

            // Card container for details
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFECE7FF),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.location_on_outlined,
                    title: 'Location',
                    value: widget.event.location,
                  ),
                  const Divider(height: 24, color: Color(0xFFF0EEFA)),
                  _InfoRow(
                    icon: Icons.calendar_today_outlined,
                    title: 'Date',
                    value: widget.event.date,
                  ),
                  const Divider(height: 24, color: Color(0xFFF0EEFA)),
                  _InfoRow(
                    icon: Icons.access_time,
                    title: 'Time',
                    value: widget.event.time,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 26,
            ),

            // ==========================================
            // DESCRIPTION
            // ==========================================
            const Text(
              'About this event',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(
              height: 10,
            ),

            // ==========================================
            // ANIMATED SIZE
            // ==========================================
            AnimatedSize(
              duration: const Duration(
                milliseconds: 400,
              ),
              curve: Curves.easeInOut,
              child: showMore
                  ? Text(
                      widget.event.description,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    )
                  : Text(
                      widget.event.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: AppColors.textSecondary,
                      ),
                    ),
            ),
            const SizedBox(
              height: 6,
            ),

            // ==========================================
            // SHOW MORE BUTTON
            // ==========================================
            TextButton(
              onPressed: () {
                setState(() {
                  showMore = !showMore;
                });
              },
              child: Text(
                showMore ? 'Show Less' : 'Show More',
              ),
            ),
            const SizedBox(
              height: 20,
            ),

            // ==========================================
            // ANIMATED REGISTER AREA
            // ==========================================
            AnimatedOpacity(
              duration: const Duration(
                milliseconds: 500,
              ),
              opacity: showMore ? 1.0 : 0.95,
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      RouteNames.registration,
                      arguments: widget.event,
                    );
                  },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
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

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            color: AppColors.primary,
            size: 20,
          ),
        ),
        const SizedBox(
          width: 14,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
