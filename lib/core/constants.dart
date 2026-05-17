import 'package:flutter/material.dart';

enum ObservationType {
  safety('سلامة', 'Safety', Icons.shield, Color(0xFFE53935)),
  security('أمنية', 'Security', Icons.lock, Color(0xFF3949AB)),
  design('تصميم', 'Design', Icons.design_services, Color(0xFF00897B)),
  maintenance('صيانة', 'Maintenance', Icons.handyman, Color(0xFF43A047)),
  operations('تشغيل', 'Operations', Icons.play_circle, Color(0xFFFB8C00)),
  electrical('كهربائية', 'Electrical', Icons.bolt, Color(0xFFFDD835)),
  mechanical('ميكانيكية', 'Mechanical', Icons.build, Color(0xFF6D4C41)),
  process('عمليات', 'Procedures', Icons.engineering, Color(0xFF00ACC1)),
  other('أخرى', 'Other', Icons.more_horiz, Color(0xFF757575));

  final String arabicLabel;
  final String englishLabel;
  final IconData icon;
  final Color color;
  const ObservationType(this.arabicLabel, this.englishLabel, this.icon, this.color);

  bool get isCustom => this == ObservationType.other;
}

ObservationType observationTypeFromString(String s) {
  return ObservationType.values.firstWhere(
    (e) => e.arabicLabel == s || e.englishLabel == s,
    orElse: () => ObservationType.other,
  );
}
