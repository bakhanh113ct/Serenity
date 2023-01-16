import 'package:flutter/material.dart';
import '../common/color.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key, required this.onSearch});
  // final CustomerDataSource customerDataSource;
  final Function onSearch;
  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            // obscureText: true,
            controller: searchController,
          
            decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                suffixIcon:searchController.text.isEmpty ? null : IconButton(icon: const Icon(Icons.cancel), onPressed: () {
                  setState(() {
                     searchController.text = '';
                  });
                  widget.onSearch(context, searchController.text);
                },), 
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                hintText: 'Search here...'),
                onChanged: ((value) => setState(() {
                  
                })),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        const SizedBox(width: 15),
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: CustomColor.second),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed:() => widget.onSearch(context, searchController.text),
          ),
        )
      ],
    );
  }
}
