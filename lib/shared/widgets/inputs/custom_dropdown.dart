import 'package:flutter/material.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';

enum DropdownStyleType { regular, large }

class CustomDropdown extends StatefulWidget {
  final String? label;
  final String? hintText;
  final int? value;
  final List<DropdownMenuItem<int>> items;
  final ValueChanged<int?> onChanged;
  final bool isLoading;
  final IconData prefixIcon;
  final DropdownStyleType styleType;

  const CustomDropdown._({
    super.key,
    this.label,
    this.hintText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isLoading = false,
    required this.prefixIcon,
    required this.styleType,
  });

  /// Style biasa 
  factory CustomDropdown.regular({
    Key? key,
    String? label,
    String? hintText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    bool isLoading = false,
    IconData prefixIcon = Icons.map_outlined,
  }) {
    return CustomDropdown._(
      key: key,
      label: label,
      hintText: hintText,
      value: value,
      items: items,
      onChanged: onChanged,
      isLoading: isLoading,
      prefixIcon: prefixIcon,
      styleType: DropdownStyleType.regular,
    );
  }

  /// Style besar dan modern 
  factory CustomDropdown.large({
    Key? key,
    String? label,
    String? hintText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    bool isLoading = false,
    IconData prefixIcon = Icons.map_outlined,
  }) {
    return CustomDropdown._(
      key: key,
      label: label,
      hintText: hintText,
      value: value,
      items: items,
      onChanged: onChanged,
      isLoading: isLoading,
      prefixIcon: prefixIcon,
      styleType: DropdownStyleType.large,
    );
  }

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  bool _isFocused = false;

  Widget _buildRegularStyle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              fontFamily: 'Montserrat',
            ),
          ),
          const SizedBox(height: 8),
        ],
        Focus(
          onFocusChange: (hasFocus) {
            setState(() => _isFocused = hasFocus);
          },
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(228, 228, 228, 0.612),
              borderRadius: BorderRadius.circular(10.0),
              border: _isFocused
                  ? Border.all(
                      color: const Color.fromRGBO(252, 148, 3, 0.605),
                      width: 2.0,
                    )
                  : Border.all(
                      color: Colors.transparent,
                      width: 2.0,
                    ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: 
                      // widget.isLoading
                      // ? SizedBox(
                      //     width: 20,
                      //     height: 20,
                      //     child: GlobalLoading(size:20, isWhite: false),
                      //   )
                      // : 
                      Icon(
                          widget.prefixIcon,
                          color: Colors.grey.shade700,
                          size: 24,
                        ),
                ),
                Expanded(
                  child: DropdownButtonFormField<int>(
                    value: widget.value,
                    items: widget.items,
                    onChanged: widget.onChanged,
                    isExpanded: true,
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                    style: const TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 16.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      hintText: widget.isLoading ? '${context.t.common.loading_data.ucfirstChar()}...' : widget.hintText,
                      hintStyle: const TextStyle(
                        fontFamily: 'Montserrat',
                        color: Color.fromRGBO(163, 163, 163, 1.0),
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.only(
                        top: 12.0,
                        bottom: 12.0,
                        right: 12.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLargeStyle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null && widget.label!.isNotEmpty) ...[
          Text(widget.label!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, fontFamily: 'Montserrat')),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<int>(
          value: widget.value,
          items: widget.items,
          onChanged: widget.onChanged,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          decoration: InputDecoration(
            hintText: widget.isLoading ? 'Memuat data...' : widget.hintText,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14, fontFamily: 'Montserrat'),
            prefixIcon: 
                // widget.isLoading
                // ? Container(
                //     padding: const EdgeInsets.all(12),
                //     width: 20,
                //     height: 20,
                //     child: GlobalLoading(size:20, isWhite: false),
                //   )
                // : 
                Icon(widget.prefixIcon, color: Colors.orange, size: 20),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.orange, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.styleType == DropdownStyleType.large) {
      return _buildLargeStyle();
    }
    return _buildRegularStyle();
  }
}