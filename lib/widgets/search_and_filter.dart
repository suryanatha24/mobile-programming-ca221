import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myapp/resources/dimentions.dart';

class SearchAndFilter extends StatefulWidget {
  const SearchAndFilter({
    super.key,
    required this.onSubmit,
    this.hint,
  });

  final Function(String query) onSubmit;
  final String? hint;

  @override
  State<SearchAndFilter> createState() => _SearchAndFilterState();
}

class _SearchAndFilterState extends State<SearchAndFilter> {
  final TextEditingController ctrlSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        color: Theme.of(context).colorScheme.primary,
      ),
      controller: ctrlSearch,
      onFieldSubmitted: widget.onSubmit,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(
            Radius.circular(largeSize),
          ),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(largeSize),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        fillColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        filled: true,
        prefixIcon: Container(
          margin: const EdgeInsets.only(left: mediumSize),
          child: IconButton(
            icon: SvgPicture.asset(
              "assets/icons/fi-br-search.svg",
              colorFilter: ColorFilter.mode(
                Theme.of(context).colorScheme.primary,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {},
          ),
        ),
        hintText: 'Cari moment...',
      ),
      textInputAction: TextInputAction.search,
      keyboardType: TextInputType.text,
    );
  }
}
