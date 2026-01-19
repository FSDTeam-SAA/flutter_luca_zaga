/* -------------------------------------------------------------------------- */
/*                                   COLORS                                   */
/* -------------------------------------------------------------------------- */

import 'package:flutter/material.dart';
import 'package:flutter_luca_zaga30/core/image_path.dart';
import 'package:flutter_luca_zaga30/modules/home/presentation/screens/upcoming_payment_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class C {
  static const bg = Color(0xFF05070F);
  static const cardDark = Color(0xFF171C28);
  static const cardDark2 = Color(0xFF111623);
  static const border = Color(0xFF283041);
  static const primary = Color(0xFF2F7CF6);
  static const accentGreen = Color(0xFF4ED19C);
  static const textMain = Colors.white;
  static const textMuted = Color(0xFFB4B8C7);
  static const warning = Color(0xFFFF6B6B);
}

/* -------------------------------------------------------------------------- */
/*                                HEADER SECTION                              */
/* -------------------------------------------------------------------------- */

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 18),

      child: Column(
        children: [
          Row(
            children: [
              const CircleAvatar(
                radius: 22,
                backgroundColor: Colors.white24,
                child: Icon(Icons.person, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Madiha Aroa',
                      style: GoogleFonts.roboto(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: C.textMain,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Welcome back',
                      style: GoogleFonts.roboto(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: C.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Colors.black38,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(
                      Icons.notifications_none_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: const BoxDecoration(
                        color: C.warning,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '3',
                        style: GoogleFonts.roboto(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                                STATS 3 CARDS                               */
/* -------------------------------------------------------------------------- */

class StatsRow extends StatelessWidget {
  const StatsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            icon: SizedBox(
              width: 32,
              height: 32,
              child: Image.asset(
                ImagePath.monthlyIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            title: 'Portfolio Value',
            value: '\$2.4M',
          ),
        ),
        const SizedBox(width: 6),

        Expanded(
          child: _StatCard(
            icon: SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                ImagePath.portfoliovalueIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            title: 'Monthly Rental',
            value: '\$8,450',
          ),
        ),

        const SizedBox(width: 6),
        Expanded(
          child: _StatCard(
            icon: SizedBox(
              width: 28,
              height: 28,
              child: Image.asset(
                ImagePath.occupancyIcon,
                fit: BoxFit.contain,
                color: Colors.white, // remove if your PNG is already colored
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            title: 'Occupancy Rate',
            value: '94%',
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  final Widget icon;
  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 112, // 🔒 same height for all cards (tweak to match Figma)
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: C.cardDark,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: C.border, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween, // spread nicely
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // icon box (same size for all)
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: icon),
            ),
            // value: $2.4M
            Text(
              value,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: C.textMain,
              ),
            ),
            // title: Portfolio Value / Monthly Rental Income / ...
            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.poppins(
                fontSize: 10,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                          RENTAL INCOME / EXPENSES                          */
/* -------------------------------------------------------------------------- */

class RentalIncomeCard extends StatelessWidget {
  const RentalIncomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.border),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          _incomeRow(label: 'Rental Income', value: '\$10,000'),
          const SizedBox(height: 16),
          _incomeRow(label: 'Expenses', value: '\$10,000'),
        ],
      ),
    );
  }

  Widget _incomeRow({required String label, required String value}) {
    return Row(
      children: [
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w500, // Medium (500)
            height: 1.2, // 120% line height
            color: const Color(0xFFFFFFFF),
          ),
        ),

        const Spacer(),
        Text(
          value,
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 12, // 12px
            fontWeight: FontWeight.w500, // Medium (500)
            height: 1.2, // 120% line height
            color: const Color(0xFFFFFFFF),
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                              CASH FLOW BY COUNTRY                          */
/* -------------------------------------------------------------------------- */

class CashFlowCard extends StatelessWidget {
  const CashFlowCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: C.cardDark.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: C.border),
      ),
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cash flow by country',
            style: GoogleFonts.roboto(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: C.textMain,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _DonutChart(),
              const SizedBox(width: 16),
              Expanded(child: _LegendList()),
            ],
          ),
        ],
      ),
    );
  }
}

/// Fake donut chart using SweepGradient – simple, looks close enough.
class _DonutChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: SweepGradient(
                colors: [
                  Color(0xFF00C9FF), // blue
                  Color(0xFF00C9FF),
                  Color(0xFF7555FF), // purple
                  Color(0xFF7555FF),
                  Color(0xFF00D4A2), // teal
                  Color(0xFF00D4A2),
                  Color(0xFFFFC857), // yellow
                  Color(0xFFFFC857),
                  Color(0xFFFA5D5D), // red
                  Color(0xFFFA5D5D),
                ],
              ),
            ),
          ),
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: C.cardDark2.withOpacity(0.95),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        _LegendDot(color: Color(0xFF00C9FF), text: '80% United States'),
        SizedBox(height: 6),
        _LegendDot(color: Color(0xFF7555FF), text: '80% United Kingdom'),
        SizedBox(height: 6),
        _LegendDot(color: Color(0xFF00D4A2), text: '80% Canada'),
        SizedBox(height: 6),
        _LegendDot(color: Color(0xFFFFC857), text: '60% Germany'),
        SizedBox(height: 6),
        _LegendDot(color: Color(0xFFFA5D5D), text: '20% Japan'),
      ],
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.text});

  final Color color;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 9,
          height: 9,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.roboto(fontSize: 11, color: C.textMain),
          ),
        ),
      ],
    );
  }
}

/* -------------------------------------------------------------------------- */
/*                           UPCOMING PAYMENTS SECTION                        */
/* -------------------------------------------------------------------------- */

class UpcomingPaymentsSection extends StatelessWidget {
  const UpcomingPaymentsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Upcoming Payment',
              style: GoogleFonts.roboto(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: C.textMain,
              ),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const UpcomingPaymentScreen(),
                  ),
                );
              },
              child: Text(
                'View All',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.blue,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        _PaymentCard(
          icon: Image.asset(
            ImagePath.homePaymentIcon,
            fit: BoxFit.contain,
            color: Colors.white, // tint to white like Figma
            colorBlendMode: BlendMode.srcIn,
          ),
          title: 'Sunset Apartments',
          subtitle: 'Rent Due',
          amount: '\$2,400',
          date: 'Mar 1',
        ),

        const SizedBox(height: 10),

        _PaymentCard(
          icon: Image.asset(
            ImagePath.settingIcon,
            fit: BoxFit.contain,
            color: Colors.white, // tint to white like Figma
            colorBlendMode: BlendMode.srcIn,
          ),
          title: 'Morgage Apartments',
          subtitle: 'Rent Due',
          amount: '\$2,400',
          date: 'Mar 1',
        ),
      ],
    );
  }
}

class _PaymentCard extends StatelessWidget {
  const _PaymentCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
  });

  /// Can be Icon(...) or Image.asset(...)
  final Widget icon;
  final String title;
  final String subtitle;
  final String amount;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: C.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: C.border),
      ),
      child: Row(
        children: [
          // leading icon
          SizedBox(width: 24, height: 24, child: icon),
          const SizedBox(width: 12),

          // title + subtitle
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.roboto(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: C.textMain,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.roboto(fontSize: 11, color: C.textMuted),
                ),
              ],
            ),
          ),

          // amount + date
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                amount,
                style: GoogleFonts.roboto(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: C.textMain,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                date,
                style: GoogleFonts.roboto(fontSize: 11, color: C.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
