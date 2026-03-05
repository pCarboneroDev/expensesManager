import 'package:expenses_manager/domain/models/category_model.dart';
import 'package:flutter/material.dart';

class FilterContainer extends StatelessWidget {
  final List<CategoryModel> categories;
  final List<String> dateOptions;
  final String selectedDate;
  final int selectedCategory;
  final void Function(int) filter;
  final void Function(String) filterDate;

  const FilterContainer({
    super.key, 
    required this.categories,
    required this.dateOptions,
    required this.selectedDate,
    required this.selectedCategory,
    required this.filter,
    required this.filterDate
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ColorScheme.light().surfaceContainer,
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(31, 0, 0, 0),
            offset: Offset(0, 3),
            blurRadius: BorderSide.strokeAlignOutside,
            spreadRadius: BorderSide.strokeAlignOutside,
          ),
        ],
      ),
      child: Row(
        children: [
          ElevatedButton(onPressed: () {}, child: Icon(Icons.search)),
          Spacer(),
          DropdownButton<String>(
            value: selectedDate,
            items: dateOptions.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(value: value, child: Text(value));
            }).toList(),
            onChanged: (value) {
              filterDate(value!);
            }
          ),
          SizedBox(width: 20),
          DropdownButton(
            dropdownColor: ColorScheme.light().onPrimaryContainer,

            value: selectedCategory,
            items: categories.map<DropdownMenuItem>((value) {
              return DropdownMenuItem(value: value.id, child: Text(value.name));
            }).toList(),
            onChanged: (value) {
              filter(value);
            }
          )
        ],
      ),
    );
  }
}