import 'constants.dart';

class AppStrings {
  final bool isArabic;
  const AppStrings(this.isArabic);

  // General
  String get cancel => isArabic ? 'إلغاء' : 'Cancel';
  String get save => isArabic ? 'حفظ' : 'Save';
  String get delete => isArabic ? 'حذف' : 'Delete';
  String get confirmDelete => isArabic ? 'تأكيد الحذف' : 'Confirm Delete';
  String get name => isArabic ? 'الاسم' : 'Name';
  String get nameRequired => isArabic ? 'الاسم مطلوب' : 'Name is required';
  String get error => isArabic ? 'خطأ:' : 'Error:';
  String get loading => isArabic ? 'جارٍ التحميل...' : 'Loading...';
  String get switchLanguageLabel => isArabic ? 'English' : 'العربية';

  // Places
  String get mainPlaces => isArabic ? 'الأماكن الرئيسية' : 'Main Places';
  String get noPlaces => isArabic ? 'لا توجد أماكن، أضف مكاناً جديداً' : 'No places found. Add a new place.';
  String get addPlace => isArabic ? 'إضافة مكان' : 'Add Place';
  String get deletePlaceWarning => isArabic ? 'سيتم حذف المكان وجميع البيانات المرتبطة به' : 'The place and all related data will be deleted';

  // Sub places
  String get noSubPlaces => isArabic ? 'لا توجد مواقع فرعية' : 'No sub-places found';
  String get addSubPlace => isArabic ? 'إضافة موقع فرعي' : 'Add Sub-place';
  String get deleteSubPlaceWarning => isArabic ? 'سيتم حذف الموقع وجميع بياناته' : 'The sub-place and all its data will be deleted';

  // Inspections
  String get addInspection => isArabic ? 'إضافة جولة تفتيشية' : 'Add Inspection';
  String get noInspections => isArabic ? 'لا توجد جولات تفتيشية' : 'No inspections found';
  String get tapToCapture => isArabic ? 'اضغط لالتقاط صورة (اختياري)' : 'Tap to capture photo (optional)';
  String get note => isArabic ? 'الملاحظة' : 'Note';
  String get noteRequired => isArabic ? 'الملاحظة مطلوبة' : 'Note is required';
  String get saved => isArabic ? 'تم الحفظ' : 'Saved';
  String get saveFailed => isArabic ? 'فشل الحفظ:' : 'Save failed:';
  String get place => isArabic ? 'المكان:' : 'Place:';
  String get location => isArabic ? 'الموقع:' : 'Location:';
  String get observationTypeLabel => isArabic ? 'نوع الملاحظة:' : 'Observation Type:';
  String get observerName => isArabic ? 'اسم الملاحظ' : 'Observer Name';
  String get customCategoryHint => isArabic ? 'اكتب نوع الملاحظة...' : 'Enter observation type...';
  String get observerNameHint => isArabic ? 'اسم الشخص الذي قام بالملاحظة' : 'Name of the observer';

  // Reports
  String get reports => isArabic ? 'التقارير' : 'Reports';
  String get fromDate => isArabic ? 'من تاريخ' : 'From Date';
  String get toDate => isArabic ? 'إلى تاريخ' : 'To Date';
  String get placeOptional => isArabic ? 'المكان (اختياري)' : 'Place (optional)';
  String get all => isArabic ? 'الكل' : 'All';
  String get dateRangeError => isArabic ? 'تاريخ البداية يجب أن يكون قبل تاريخ النهاية' : 'Start date must be before end date';
  String get reportFailed => isArabic ? 'فشل إنشاء التقرير:' : 'Report generation failed:';
  String get inspectionReport => isArabic ? 'تقرير الجولات التفتيشية' : 'Inspection Tours Report';
  String get period => isArabic ? 'الفترة:' : 'Period:';
  String get noData => isArabic ? 'لا توجد بيانات' : 'No data';
  String get subPlace => isArabic ? 'الموقع الفرعي' : 'Sub-place';
  String get date => isArabic ? 'التاريخ' : 'Date';
  String get notes => isArabic ? 'الملاحظات' : 'Notes';
  String get observations => isArabic ? 'الملاحظة' : 'Observation';
  String get imageLabel => isArabic ? 'صورة' : 'Image';

  // Navigation
  String get navPlaces => isArabic ? 'المواقع' : 'Places';
  String get navReports => isArabic ? 'التقارير' : 'Reports';
  String get navDashboard => isArabic ? 'الإحصائيات' : 'Dashboard';
  String get navObservations => isArabic ? 'الملاحظات' : 'Observations';
  String get navSettings => isArabic ? 'الإعدادات' : 'Settings';

  // Dashboard
  String get totalObservations => isArabic ? 'إجمالي الملاحظات' : 'Total Observations';
  String get totalPlaces => isArabic ? 'إجمالي المواقع' : 'Total Places';
  String get byType => isArabic ? 'حسب النوع' : 'By Type';
  String get recentActivity => isArabic ? 'آخر النشاطات' : 'Recent Activity';
  String get noObservations => isArabic ? 'لا توجد ملاحظات' : 'No observations yet';

  // Settings
  String get settings => isArabic ? 'الإعدادات' : 'Settings';
  String get language => isArabic ? 'اللغة' : 'Language';
  String get appVersion => isArabic ? 'إصدار التطبيق' : 'App Version';
  String get about => isArabic ? 'حول' : 'About';

  // Observations list
  String get allObservations => isArabic ? 'جميع الملاحظات' : 'All Observations';
  String get allPlaces => isArabic ? 'جميع الأماكن' : 'All Places';

  String observationLabel(ObservationType type) => isArabic ? type.arabicLabel : type.englishLabel;
}
