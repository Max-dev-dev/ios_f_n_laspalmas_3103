import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:momento_las_palmas/core/constants/app_colors.dart';
import 'package:momento_las_palmas/core/widgets/buttons/las_palmas_main_button.dart';
import 'package:momento_las_palmas/tabs/time_picker/presentation/pages/finding_places/finding_places.dart';
import 'package:momento_las_palmas/tabs/time_picker/presentation/pages/place_result/place_result.dart';

class TimePickerTab extends StatefulWidget {
  const TimePickerTab({Key? key}) : super(key: key);

  @override
  State<TimePickerTab> createState() => _TimePickerTabState();
}

class _TimePickerTabState extends State<TimePickerTab> {
  int _selectedHour = 8;
  final TextEditingController _hourController =
      TextEditingController(text: '08:00');
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _hourController.addListener(_onHourTextChanged);
  }

  @override
  void dispose() {
    _hourController.dispose();
    super.dispose();
  }

  void _onHourTextChanged() {
    final String text = _hourController.text.replaceAll(':00', '');
    final int? parsed = int.tryParse(text);
    if (parsed != null && parsed >= 1 && parsed <= 12) {
      setState(() {
        _selectedHour = parsed;
      });
    }
  }

  void _onHourSelected(int hour) {
    setState(() {
      _selectedHour = hour;
      _hourController.text = '${hour.toString().padLeft(2, '0')}:00';
    });
  }

  void _onTapUp(TapUpDetails details, double size) {
    final Offset tapPosition = details.localPosition;
    final Offset center = Offset(size / 2, size / 2);
    final double dx = tapPosition.dx - center.dx;
    final double dy = tapPosition.dy - center.dy;
    final double angle = math.atan2(dy, dx) + math.pi / 2;
    final double fixedAngle = (angle < 0) ? (angle + 2 * math.pi) : angle;
    int selectedHour = ((fixedAngle / (2 * math.pi)) * 12).round();
    if (selectedHour == 0) selectedHour = 12;

    _onHourSelected(selectedHour);
  }

  @override
  Widget build(BuildContext context) => DefaultTabController(
        length: 3,
        child: Builder(
          builder: (BuildContext context) {
            _tabController = DefaultTabController.of(context);
            return TabBarView(
              controller: _tabController,
              physics: const NeverScrollableScrollPhysics(),
              children: <Widget>[
                _clockPickerView(),
                _buildScrollableView(
                  FindingPlaces(tabController: _tabController),
                ),
                _buildScrollableView(
                  PlaceResult(
                    tabController: _tabController,
                    hour: _hourController.text,
                  ),
                ),
              ],
            );
          },
        ),
      );

  Widget _buildScrollableView(Widget child) => CustomScrollView(
        slivers: <Widget>[
          SliverFillRemaining(
            hasScrollBody: true,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: child,
            ),
          ),
        ],
      );

  Widget _clockPickerView() {
    const double size = 300.0;
    final double screenWidth = MediaQuery.of(context).size.width;
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
          padding: EdgeInsets.only(bottom: screenWidth > 375 ? 0 : 120),
          sliver: SliverFillRemaining(
            hasScrollBody: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(height: screenWidth > 375 ? 40 : 20),
                _title(),
                SizedBox(height: screenWidth > 375 ? 30 : 10),
                GestureDetector(
                  onTapUp: (TapUpDetails details) => _onTapUp(details, size),
                  child: SizedBox(
                    width: size,
                    height: size,
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        CustomPaint(
                          size: const Size(size, size),
                          painter: _ClockFacePainter(),
                        ),
                        ...List.generate(12, (int index) {
                          final int hourValue = (index == 0) ? 12 : index;
                          final double angle =
                              (index / 12) * 2 * math.pi - math.pi / 2;
                          const double radius = size / 2 - 30;
                          final double x = radius * math.cos(angle);
                          final double y = radius * math.sin(angle);

                          final bool isSelected = hourValue == _selectedHour;

                          return Transform.translate(
                            offset: Offset(x, y),
                            child: Container(
                              width: 40,
                              alignment: Alignment.center,
                              decoration: isSelected
                                  ? const BoxDecoration(
                                      color: Color(
                                        0xFFBF9A30,
                                      ),
                                      shape: BoxShape.circle,
                                    )
                                  : null,
                              child: Text(
                                hourValue.toString(),
                                style: const TextStyle(
                                  color: AppColors.colorWhitePrimary,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          );
                        }),
                        CustomPaint(
                          size: const Size(size, size),
                          painter: _HourHandPainter(_selectedHour),
                        ),
                        Positioned(
                          child: Container(
                            width: 90,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.colorBlackPrimary,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFFBF9A30),
                                width: 2,
                              ),
                            ),
                            child: TextField(
                              controller: _hourController,
                              textAlign: TextAlign.center,
                              cursorColor: AppColors.colorWhitePrimary,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.all(0),
                              ),
                              style: const TextStyle(
                                fontSize: 24,
                                color: AppColors.colorWhitePrimary,
                                fontWeight: FontWeight.w700,
                              ),
                              keyboardType: TextInputType.number,
                              onEditingComplete: () {
                                _formatHourInput(
                                  forceFormat: true,
                                );
                                FocusScope.of(context).unfocus();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40.0),
                  child: LasPalmasMainButton(
                    onTap: () => _tabController.animateTo(1),
                    buttonText: 'Find Places →',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _formatHourInput({bool forceFormat = false}) {
    final String text = _hourController.text.replaceAll(':00', '');
    final int? parsed = int.tryParse(text);

    if (parsed != null && parsed >= 1 && parsed <= 12) {
      final String formattedHour = parsed.toString().padLeft(2, '0');

      if (forceFormat || text.length >= 2) {
        _hourController.value = TextEditingValue(
          text: '$formattedHour:00',
          selection: const TextSelection.collapsed(offset: 5),
        );
      }
    }
  }

  Widget _title() => const SizedBox(
        width: 300.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Choose a Time',
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Select a time, and we’ll find the best places for that moment.',
              style: TextStyle(
                color: AppColors.colorWhitePrimary,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}

class _ClockFacePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;

    final Paint circlePaint = Paint()
      ..color = const Color(0xFF111111)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, circlePaint);

    final Paint borderPaint = Paint()
      ..color = const Color(0xFFBF9A30)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    canvas.drawCircle(center, radius, borderPaint);
  }

  @override
  bool shouldRepaint(_ClockFacePainter oldDelegate) => false;
}

class _HourHandPainter extends CustomPainter {
  final int hour;

  _HourHandPainter(this.hour);

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2);
    final double radius = size.width / 2;
    final double angle = (hour % 12) * 2 * math.pi / 12 - math.pi / 2;

    final Paint handPaint = Paint()
      ..color = const Color(0xFFBF9A30)
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final Offset handEnd = Offset(
      center.dx + (radius - 40) * math.cos(angle),
      center.dy + (radius - 40) * math.sin(angle),
    );

    canvas.drawLine(center, handEnd, handPaint);
    canvas.drawCircle(center, 6, Paint()..color = const Color(0xFFBF9A30));
  }

  @override
  bool shouldRepaint(_HourHandPainter oldDelegate) => oldDelegate.hour != hour;
}
