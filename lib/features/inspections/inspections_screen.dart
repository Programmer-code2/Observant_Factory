import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants.dart';
import '../../core/utils.dart';
import '../../core/locale_provider.dart';
import '../../data/database.dart';
import '../../services/image_service.dart';
import 'widgets/inspection_card.dart';

final itemsProvider = FutureProvider.family<List<InspectionItem>, int>((ref, subPlaceId) {
  ref.watch(refreshProvider);
  return ref.watch(dbProvider).itemsOf(subPlaceId);
});

class InspectionsScreen extends ConsumerWidget {
  final int subPlaceId;
  final String subPlaceName;
  final String placeName;
  const InspectionsScreen({
    super.key,
    required this.subPlaceId,
    required this.subPlaceName,
    required this.placeName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = ref.watch(itemsProvider(subPlaceId));
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(subPlaceName)),
      body: items.when(
        data: (list) => list.isEmpty
            ? Center(child: Text(strings.noInspections))
            : GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.8,
                ),
                itemCount: list.length,
                itemBuilder: (_, i) =>
                    InspectionCard(item: list[i], onDelete: () => _deleteItem(ref, list[i])),
              ),
        error: (e, _) => Center(child: Text('${strings.error} $e')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add_a_photo),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AddInspectionScreen(
              subPlaceId: subPlaceId,
              subPlaceName: subPlaceName,
              placeName: placeName,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _deleteItem(WidgetRef ref, InspectionItem item) async {
    await ref.read(dbProvider).deleteItem(item.id);
    ref.invalidate(itemsProvider(subPlaceId));
    ref.read(refreshProvider.notifier).trigger();
  }
}

class AddInspectionScreen extends ConsumerStatefulWidget {
  final int subPlaceId;
  final String subPlaceName;
  final String placeName;
  const AddInspectionScreen({
    super.key,
    required this.subPlaceId,
    required this.subPlaceName,
    required this.placeName,
  });

  @override
  ConsumerState<AddInspectionScreen> createState() => _AddInspectionScreenState();
}

class _AddInspectionScreenState extends ConsumerState<AddInspectionScreen> {
  File? _image;
  final _noteController = TextEditingController();
  final _observerNameController = TextEditingController();
  final _customCategoryController = TextEditingController();
  ObservationType _selectedType = ObservationType.safety;
  final _formKey = GlobalKey<FormState>();
  bool _saving = false;

  @override
  void dispose() {
    _noteController.dispose();
    _observerNameController.dispose();
    _customCategoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final strings = ref.watch(stringsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(strings.addInspection)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('${strings.place} ${widget.placeName}',
                  style: Theme.of(context).textTheme.titleSmall),
              Text('${strings.location} ${widget.subPlaceName}',
                  style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey[400]!),
                  ),
                  child: _image != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_image!, fit: BoxFit.cover),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.camera_alt, size: 64, color: Colors.grey),
                            const SizedBox(height: 8),
                            Text(strings.tapToCapture),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _noteController,
                decoration: InputDecoration(
                  labelText: strings.note,
                  border: const OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                validator: (v) => v == null || v.trim().isEmpty ? strings.noteRequired : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _observerNameController,
                decoration: InputDecoration(
                  labelText: strings.observerName,
                  hintText: strings.observerNameHint,
                  border: const OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              Text(strings.observationTypeLabel, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 8),
              ...ObservationType.values.map((t) => Card(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      leading: Icon(t.icon, color: t.color, size: 28),
                      title: Text(strings.observationLabel(t)),
                      trailing: _selectedType == t
                          ? const Icon(Icons.check_circle, color: Colors.teal)
                          : const Icon(Icons.circle_outlined),
                      onTap: () => setState(() => _selectedType = t),
                    ),
                  )),
              if (_selectedType.isCustom) ...[
                const SizedBox(height: 8),
                TextFormField(
                  controller: _customCategoryController,
                  decoration: InputDecoration(
                    labelText: strings.customCategoryHint,
                    border: const OutlineInputBorder(),
                  ),
                  validator: (v) => v == null || v.trim().isEmpty ? strings.noteRequired : null,
                ),
              ],
              const SizedBox(height: 24),
              _saving
                  ? const Center(child: CircularProgressIndicator())
                  : FilledButton.icon(
                      onPressed: _save,
                      icon: const Icon(Icons.save),
                      label: Text(strings.save),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final file = await ImageService.capturePhoto();
    if (file != null) setState(() => _image = file);
  }

  Future<void> _save() async {
    final strings = ref.read(stringsProvider);
    if (!_formKey.currentState!.validate()) return;
    final typeLabel = _selectedType.isCustom
        ? _customCategoryController.text.trim()
        : _selectedType.arabicLabel;
    final observerName = _observerNameController.text.trim();
    setState(() => _saving = true);
    try {
      await ref.read(dbProvider).addItem(
            widget.subPlaceId,
            _image?.path ?? '',
            _noteController.text.trim(),
            typeLabel,
            observerName: observerName.isEmpty ? null : observerName,
          );
      if (!mounted) return;
      ref.read(refreshProvider.notifier).trigger();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(strings.saved)),
      );
      Navigator.pop(context);
    } catch (e) {
      log('SAVE', 'Failed to save: $e');
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${strings.saveFailed} $e')),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}
