import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
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
  final int? maxLength;

  const CustomTextField({
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
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late FocusNode _focusNode;
  int _charLength = 0;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
    widget.controller?.addListener(_onFocusChange);
    if (widget.controller != null) {
      _charLength = widget.controller!.text.length;
      widget.controller!.addListener(_updateCharLength);
    }
  }

  void _updateCharLength() {
    final newLength = widget.controller?.text.length ?? 0;
    if (newLength != _charLength) {
      setState(() => _charLength = newLength);
    }
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    widget.controller?.removeListener(_onFocusChange);
    widget.controller?.removeListener(_updateCharLength);
    super.dispose();
  }

  // bool get _isLabelFloating {
  //   final hasFocus = _focusNode.hasFocus;
  //   final hasText = widget.controller?.text.isNotEmpty ?? false;
  //   return hasFocus || hasText;
  // }

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      validator: widget.validator,
      initialValue: widget.controller?.text,
      builder: (FormFieldState<String> state) {
        return SizedBox(
          width: widget.width,
          child: Column(
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
                      : (state.hasError
                          ? Border.all(color: Colors.redAccent, width: 2.0)
                          : Border.all(color: Colors.transparent, width: 2.0)),
                ),
                child: Row(
                  crossAxisAlignment: widget.maxLines > 1
                      ? CrossAxisAlignment.start
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
                          ? const EdgeInsets.only(
                              left: 12.0, top: 26.0, right: 12.0)
                          : const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Icon(
                        widget.prefixIcon,
                        color: Colors.grey.shade700,
                        size: 24,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: widget.controller,
                        focusNode: _focusNode,
                        obscureText: widget.obscureText,
                        keyboardType: widget.keyboardType,
                        textCapitalization: widget.textCapitalization ??
                            TextCapitalization.sentences,
                        onChanged: (val) {
                          state.didChange(val);
                          if (widget.onChanged != null) widget.onChanged!(val);
                        },
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
                          labelText: (widget.hintTextToLabelText ??
                                  widget.hintText != null)
                              ? widget.hintText
                              : null,
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
              if (state.hasError || widget.maxLength != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: state.hasError
                          ? Text(
                              state.errorText!,
                              style: const TextStyle(
                                color: Colors.redAccent,
                                fontSize: 12,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500,
                              ),
                            )
                          : const SizedBox(),
                    ),
                    if (widget.maxLength != null)
                      Text(
                        "$_charLength/${widget.maxLength}",
                        style: TextStyle(
                          fontSize: 12,
                          color: _charLength > widget.maxLength!
                              ? Colors.red
                              : Colors.grey,
                          fontFamily: 'Montserrat',
                        ),
                      ),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
