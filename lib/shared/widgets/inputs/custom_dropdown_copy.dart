import 'package:flutter/material.dart';
import 'package:pawtastic/core/utils/core_utils.dart';
import 'package:pawtastic/i10n/strings.g.dart';

enum DropdownStyleType { regular, large }

class CustomDropdown extends StatefulWidget {
  final String? label;
  final String? labelText;
  final String? hintText;
  final bool? hintTextToLabelText;
  final int? value;
  final List<DropdownMenuItem<int>> items;
  final ValueChanged<int?> onChanged;
  final bool isLoading;
  final IconData prefixIcon;
  final DropdownStyleType styleType;
  final String? Function(int?)? validator;

  const CustomDropdown._({
    super.key,
    this.label,
    this.labelText,
    this.hintText,
    this.hintTextToLabelText,
    required this.value,
    required this.items,
    required this.onChanged,
    this.isLoading = false,
    required this.prefixIcon,
    required this.styleType,
    this.validator,
  });

  /// Style biasa (mirip CustomTextFieldRow)
  factory CustomDropdown.regular({
    Key? key,
    String? label,
    String? labelText,
    String? hintText,
    bool? hintTextToLabelText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    bool isLoading = false,
    IconData prefixIcon = Icons.map_outlined,
    String? Function(int?)? validator,
  }) {
    return CustomDropdown._(
      key: key,
      label: label,
      labelText: labelText,
      hintText: hintText,
      hintTextToLabelText: hintTextToLabelText,
      value: value,
      items: items,
      onChanged: onChanged,
      isLoading: isLoading,
      prefixIcon: prefixIcon,
      styleType: DropdownStyleType.regular,
      validator: validator,
    );
  }

  /// Style besar dan modern (seperti di CreateShopPage)
  factory CustomDropdown.large({
    Key? key,
    String? label,
    String? labelText,
    String? hintText,
    bool? hintTextToLabelText,
    required int? value,
    required List<DropdownMenuItem<int>> items,
    required ValueChanged<int?> onChanged,
    bool isLoading = false,
    IconData prefixIcon = Icons.map_outlined,
    String? Function(int?)? validator,
  }) {
    return CustomDropdown._(
      key: key,
      label: label,
      labelText: labelText,
      hintText: hintText,
      hintTextToLabelText: hintTextToLabelText,
      value: value,
      items: items,
      onChanged: onChanged,
      isLoading: isLoading,
      prefixIcon: prefixIcon,
      styleType: DropdownStyleType.large,
      validator: validator,
    );
  }

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  final FocusNode _focusNode = FocusNode();
  final GlobalKey<FormFieldState<int>> _fieldKey = GlobalKey<FormFieldState<int>>();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(CustomDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // Sinkronisasi nilai internal FormField jika nilai dari parent berubah
      _fieldKey.currentState?.didChange(widget.value);
    }
  }

  void _handleFocusChange() {
    if (mounted) setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  List<Widget> _buildSelectedItems(BuildContext context) {
    return widget.items.map<Widget>((DropdownMenuItem<int> item) {
      final child = item.child as Text;
      return Text(
        child.data!,
        style: child.style?.copyWith(overflow: TextOverflow.ellipsis) ?? 
               const TextStyle(overflow: TextOverflow.ellipsis),
        maxLines: 1,
      );
    }).toList();
  }

  Widget _buildRegularStyle(FormFieldState<int> state) {
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
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(228, 228, 228, 0.612),
            borderRadius: BorderRadius.circular(10.0),
            border: _focusNode.hasFocus
                ? Border.all(
                    color: const Color.fromRGBO(252, 148, 3, 0.605),
                    width: 2.0,
                  )
                : (state.hasError
                    ? Border.all(color: Colors.redAccent, width: 2.0)
                    : Border.all(color: Colors.transparent, width: 2.0)),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: 
                    // widget.isLoading
                    // ? const SizedBox(
                    //     width: 24,
                    //     height: 24,
                    //     child: GlobalLoading()),
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
                  selectedItemBuilder: _buildSelectedItems,
                  onChanged: (val) {
                    state.didChange(val);
                    if (val != widget.value) {
                      widget.onChanged(val);
                    }
                  },
                  focusNode: _focusNode,
                  isExpanded: true,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: (widget.hintTextToLabelText ?? widget.hintText != null)
                        ? widget.hintText
                        : widget.labelText,
                    labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(163, 163, 163, 1.0),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    floatingLabelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(252, 148, 3, 0.8),
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),
                    hintText: !widget.isLoading
                              ? null
                              : widget.hintText != null
                                  ? '${context.t.common.loading_data_name(data: widget.hintText!).ucfirstChar()}...'
                                  : '${context.t.common.loading_data.ucfirstChar()}...',
                    hintStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(163, 163, 163, 1.0),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),
                    errorStyle: const TextStyle(height: 0, fontSize: 0),
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
        if (state.hasError) ...[
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              state.errorText!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildLargeStyle(FormFieldState<int> state) {
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
          selectedItemBuilder: _buildSelectedItems,
          onChanged: (val) {
            state.didChange(val);
            if (val != widget.value) {
              widget.onChanged(val);
            }
          },
          focusNode: _focusNode,
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.grey),
          decoration: InputDecoration(
            labelText: (widget.hintTextToLabelText ?? widget.hintText != null)
                ? widget.hintText
                : widget.labelText,
            labelStyle: const TextStyle(
              fontFamily: 'Montserrat',
              color: Color.fromRGBO(163, 163, 163, 1.0),
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
            floatingLabelStyle: const TextStyle(
              fontFamily: 'Montserrat',
              color: Colors.orange,
              fontSize: 13.0,
              fontWeight: FontWeight.w700,
            ),
            hintText: widget.isLoading ? '${context.t.common.loading_data.ucfirstChar()}...' : null,
            hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14, fontFamily: 'Montserrat'),
            prefixIcon: 
                // widget.isLoading
                // ? Container(
                //     padding: const EdgeInsets.all(12),
                //     width: 20,
                //     height: 20,
                //     child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.orange),
                //   )
                // : 
                Icon(widget.prefixIcon, color: Colors.orange, size: 20),
            filled: true,
            fillColor: Colors.grey[50],
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            errorStyle: const TextStyle(height: 0, fontSize: 0),
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
              borderSide: const BorderSide(color: Colors.redAccent, width: 2),
            ),
          ),
        ),
        if (state.hasError) ...[
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              state.errorText!,
              style: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormField<int>(
      key: _fieldKey,
      validator: widget.validator,
      initialValue: widget.value,
      builder: (FormFieldState<int> state) {
        if (widget.styleType == DropdownStyleType.large) {
          return _buildLargeStyle(state);
        }
        return _buildRegularStyle(state);
      },
    );
  }
}
