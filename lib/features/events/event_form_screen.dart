import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/providers/events_provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/utils/app_strings.dart';
import '../../models/event_model.dart';

class EventFormScreen extends StatefulWidget {
  final EventModel? event;

  const EventFormScreen({super.key, this.event});

  @override
  State<EventFormScreen> createState() => _EventFormScreenState();
}

class _EventFormScreenState extends State<EventFormScreen> {
  static const List<Map<String, dynamic>> _categories = [
    {'name': 'Book Club', 'icon': Icons.menu_book_outlined},
    {'name': 'Sport', 'icon': Icons.directions_bike},
    {'name': 'Birthday', 'icon': Icons.cake_outlined},
    {'name': 'Meeting', 'icon': Icons.groups_outlined},
    {'name': 'Exhibition', 'icon': Icons.museum_outlined},
  ];

  late final TextEditingController _titleController;
  late final TextEditingController _descController;
  late String _category;
  DateTime? _date;
  TimeOfDay? _time;

  bool get _isEdit => widget.event != null;

  @override
  void initState() {
    super.initState();
    final e = widget.event;
    _titleController = TextEditingController(text: e?.title ?? '');
    _descController = TextEditingController(text: e?.description ?? '');
    _category = e?.category ?? 'Book Club';
    if (e != null) {
      _date = DateTime(e.date.year, e.date.month, e.date.day);
      _time = TimeOfDay(hour: e.date.hour, minute: e.date.minute);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _time = picked);
  }

  void _save() {
    final s = AppStrings.of(context);
    if (_titleController.text.trim().isEmpty) {
      _showMessage(s.pleaseEnterTitle);
      return;
    }
    if (_descController.text.trim().isEmpty) {
      _showMessage(s.pleaseEnterDesc);
      return;
    }
    if (_date == null) {
      _showMessage(s.pleaseChooseDate);
      return;
    }
    if (_time == null) {
      _showMessage(s.pleaseChooseTime);
      return;
    }

    final fullDate = DateTime(
      _date!.year,
      _date!.month,
      _date!.day,
      _time!.hour,
      _time!.minute,
    );
    final provider = Provider.of<EventsProvider>(context, listen: false);

    if (_isEdit) {
      final e = widget.event!;
      e.title = _titleController.text.trim();
      e.description = _descController.text.trim();
      e.category = _category;
      e.date = fullDate;
      provider.updateEvent(e);
    } else {
      provider.addEvent(
        EventModel(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          title: _titleController.text.trim(),
          description: _descController.text.trim(),
          category: _category,
          date: fullDate,
        ),
      );
    }
    Navigator.pop(context);
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final s = AppStrings.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final mainColor =
    isDark ? AppColors.mainDarkColor : AppColors.mainLightColor;
    final textColor = isDark ? AppColors.whiteColor : AppColors.blackColor;
    final fieldColor = isDark ? AppColors.darkInputColor : AppColors.whiteColor;
    final stroke =
    isDark ? AppColors.strokeDarkColor : AppColors.strokeWhiteColor;

    final previewEvent = EventModel(
      id: '',
      title: '',
      description: '',
      category: _category,
      date: DateTime.now(),
    );

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
              child: SizedBox(
                height: 36,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(Icons.arrow_back_ios_new,
                            size: 18, color: mainColor),
                      ),
                    ),
                    Text(
                      _isEdit ? s.editEvent : s.addEvent,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: textColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: AspectRatio(
                        aspectRatio: 343 / 140,
                        child: Image.asset(
                          previewEvent.imageFor(isDark),
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 34,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: _categories.length,
                        separatorBuilder: (context, index) =>
                        const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final name = _categories[index]['name'] as String;
                          final icon = _categories[index]['icon'] as IconData;
                          final selected = _category == name;
                          final fg = selected
                              ? Colors.white
                              : (isDark ? AppColors.whiteColor : mainColor);
                          return GestureDetector(
                            onTap: () => setState(() => _category = name),
                            child: Container(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 14),
                              decoration: BoxDecoration(
                                color: selected ? mainColor : fieldColor,
                                border: Border.all(
                                    color: selected ? mainColor : stroke),
                                borderRadius: BorderRadius.circular(18),
                              ),
                              child: Row(
                                children: [
                                  Icon(icon, size: 16, color: fg),
                                  const SizedBox(width: 6),
                                  Text(s.category(name),
                                      style:
                                      TextStyle(fontSize: 12, color: fg)),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(s.title,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: textColor)),
                    const SizedBox(height: 6),
                    _field(_titleController, s.eventTitle, 1, fieldColor,
                        stroke, mainColor, textColor, isDark),
                    const SizedBox(height: 14),
                    Text(s.description,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: textColor)),
                    const SizedBox(height: 6),
                    _field(_descController, s.eventDescription, 6,
                        fieldColor, stroke, mainColor, textColor, isDark),
                    const SizedBox(height: 14),
                    _row(
                      icon: Icons.calendar_month_outlined,
                      label: s.eventDate,
                      value: _date == null
                          ? s.chooseDate
                          : '${s.months[_date!.month - 1]} ${_date!.day}, ${_date!.year}',
                      onTap: _pickDate,
                      mainColor: mainColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 12),
                    _row(
                      icon: Icons.access_time,
                      label: s.eventTime,
                      value: _time == null
                          ? s.chooseTime
                          : _time!.format(context),
                      onTap: _pickTime,
                      mainColor: mainColor,
                      textColor: textColor,
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _save,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mainColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: Text(
                    _isEdit ? s.updateEvent : s.addEvent,
                    style: const TextStyle(
                        fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field(
      TextEditingController controller,
      String hint,
      int lines,
      Color fill,
      Color stroke,
      Color mainColor,
      Color textColor,
      bool isDark,
      ) {
    return TextField(
      controller: controller,
      minLines: lines,
      maxLines: lines,
      style: TextStyle(fontSize: 13, color: textColor),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 12,
          color: isDark ? AppColors.whiteDarkColor : AppColors.greyColor,
        ),
        filled: true,
        fillColor: fill,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: stroke),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: mainColor),
        ),
      ),
    );
  }

  Widget _row({
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
    required Color mainColor,
    required Color textColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 20, color: mainColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(label,
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: textColor)),
        ),
        GestureDetector(
          onTap: onTap,
          child: Text(
            value,
            style: TextStyle(
              fontSize: 12,
              color: mainColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}