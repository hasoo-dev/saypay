import 'package:flutter/material.dart';
import 'package:saypay/core/theme/app_colors.dart';

class BackupStatusCard extends StatelessWidget {
  final String title;
  final String description;
  final DateTime? lastBackup;
  final Color surface;
  final Color textColor;
  final Color subText;

  const BackupStatusCard({
    super.key,
    required this.title,
    required this.description,
    required this.lastBackup,
    required this.surface,
    required this.textColor,
    required this.subText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.15),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.cloud_done_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(
                        fontFamily: 'Lufga',
                        fontSize: 12,
                        color: subText,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (lastBackup != null) ...[
            const SizedBox(height: 12),
            Text(
              'Last backup: ${lastBackup!.toString().split('.')[0]}',
              style: TextStyle(
                fontFamily: 'Lufga',
                fontSize: 11,
                color: subText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
