import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:expenses_manager/presentation/create_transaction/ui/widgets/category_modal.dart';
import 'package:flutter/material.dart';

class CategorySelector extends StatelessWidget {
  final List<CategoryModel> categories;
  final CategoryModel? selectedCategory;
  final void Function(CategoryModel) updateCategory;

  const CategorySelector({super.key, this.selectedCategory, required this.categories, required this.updateCategory});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context, 
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (BuildContext context) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: CategoryModal(categories: categories, selectedCategory: selectedCategory, updateCategory: updateCategory)
            );
          }
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade200,
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                // color: _selectedCategory?.color.withOpacity(0.1) ?? Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                selectedCategory?.icon ?? Icons.category,
                // color: _selectedCategory?.color ?? Colors.grey,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Categoría',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 4),
                Text(
                  selectedCategory?.name ?? 'Seleccionar categoría',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: selectedCategory == null
                        ? Colors.grey
                        : Colors.black,
                  ),
                ),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
