// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:saypay/core/theme/app_colors.dart';
import 'widget/export_format_card.dart';
import 'widget/date_range_chip.dart';
import 'widget/data_type_checkbox.dart';
import 'widget/export_summary_card.dart';
import 'widget/export_button.dart';
import 'widget/section_label.dart';

class ExportData extends StatefulWidget {
  const ExportData({super.key});

  @override
  State<ExportData> createState() => _ExportDataState();
}

class _ExportDataState extends State<ExportData>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  // Selected export format
  int _selectedFormat = 0; // 0=CSV, 1=PDF, 2=Excel
  final List<FormatOption> _formats = [
    FormatOption(
      label: 'CSV',
      icon: Icons.table_rows_rounded,
      color: const Color(0xFF4CAF50),
    ),
    FormatOption(
      label: 'PDF',
      icon: Icons.picture_as_pdf_rounded,
      color: const Color(0xFFE53935),
    ),
    FormatOption(
      label: 'Excel',
      icon: Icons.grid_on_rounded,
      color: const Color(0xFF1565C0),
    ),
  ];

  // Date range
  String _selectedRange = 'This Month';
  final List<String> _dateRanges = [
    'This Week',
    'This Month',
    'Last 3 Months',
    'This Year',
    'Custom',
  ];

  // Data types
  final Map<String, bool> _dataTypes = {
    'Transactions': true,
    'Budget Plans': true,
    'Income': true,
    'Expenses': true,
    'Savings': false,
    'Analytics': false,
  };

  bool _isExporting = false;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _fadeAnim = CurvedAnimation(parent: _animController, curve: Curves.easeOut);
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  int get _selectedCount => _dataTypes.values.where((v) => v).length;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = Theme.of(context).colorScheme.onPrimary;
    final surface = isDark ? AppColors.darkSurface : AppColors.lightSurface;
    final textColor = isDark ? AppColors.darkText : AppColors.lightText;
    final subText = isDark
        ? AppColors.darkSecondaryText
        : AppColors.lightSecondaryText;

    return Scaffold(
      backgroundColor: bg,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ─── Fancy SliverAppBar ───────────────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            backgroundColor: bg,
            elevation: 0,
            leading: GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: surface,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 18,
                  color: textColor,
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: _buildHeader(isDark, textColor, subText),
            ),
          ),

          // ─── Body Content ─────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 8, 20, 120),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                FadeTransition(
                  opacity: _fadeAnim,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Format section
                      SectionLabel(text: 'Export Format', textColor: textColor),
                      const SizedBox(height: 12),
                      ExportFormatCard(
                        formats: _formats,
                        selectedFormat: _selectedFormat,
                        onFormatSelected: (index) {
                          setState(() => _selectedFormat = index);
                        },
                        surface: surface,
                        textColor: textColor,
                      ),

                      const SizedBox(height: 28),
                      // Date range
                      SectionLabel(text: 'Date Range', textColor: textColor),
                      const SizedBox(height: 12),
                      DateRangeChip(
                        dateRanges: _dateRanges,
                        selectedRange: _selectedRange,
                        onRangeSelected: (range) {
                          setState(() => _selectedRange = range);
                        },
                      ),

                      const SizedBox(height: 28),
                      // Data types
                      SectionLabel(
                        text: 'Include Data  ($_selectedCount selected)',
                        textColor: textColor,
                      ),
                      const SizedBox(height: 12),
                      DataTypeCheckbox(
                        dataTypes: _dataTypes,
                        onDataTypeToggled: (key) {
                          setState(() => _dataTypes[key] = !_dataTypes[key]!);
                        },
                        surface: surface,
                        textColor: textColor,
                        subText: subText,
                      ),

                      const SizedBox(height: 28),
                      // Summary card
                      ExportSummaryCard(
                        format: _formats[_selectedFormat].label,
                        period: _selectedRange,
                        selectedCount: _selectedCount,
                        surface: surface,
                        textColor: textColor,
                        subText: subText,
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),

      // ─── Floating Export Button ────────────────────────────────────────
      bottomNavigationBar: ExportButton(
        isExporting: _isExporting,
        selectedCount: _selectedCount,
        format: _formats[_selectedFormat].label,
        onPressed: _startExport,
      ),
    );
  }

  // ── Header ──────────────────────────────────────────────────────────────
  Widget _buildHeader(bool isDark, Color textColor, Color subText) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.15),
            AppColors.primary.withOpacity(0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Export Data',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        height: 1.1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Download your financial records\nin your preferred format.',
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 13.5,
                        color: subText,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Decorative icon
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFFB347)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.4),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.upload_file_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startExport() async {
    setState(() => _isExporting = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isExporting = false);
    Get.snackbar(
      'Export Ready!',
      '${_formats[_selectedFormat].label} file downloaded successfully.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.primary,
      colorText: Colors.white,
      icon: const Icon(Icons.check_circle_rounded, color: Colors.white),
      margin: const EdgeInsets.all(16),
      borderRadius: 14,
      duration: const Duration(seconds: 3),
    );
  }
}
