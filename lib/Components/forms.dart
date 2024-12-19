import 'package:astromaagic/Components/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

class TextInput extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final bool isCapsNumeric;
  final double? height;
  final double? contentPaddingV;
  final String? hintText;
  final String? errorText;
  final bool obscureText;
  final bool margin;

  final bool isEntryField;
  final bool isSelected;
  final bool isMistake;
  final bool isCapital;
  final bool demoCar;
  final int? MaxLength;
  final bool isReadOnly;

  final Color textColor;
  final TextInputType? textInputType;
  final VoidCallback? onPressed;
  final String? icon;
  final void Function(String) onTextChange;
  final Icon? sufficIcon;
  final Icon? prefixIcon;

  final Color hintTextColor;
  final Color labelTextColor;

  const TextInput({
    required this.label,
    required this.onTextChange,
    this.obscureText = false,
    this.isReadOnly = false,
    this.isCapsNumeric = false,
    this.isEntryField = true,
    this.isSelected = false,
    this.isMistake = false,
    this.isCapital = false,
    this.demoCar = false,
    this.MaxLength,
    this.margin = true,
    this.controller,
    this.contentPaddingV,
    this.mainAxisSize = MainAxisSize.max,
    this.mainAxisAlignment = MainAxisAlignment.spaceEvenly,
    this.height,
    this.hintText,
    this.errorText,
    this.onPressed,
    this.textInputType,
    this.icon,
    this.sufficIcon,
    this.textColor = AppTheme.textColor,
    this.hintTextColor = AppTheme.lableColor90,
    this.labelTextColor = AppTheme.BorderLightGrey,
    this.prefixIcon,
  });

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool showPassword = false;
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> lines = widget.hintText!.split('\n');

    return Container(
      //color: widget.isEntryField ? AppTheme.screenBackground : Colors.white,
      margin: widget.margin
          ? EdgeInsets.fromLTRB(12, 0, 12, 0)
          : EdgeInsets.only(top: 2),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            widget.isEntryField
                ? Container(
                    decoration: BoxDecoration(
                        color: AppTheme.screenBackground,),
                       // borderRadius: BorderRadius.circular(10)),
                    height: 50,
                    child: Align(
                      alignment: Alignment.center,
                      child: TextFormField(
                        onTap: widget.onPressed,
                        // readOnly: widget.obscureText ? widget.isReadOnly ?  true:  true : false,
                        readOnly: widget.isReadOnly ? true : false,
                        keyboardType: widget.textInputType,
                        textCapitalization: widget.isCapital
                            ? TextCapitalization.characters
                            : TextCapitalization.sentences,
                        minLines:
                            widget.textInputType == TextInputType.multiline
                                ? 3
                                : 1,
                        maxLines:
                            widget.textInputType == TextInputType.multiline
                                ? 3
                                : 1,
                        inputFormatters: widget.isCapsNumeric
                            ? <TextInputFormatter>[
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9A-Z]")),
                              ]
                            : widget.textInputType! == TextInputType.number ||
                                    widget.textInputType! == TextInputType.phone
                                ? [
                                    FilteringTextInputFormatter.deny(
                                        RegExp(r'[!@#$%^&*(),.?":{}|<>]')),
                                  ]
                                : null,
                        maxLength: 80,
                        onChanged: widget.onTextChange,
                        controller: widget.controller,
                        style: TextStyle(
                            letterSpacing: 0.2,
                            color: widget.textColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: widget.label,
                          counter: Offstage(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(
                              color: widget.controller.isNull
                                  ? AppTheme.textColor
                                  : widget.controller!.value.text.isEmpty
                                      ? AppTheme.textColor
                                      : AppTheme.labelColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w500),
                          hintText: widget.hintText,
                          hintStyle: TextStyle(
                            color: AppTheme.appBlack,
                          ),
                          errorText: widget.errorText,
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: widget.contentPaddingV.isNull
                                  ? 5.0
                                  : widget.contentPaddingV!),
                          enabledBorder: OutlineInputBorder(
                           // borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(width: 1.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                           // borderRadius: BorderRadius.circular(10.0),
                            borderSide: widget.isMistake
                                ? BorderSide(
                                    color: Colors.deepOrangeAccent, width: 1.0)
                                : BorderSide(
                                    color:AppTheme.screenBackground, width: 1.0),
                          ),
                          prefixIcon: widget.obscureText
                              ? IconButton(
                                  padding: EdgeInsets.all(15.0),
                                  color: Color(0xff252525),
                                  onPressed: widget.onPressed,
                                  icon: widget.prefixIcon == null
                                      ? const Icon(Icons.keyboard_arrow_down)
                                      : widget.prefixIcon!,
                                )
                              : null,
                        ).copyWith(
                          focusedBorder:
                              FormThemes.inputOutlineBorder['focusedBorder'],
                          border: FormThemes.inputOutlineBorder['border'],
                          errorBorder:
                              FormThemes.inputOutlineBorder['errorBorder'],
                          disabledBorder:
                              FormThemes.inputOutlineBorder['disabledBorder'],
                          enabledBorder: OutlineInputBorder(
                           // borderRadius: BorderRadius.circular(10.0),
                            borderSide: widget.isMistake
                                ? BorderSide(
                                    color: Colors.deepOrangeAccent, width: 1.0)
                                : BorderSide(
                                    color: AppTheme.screenBackground, width: 1.0),
                          ),
                        ),
                      ),
                    ),
                  )
                : widget.demoCar
                    ? InkWell(
                        onTap: widget.onPressed,
                        child: Container(
                          margin: EdgeInsets.fromLTRB(3, 0, 3, 0),
                          decoration: BoxDecoration(
                            color: widget.isSelected
                                ? AppTheme.selectedOrange
                                : AppTheme.screenBackground,
                           // borderRadius: BorderRadius.circular(10),
                          ),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.fromLTRB(10, 7, 10, 7),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  lines[0],
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      color: widget.isSelected
                                          ? Colors.deepOrangeAccent
                                          : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  lines[1],
                                  style: TextStyle(
                                      color: widget.isSelected
                                          ? Colors.deepOrangeAccent
                                          : Colors.black,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : Material(
                        color: widget.isSelected
                            ? AppTheme.selectedOrange
                            : AppTheme.screenBackground,
                        // borderRadius: BorderRadius.all(Radius.circular(10.0),),
                        child: TextFormField(
                          controller: _controller,
                          readOnly: true,
                          minLines: 1,
                          maxLines: 2,
                          maxLength: widget.MaxLength,
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              color: widget.textColor,
                              fontWeight: FontWeight.w400,
                              fontSize: 14),
                          onTap: widget.onPressed,
                          inputFormatters: [
                            TextInputFormatter.withFunction(
                                (oldValue, newValue) {
                              final textLines = newValue.text.split('\n');
                              if (textLines.length > 1 &&
                                  textLines[1].isNotEmpty) {
                                final newText = textLines.join('\n');
                                final newValue = TextEditingValue(
                                  text: newText,
                                  selection: TextSelection.collapsed(
                                      offset: newText.length),
                                );
                                _controller.value = newValue;
                                setState(() {});
                                return newValue;
                              }
                              return newValue;
                            }),
                          ],
                          decoration: InputDecoration(
                            labelStyle: const TextStyle(
                              color: Colors.black,
                            ),
                            hintText: widget.hintText,
                            hintStyle: TextStyle(
                                color: widget.isSelected
                                    ? AppTheme.white
                                    : Colors.white),
                            errorText: widget.errorText,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 0.0),
                          ).copyWith(
                            border: FormThemes.inputOutlineBorder['border'],
                            errorBorder:
                                FormThemes.inputOutlineBorder['errorBorder'],
                            disabledBorder:
                                FormThemes.inputOutlineBorder['disabledBorder'],
                            enabledBorder: OutlineInputBorder(
                              //borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide(
                                color: widget.isSelected
                                    ? AppTheme.screenBackground
                                    : AppTheme.screenBackground,
                                width: 1.0,
                              ),
                            ),
                          ),
                        ),
                      )
          ]),
    );
  }
}

class Button extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  Button({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0), side: borderColor)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class AllCategoryCard extends StatelessWidget {
  final double? width;
  final double? height;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final String title;
  final Function() onClick;
  final bool disable;
  final bool isSelected;

  AllCategoryCard({
    this.width,
    this.height,
    required this.radius,
    this.margin,
    this.child,
    this.isSelected = false,
    this.title = '',
    required this.onClick,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !disable,
      child: GestureDetector(
        onTap: () => onClick(),
        child: Container(
          height: height,
          width: width,
          margin: margin,
          decoration: BoxDecoration(
            color: isSelected ? AppTheme.primaryColor : Colors.yellow[100],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? AppTheme.primaryColor : Colors.white,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class AppButton2 extends StatelessWidget {
  final double width;
  final double height;
  final String title;
  final double fontSize;
  final VoidCallback onPressed;
  final Color titleColor;
  final Color color;
  final Color borderColor;
  final FontWeight fontWeight;

  const AppButton2({
    required this.width,
    required this.height,
    required this.title,
    required this.fontSize,
    required this.onPressed,
    required this.titleColor,
    required this.color,
    required this.borderColor,
    this.fontWeight = FontWeight.w600,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: titleColor,
          backgroundColor: color,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor),
          ),
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            fontFamily: GoogleFonts.inter().fontFamily,
          ),
        ),
      ),
    );
  }
}

class AppSnackBar {
  String title;
  String message;

  AppSnackBar({required this.title, required this.message}) {
    print("HERE");
  }

  AppSnackBar.error({
    required this.message,
    this.title = "Error",
  }) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.redAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.success({required this.message, this.title = "Success"}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.greenAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }

  AppSnackBar.warning({required this.title, required this.message}) {
    Get.closeAllSnackbars();
    Get.snackbar(title, message,
        backgroundColor: Colors.orangeAccent,
        margin: const EdgeInsets.all(10.0),
        forwardAnimationCurve: Curves.easeOutBack);
  }
}

class ButtonWithoutBackground extends StatelessWidget {
  final Widget child;
  final double widthFactor;
  final double heightFactor;
  final VoidCallback? onPressed;
  final BorderSide borderColor;

  ButtonWithoutBackground({
    Key? key,
    required this.child,
    this.onPressed,
    this.widthFactor = 0.4,
    this.heightFactor = 0.06,
    this.borderColor = BorderSide.none,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Container(
      height: screenSize.height * heightFactor,
      width: widthFactor != 0 ? screenSize.width * widthFactor : null,
      decoration: BoxDecoration(
          color: AppTheme.App_color, borderRadius: BorderRadius.circular(5)),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            elevation: 0,
            // Elevation
            shadowColor: AppTheme.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppTheme.primaryColor)) // Shadow Color
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

