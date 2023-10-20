import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kaibo/resources/lang.dart';
import 'package:kaibo/resources/images.dart';
import 'package:kaibo/resources/styles.dart';
import 'package:kaibo/utils/custom_ext.dart';
import 'package:kaibo/widgets/custom_recaptcha.dart';
import 'package:sprintf/sprintf.dart';

enum InputBoxType {
  phone,
  account,
  password,
  verificationCode,
  search,
  textBox,
  numberBox,
  recaptcha,
  bank,
}

class InputBox extends StatefulWidget {
  const InputBox.phone({
    super.key,
    required this.label,
    required this.code,
    this.onAreaCode,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.codeStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.phone,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.password({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = true,
        type = InputBoxType.password,
        codeStyle = null,
        code = '',
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.verificationCode({
    super.key,
    required this.label,
    this.onSendVerificationCode,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.verificationCode,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.search({
    super.key,
    required this.label,
    required this.onSearch,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.search,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.textBox({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.formatHintStyle,
    this.hintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.textBox,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.numberBox({
    super.key,
    required this.label,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.numberBox,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null,
        onBank = null;

  const InputBox.recaptcha({
    super.key,
    required this.label,
    required this.recaptcha,
    required this.onRecaptcha,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.recaptcha,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        onBank = null;

  const InputBox.bank({
    super.key,
    required this.label,
    required this.onBank,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.formatHintStyle,
    this.hintText,
    this.formatHintText,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly,
    this.backgroundColor,
  })  : obscureText = false,
        type = InputBoxType.bank,
        code = '',
        codeStyle = null,
        onAreaCode = null,
        arrowColor = null,
        clearBtnColor = null,
        onSendVerificationCode = null,
        onSearch = null,
        recaptcha = null,
        onRecaptcha = null;

  const InputBox({
    Key? key,
    required this.label,
    this.controller,
    this.focusNode,
    this.labelStyle,
    this.textStyle,
    this.hintStyle,
    this.codeStyle,
    this.formatHintStyle,
    this.code = '+86',
    this.hintText,
    this.formatHintText,
    this.arrowColor,
    this.clearBtnColor,
    this.obscureText = false,
    this.type = InputBoxType.account,
    this.onAreaCode,
    this.onSendVerificationCode,
    this.margin,
    this.inputFormatters,
    this.leadingIcon,
    this.readOnly = false,
    this.onSearch,
    this.backgroundColor,
    this.recaptcha,
    this.onRecaptcha,
    this.onBank,
  }) : super(key: key);
  final TextStyle? labelStyle;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? codeStyle;
  final TextStyle? formatHintStyle;
  final String code;
  final String label;
  final String? hintText;
  final String? formatHintText;
  final Color? arrowColor;
  final Color? clearBtnColor;
  final bool obscureText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputBoxType type;
  final Function()? onAreaCode;
  final Future<bool> Function()? onSendVerificationCode;
  final EdgeInsetsGeometry? margin;
  final List<TextInputFormatter>? inputFormatters;
  final String? leadingIcon;
  final bool? readOnly;
  final Function? onSearch;
  final Color? backgroundColor;
  final String? recaptcha;
  final Function()? onRecaptcha;
  final Function()? onBank;

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  late bool _obscureText;
  bool _showClearBtn = false;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    widget.controller?.addListener(_onChanged);
    super.initState();
  }

  void _onChanged() {
    setState(() {
      _showClearBtn = widget.controller!.text.isNotEmpty;
    });
  }

  void _toggleEye() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.label,
            style: widget.labelStyle ?? Styles.tsDefaultTxtClr14sp,
          ),
          6.verticalSpace,
          Container(
            height: 52.h,
            padding: (widget.type == InputBoxType.search ||
                    widget.type == InputBoxType.recaptcha)
                ? EdgeInsets.only(left: 12.w)
                : EdgeInsets.only(left: 12.w, right: 8.w),
            decoration: BoxDecoration(
              border: (widget.type == InputBoxType.search ||
                      widget.type == InputBoxType.recaptcha)
                  ? Border.all(color: Styles.c_E2F2D1, width: 0)
                  : Border.all(color: Styles.c_E2F2D1, width: 1),
              borderRadius: BorderRadius.circular(8.r),
              color: widget.backgroundColor ?? Styles.c_E2F2D1,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: widget.leadingIcon?.toImage
                    ?..width = 25.w
                    ..height = 25.h,
                ),
                15.horizontalSpace,
                _textField,
                _clearBtn,
                _eyeBtn,
                if (widget.type == InputBoxType.verificationCode)
                  VerifyCodedButton(
                    onTapCallback: widget.onSendVerificationCode,
                  ),
                if (widget.type == InputBoxType.search) _searchBtn,
                if (widget.type == InputBoxType.recaptcha) _recaptchaBtn,
                if (widget.type == InputBoxType.bank) _bankView,
              ],
            ),
          ),
          if (null != widget.formatHintText)
            Padding(
              padding: EdgeInsets.only(top: 5.h),
              child: Text(
                widget.formatHintText!,
                style: widget.formatHintStyle ?? Styles.ts_8E9AB0_12sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget get _textField => Theme(
        data: ThemeData(
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Styles.theme, // 设置光标颜色
          ),
        ),
        child: Expanded(
          child: TextField(
            controller: widget.controller,
            keyboardType: _textInputType,
            textInputAction: TextInputAction.next,
            style: widget.textStyle ?? Styles.tsDefaultTxtClr17sp,
            autofocus: false,
            readOnly: widget.readOnly ?? false,
            obscureText: _obscureText,
            inputFormatters: [
              if (widget.type == InputBoxType.phone ||
                  widget.type == InputBoxType.verificationCode ||
                  widget.type == InputBoxType.numberBox)
                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              if (null != widget.inputFormatters) ...widget.inputFormatters!,
            ],
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? Styles.ts_8E9AB0_14sp,
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ),
      );

  Widget get _clearBtn => Visibility(
        visible: _showClearBtn && !(widget.readOnly ?? false),
        child: GestureDetector(
          onTap: () {
            widget.controller?.clear();
          },
          behavior: HitTestBehavior.translucent,
          child: ImageStr.clearText.toImage
            ..width = 24.w
            ..height = 24.h,
        ),
      );

  Widget get _eyeBtn => Visibility(
        visible: widget.type == InputBoxType.password,
        child: GestureDetector(
          onTap: _toggleEye,
          behavior: HitTestBehavior.translucent,
          child: (_obscureText
              ? ImageStr.eyeClose.toImage
              : ImageStr.eyeOpen.toImage)
            ..width = 24.w
            ..height = 24.h,
        ),
      );

  Widget get _searchBtn => Visibility(
        visible: widget.type == InputBoxType.search,
        child: GestureDetector(
          onTap: widget.onSearch?.call(),
          behavior: HitTestBehavior.translucent,
          child: Container(
            width: 70.w,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Styles.defaultBtnBgClr,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8.r),
                bottomRight: Radius.circular(8.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: ImageStr.icSearch.toImage
                ..width = 25.w
                ..height = 25.h,
            ),
          ),
        ),
      );

  Widget get _recaptchaBtn {
    final recaptcha = widget.recaptcha ?? "";
    return GestureDetector(
      onTap: widget.onRecaptcha?.call(),
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 100.w,
        height: double.infinity,
        decoration: BoxDecoration(
          color: recaptcha.isNotEmpty
              ? Colors.transparent
              : Styles.defaultBtnBgClr,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(8.r),
            bottomRight: Radius.circular(8.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: recaptcha.isNotEmpty
            ? CustomRecaptcha(
                recaptcha: widget.recaptcha,
              )
            : Center(
                child: Text(
                  Globe.getRecaptcha,
                  style: Styles.tsDefaultTxtClr14sp,
                ),
              ),
      ),
    );
  }

  Widget get _bankView => GestureDetector(
        onTap: widget.onAreaCode,
        behavior: HitTestBehavior.translucent,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.code,
              style: widget.codeStyle ?? Styles.ts_0C1C33_17sp,
            ),
            8.horizontalSpace,
            ImageStr.icArrowDown.toImage
              ..width = 8.49.w
              ..height = 8.49.h,
            Container(
              width: 1.w,
              height: 26.h,
              margin: EdgeInsets.symmetric(horizontal: 14.w),
              decoration: BoxDecoration(
                color: Styles.c_E8EAEF,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ],
        ),
      );

  TextInputType? get _textInputType {
    TextInputType? keyboardType;
    switch (widget.type) {
      case InputBoxType.phone:
        keyboardType = TextInputType.phone;
        break;
      case InputBoxType.account:
        keyboardType = TextInputType.text;
        break;
      case InputBoxType.password:
        keyboardType = TextInputType.text;
        break;
      case InputBoxType.verificationCode:
        keyboardType = TextInputType.number;
        break;
      case InputBoxType.search:
        keyboardType = TextInputType.text;
        break;
      case InputBoxType.textBox:
        keyboardType = TextInputType.text;
        break;
      case InputBoxType.numberBox:
        keyboardType = TextInputType.number;
        break;
      case InputBoxType.recaptcha:
        keyboardType = TextInputType.number;
        break;
      case InputBoxType.bank:
        keyboardType = TextInputType.number;
        break;
    }
    return keyboardType;
  }
}

class VerifyCodedButton extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int seconds;

  /// 用户点击时的回调函数。
  final Future<bool> Function()? onTapCallback;

  const VerifyCodedButton({
    Key? key,
    this.seconds = 60,
    required this.onTapCallback,
  }) : super(key: key);

  @override
  State<VerifyCodedButton> createState() => _VerifyCodedButtonState();
}

class _VerifyCodedButtonState extends State<VerifyCodedButton> {
  Timer? _timer;
  late int _seconds;
  bool _firstTime = true;

  @override
  void dispose() {
    _cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _seconds = widget.seconds;
  }

  void _start() {
    _firstTime = false;
    _timer = Timer.periodic(1.seconds, (timer) {
      if (!mounted) return;
      if (_seconds == 0) {
        _cancel();
        setState(() {});
        return;
      }
      _seconds--;
      setState(() {});
    });
  }

  void _cancel() {
    if (null != _timer) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void _reset() {
    if (_seconds != widget.seconds) {
      _seconds = widget.seconds;
    }
    _cancel();
    setState(() {});
  }

  void _restart() {
    _reset();
    _start();
  }

  bool get _isEnabled => _seconds == 0 || _firstTime;

  @override
  Widget build(BuildContext context) => _firstTime
      ? (Globe.sendVerificationCode.toText
        ..style = Styles.tsTheme12sp
        ..onTap = () {
          widget.onTapCallback?.call().then((start) {
            if (start) _restart();
          });
        })
      : (_isEnabled
          ? (Globe.resendVerificationCode.toText
            ..style = Styles.tsTheme12sp
            ..onTap = () {
              widget.onTapCallback?.call().then((start) {
                if (start) _restart();
              });
            })
          : Text(
              sprintf(Globe.verificationCodeTimingReminder, [_seconds]),
              style: Styles.ts_8E9AB0_12sp,
            ));
}
