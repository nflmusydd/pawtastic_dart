import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFieldRow extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final bool? hintTextToLabelText;
  final Color backgroundColor;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextCapitalization? textCapitalization;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final double width;
  final Widget? suffixIcon;
  final bool readOnly;
  final VoidCallback? onTap;
  final int maxLines;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextFieldRow({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.hintTextToLabelText,
    this.backgroundColor = const Color.fromRGBO(228, 228, 228, 0.612),
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.textCapitalization,
    this.validator,
    this.onChanged,
    this.width = 350,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.maxLines = 1,
    this.inputFormatters,
  });

  @override
  State<CustomTextFieldRow> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextFieldRow> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller?.removeListener(_onFocusChange);
    super.dispose();
  }

  // bool get _isLabelFloating {
  //   final hasFocus = _focusNode.hasFocus;
  //   final hasText = widget.controller?.text.isNotEmpty ?? false;
  //   return hasFocus || hasText;
  // }

  @override
  Widget build(BuildContext context) {
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
          width: widget.width,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(10.0),
            border: _focusNode.hasFocus
                ? Border.all(
                    color: const Color.fromRGBO(252, 148, 3, 0.605),
                    width: 2.0,
                  )
                : Border.all(
                    color: Colors.transparent, // Mencegah layout bergeser/kedip saat border muncul
                    width: 2.0,
                  ),
          ),
          child: Row(
            crossAxisAlignment: widget.maxLines > 1
                ? CrossAxisAlignment.start  // Multiline merapat ke atas
                : CrossAxisAlignment.center,
            children: [
              // if (widget.maxLines > 1)   //DIMATIKAN SEMENTARA karena hintText masih tidak sejajar dengan icon
              //   AnimatedPadding(
              //     duration: const Duration(milliseconds: 200),
              //     curve: Curves.easeInOut,
              //     padding: EdgeInsets.only(
              //       left: 12.0,
              //       top: _isLabelFloating ? 28.0 : 22.0, 
              //       right: 12.0,
              //     ),
              //     child: Icon(
              //       widget.prefixIcon,
              //       color: Colors.grey.shade700,
              //       size: 24,
              //     ),
              //   )
              // else  
                Padding(
                  padding: widget.maxLines > 1
                    ? const EdgeInsets.only(left: 12.0, top: 26.0, right: 12.0,)
                    : const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Icon(
                    widget.prefixIcon,
                    color: Colors.grey.shade700,
                    size: 24,
                  ),
                ),

              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  textCapitalization: widget.textCapitalization ?? TextCapitalization.sentences,
                  validator: widget.validator,
                  onChanged: widget.onChanged,
                  readOnly: widget.readOnly,
                  onTap: widget.onTap,
                  maxLines: widget.maxLines,
                  inputFormatters: widget.inputFormatters,
                  style: const TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    alignLabelWithHint: widget.maxLines > 1,
                    labelText: (widget.hintTextToLabelText ?? widget.hintText != null)  // hintText sebagai labelText secara default
                              ? widget.hintText
                              : null,
                    
                    // styling posisi belum fokus atau ada teks
                    labelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(163, 163, 163, 1.0),
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                    ),

                    // styling saat fokus
                    floatingLabelStyle: const TextStyle(
                      fontFamily: 'Montserrat',
                      color: Color.fromRGBO(252, 148, 3, 0.8), 
                      fontSize: 14.0,
                      fontWeight: FontWeight.w700,
                    ),

                    // hapus/comment hintText biar teks gak dobel
                    // hintText: widget.hintText, 

                    filled: false,
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
                    suffixIcon: widget.suffixIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}