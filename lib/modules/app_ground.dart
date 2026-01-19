import 'dart:math' as math;
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppGround extends StatelessWidget {
  const AppGround({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _C.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              const _TopBar(),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: const [
                      _HeaderCard(),
                      SizedBox(height: 16),
                      _CashFlowCard(),
                      SizedBox(height: 16),
                      _UpcomingPaymentsSection(),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const _BottomNavBar(currentIndex: 0),
    );
  }
}

/// ---------------------------------------------------------------------------
/// COLORS / STYLES
/// ---------------------------------------------------------------------------

class _C {
  static const background = Color(0xFF050816);
  static const card = Color(0xFF101827);
  static const cardLight = Color(0xFF1F2937);
  static const glass = Color(0x66FFFFFF); // white with opacity
  static const accentBlue = Color(0xFF3B82F6);
  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFF9CA3AF);
}

/// ---------------------------------------------------------------------------
/// TOP BAR
/// ---------------------------------------------------------------------------

class _TopBar extends StatelessWidget {
  const _TopBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Home',
          style: GoogleFonts.urbanist(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
        const Spacer(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 24,
              ),
            ),
            Positioned(
              right: 8,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  '3',
                  style: GoogleFonts.urbanist(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// ---------------------------------------------------------------------------
/// HEADER CARD (PROFILE + SUMMARY STATS + RENTAL INCOME)
/// ---------------------------------------------------------------------------

class _HeaderCard extends StatelessWidget {
  const _HeaderCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          // Profile row
          Row(
            children: [
              // const CircleAvatar(
              //   radius: 22,
              //   backgroundImage: AssetImage(
              //     'assets/images/profile_placeholder.png', // replace with your asset
              //   ),
              // ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Madiha Aroa',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: _C.textPrimary,
                    ),
                  ),
                  Text(
                    'Welcome back',
                    style: GoogleFonts.roboto(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: _C.textMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Metric cards
          Row(
            children: const [
              Expanded(
                child: _MetricCard(
                  icon: Icons.home_work_outlined,
                  title: 'Portfolio Value',
                  value: '\$2.4M',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MetricCard(
                  icon: Icons.attach_money_rounded,
                  title: 'Monthly Rental Income',
                  value: '\$8,450',
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: _MetricCard(
                  icon: Icons.groups_outlined,
                  title: 'Occupancy Rate',
                  value: '94%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Rental income summary
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
              vertical: 8.0,
            ),
            decoration: BoxDecoration(
              color: _C.cardLight,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _incomeLine(label: 'Rental Income', value: '\$10,000'),
                    const SizedBox(height: 4),
                    _incomeLine(label: 'Expenses', value: '\$10,000'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _incomeLine({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            color: _C.textMuted,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _C.textPrimary,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final IconData icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _C.cardLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.white),
          const Spacer(),
          Text(
            value,
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _C.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.urbanist(
              fontSize: 10,
              fontWeight: FontWeight.w400,
              color: _C.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// CASH FLOW CARD (GLASS + DONUT + LEGEND)
/// ---------------------------------------------------------------------------

class _CashFlowCard extends StatelessWidget {
  const _CashFlowCard();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: _C.glass,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.15)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cash flow by country',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: _C.textPrimary,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 110,
                    height: 110,
                    child: _DonutChart(
                      slices: [
                        _ChartSlice(0.3, const Color(0xFF14B8A6)),
                        _ChartSlice(0.25, const Color(0xFF3B82F6)),
                        _ChartSlice(0.2, const Color(0xFF22C55E)),
                        _ChartSlice(0.15, const Color(0xFFF97316)),
                        _ChartSlice(0.1, const Color(0xFFEC4899)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        _LegendItem(
                          color: Color(0xFF3B82F6),
                          label: '80% United States',
                        ),
                        _LegendItem(
                          color: Color(0xFF22C55E),
                          label: '80% United Kingdom',
                        ),
                        _LegendItem(
                          color: Color(0xFF14B8A6),
                          label: '80% Canada',
                        ),
                        _LegendItem(
                          color: Color(0xFFF97316),
                          label: '60% Germany',
                        ),
                        _LegendItem(
                          color: Color(0xFFEC4899),
                          label: '20% Japan',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: _C.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartSlice {
  _ChartSlice(this.value, this.color);

  final double value;
  final Color color;
}

class _DonutChart extends StatelessWidget {
  const _DonutChart({required this.slices});

  final List<_ChartSlice> slices;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _DonutPainter(slices));
  }
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.slices);

  final List<_ChartSlice> slices;

  @override
  void paint(Canvas canvas, Size size) {
    final strokeWidth = 20.0;
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2 - strokeWidth / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final total = slices.fold<double>(0, (sum, s) => sum + s.value);
    var startAngle = -math.pi / 2;

    for (final slice in slices) {
      final sweepAngle = (slice.value / total) * 2 * math.pi;
      paint.color = slice.color;
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle;
    }

    // Inner hole
    final holePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = _C.card.withOpacity(0.9);
    canvas.drawCircle(center, radius - strokeWidth / 2, holePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// ---------------------------------------------------------------------------
/// UPCOMING PAYMENTS
/// ---------------------------------------------------------------------------

class _UpcomingPaymentsSection extends StatelessWidget {
  const _UpcomingPaymentsSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Upcoming Payment',
              style: GoogleFonts.urbanist(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _C.textPrimary,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {},
              child: Text(
                'View All',
                style: GoogleFonts.urbanist(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _C.accentBlue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const _PaymentTile(
          icon: Icons.apartment_rounded,
          title: 'Sunset Apartments',
          subtitle: 'Rent Due',
          amount: '\$2,400',
          dateLabel: 'Mar 1',
        ),
        const SizedBox(height: 8),
        const _PaymentTile(
          icon: Icons.account_balance_rounded,
          title: 'Mortgage Payment',
          subtitle: 'for Apt. 7',
          amount: '\$2,400',
          dateLabel: 'Apr 7',
        ),
      ],
    );
  }
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.dateLabel,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final String dateLabel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _C.card,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.06)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _C.cardLight,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 22, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _C.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: _C.textMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: _C.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                dateLabel,
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  color: _C.textMuted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// ---------------------------------------------------------------------------
/// BOTTOM NAV BAR
/// ---------------------------------------------------------------------------

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({required this.currentIndex});

  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: const Color(0xFF0B1220),
      selectedItemColor: _C.accentBlue,
      unselectedItemColor: _C.textMuted,
      selectedFontSize: 12,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.notifications_none_rounded),
          label: 'Notification',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.pie_chart_outline_rounded),
          label: 'Portfolio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.show_chart_rounded),
          label: 'Cashflow',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Profile',
        ),
      ],
      onTap: (index) {
        // TODO: hook up navigation to other tabs if needed
      },
    );
  }
}
