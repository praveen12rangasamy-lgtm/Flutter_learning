import 'package:flutter/material.dart';

/// Animated shimmer wrapper that sweeps light across all child skeleton shapes.
class ShimmerAnimation extends StatefulWidget {
  final Widget child;

  const ShimmerAnimation({
    super.key,
    required this.child,
  });

  @override
  State<ShimmerAnimation> createState() => _ShimmerAnimationState();
}

class _ShimmerAnimationState extends State<ShimmerAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
              colors: const [
                Color(0xFFE8E8EE),
                Color(0xFFEFEFF5),
                Color(0xFFFFFFFF),
                Color(0xFFEFEFF5),
                Color(0xFFE8E8EE),
              ],
              transform: _SlidingGradientTransform(
                slidePercent: _controller.value,
              ),
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * (slidePercent * 2 - 1),
      0.0,
      0.0,
    );
  }
}

/// Generic rounded placeholder container used in skeleton screens.
class SkeletonBox extends StatelessWidget {
  final double? width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFFE2E2EA),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

/// Skeleton loading layout for Event List screen.
class EventListSkeleton extends StatelessWidget {
  const EventListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerAnimation(
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Category pill
                const SkeletonBox(
                  width: 84,
                  height: 24,
                  borderRadius: 12,
                ),
                const SizedBox(height: 14),

                // Title lines
                const SkeletonBox(
                  width: double.infinity,
                  height: 18,
                  borderRadius: 6,
                ),
                const SizedBox(height: 8),
                const SkeletonBox(
                  width: 200,
                  height: 18,
                  borderRadius: 6,
                ),
                const SizedBox(height: 16),

                // Location
                const Row(
                  children: [
                    SkeletonBox(width: 18, height: 18, borderRadius: 9),
                    SizedBox(width: 8),
                    SkeletonBox(width: 120, height: 14, borderRadius: 4),
                  ],
                ),
                const SizedBox(height: 8),

                // Date
                const Row(
                  children: [
                    SkeletonBox(width: 18, height: 18, borderRadius: 9),
                    SizedBox(width: 8),
                    SkeletonBox(width: 150, height: 14, borderRadius: 4),
                  ],
                ),
                const SizedBox(height: 8),

                // Time
                const Row(
                  children: [
                    SkeletonBox(width: 18, height: 18, borderRadius: 9),
                    SizedBox(width: 8),
                    SkeletonBox(width: 90, height: 14, borderRadius: 4),
                  ],
                ),
                const SizedBox(height: 16),

                // Button
                const SkeletonBox(
                  width: double.infinity,
                  height: 44,
                  borderRadius: 22,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Skeleton loading layout for Event Details screen.
class EventDetailsSkeleton extends StatelessWidget {
  const EventDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerAnimation(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Badge
            const SkeletonBox(
              width: 96,
              height: 28,
              borderRadius: 14,
            ),
            const SizedBox(height: 16),

            // Title lines
            const SkeletonBox(
              width: double.infinity,
              height: 24,
              borderRadius: 6,
            ),
            const SizedBox(height: 8),
            const SkeletonBox(
              width: 240,
              height: 24,
              borderRadius: 6,
            ),
            const SizedBox(height: 24),

            // Info Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFECE7FF),
                  width: 1,
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      SkeletonBox(width: 36, height: 36, borderRadius: 10),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(width: 60, height: 12, borderRadius: 4),
                          SizedBox(height: 6),
                          SkeletonBox(width: 110, height: 15, borderRadius: 4),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SkeletonBox(width: 36, height: 36, borderRadius: 10),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(width: 60, height: 12, borderRadius: 4),
                          SizedBox(height: 6),
                          SkeletonBox(width: 150, height: 15, borderRadius: 4),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SkeletonBox(width: 36, height: 36, borderRadius: 10),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonBox(width: 60, height: 12, borderRadius: 4),
                          SizedBox(height: 6),
                          SkeletonBox(width: 90, height: 15, borderRadius: 4),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 26),

            // About section
            const SkeletonBox(width: 140, height: 18, borderRadius: 4),
            const SizedBox(height: 12),
            const SkeletonBox(width: double.infinity, height: 14, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: double.infinity, height: 14, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: 220, height: 14, borderRadius: 4),
            const SizedBox(height: 36),

            // Action Button
            const SkeletonBox(
              width: double.infinity,
              height: 52,
              borderRadius: 26,
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading layout for Event Registration screen.
class RegistrationSkeleton extends StatelessWidget {
  const RegistrationSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerAnimation(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFECE7FF),
                  width: 1,
                ),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBox(width: 88, height: 12, borderRadius: 4),
                  SizedBox(height: 10),
                  SkeletonBox(width: double.infinity, height: 20, borderRadius: 4),
                  SizedBox(height: 6),
                  SkeletonBox(width: 200, height: 20, borderRadius: 4),
                  SizedBox(height: 12),
                  SkeletonBox(width: 160, height: 13, borderRadius: 4),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Field 1
            const SkeletonBox(width: 80, height: 15, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: double.infinity, height: 52, borderRadius: 12),
            const SizedBox(height: 18),

            // Field 2
            const SkeletonBox(width: 100, height: 15, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: double.infinity, height: 52, borderRadius: 12),
            const SizedBox(height: 18),

            // Field 3
            const SkeletonBox(width: 110, height: 15, borderRadius: 4),
            const SizedBox(height: 8),
            const SkeletonBox(width: double.infinity, height: 52, borderRadius: 12),
            const SizedBox(height: 20),

            // Checkbox line
            const Row(
              children: [
                SkeletonBox(width: 20, height: 20, borderRadius: 4),
                SizedBox(width: 10),
                SkeletonBox(width: 220, height: 14, borderRadius: 4),
              ],
            ),
            const SizedBox(height: 30),

            // Register button
            const SkeletonBox(
              width: double.infinity,
              height: 52,
              borderRadius: 26,
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading layout for Create Account (Sign Up) screen.
class SignUpSkeleton extends StatelessWidget {
  const SignUpSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ShimmerAnimation(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // Field 1: Full Name
            SkeletonBox(width: 80, height: 14, borderRadius: 4),
            SizedBox(height: 6),
            SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
            SizedBox(height: 16),

            // Field 2: Email
            SkeletonBox(width: 60, height: 14, borderRadius: 4),
            SizedBox(height: 6),
            SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
            SizedBox(height: 16),

            // Field 3: Password
            SkeletonBox(width: 80, height: 14, borderRadius: 4),
            SizedBox(height: 6),
            SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
            SizedBox(height: 16),

            // Field 4: Confirm Password
            SkeletonBox(width: 120, height: 14, borderRadius: 4),
            SizedBox(height: 6),
            SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
            SizedBox(height: 16),

            // Terms checkbox row
            Row(
              children: [
                SkeletonBox(width: 18, height: 18, borderRadius: 4),
                SizedBox(width: 10),
                SkeletonBox(width: 240, height: 14, borderRadius: 4),
              ],
            ),
            SizedBox(height: 32),

            // Create Account Button
            SkeletonBox(
              width: double.infinity,
              height: 52,
              borderRadius: 26,
            ),
          ],
        ),
      ),
    );
  }
}

/// Skeleton loading layout for Sign In screen.
class SignInSkeleton extends StatelessWidget {
  const SignInSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);

    return ShimmerAnimation(
      child: Stack(
        children: [
          // Top banner area
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenSize.height * 0.38,
            child: Container(
              color: const Color(0xFFE2E2EA),
            ),
          ),

          // Bottom card area
          Positioned(
            top: screenSize.height * 0.34,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Center(
                    child: SkeletonBox(width: 100, height: 22, borderRadius: 6),
                  ),
                  SizedBox(height: 28),

                  SkeletonBox(width: 60, height: 14, borderRadius: 4),
                  SizedBox(height: 6),
                  SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
                  SizedBox(height: 18),

                  SkeletonBox(width: 80, height: 14, borderRadius: 4),
                  SizedBox(height: 6),
                  SkeletonBox(width: double.infinity, height: 52, borderRadius: 16),
                  SizedBox(height: 32),

                  SkeletonBox(width: double.infinity, height: 52, borderRadius: 26),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
