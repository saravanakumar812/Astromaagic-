import 'package:astromaagic/Components/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTab extends StatelessWidget {
  final EdgeInsets? margin, padding;
  final bool isSelected;
  final String titleOne;
  final String titleTwo;
  final String titleThree;
  final String titleFour;
  final Function() onClick;
  final bool disable;

  const AppTab({
    this.margin,
    this.padding,
    this.isSelected = false,
    required this.onClick,
    this.disable = false,
    required this.titleOne,
    required this.titleTwo,
    required this.titleThree,
    required this.titleFour,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Visibility(
      visible: !disable,
      child: GestureDetector(
          onTap: () => onClick(),
          child: Container(
            margin: EdgeInsets.only(left: 15, right: 15, top: 10),
            width: width,
            height: height * 0.15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected
                    ? AppTheme.primaryColor
                    : AppTheme.screenBackground,
                border: Border.all(color: AppTheme.primaryColor, width: 2)),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15, bottom: 20),
                  width: width * 0.43,
                  height: height * 0.15,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        titleOne,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'lato',
                            color:
                                isSelected ? AppTheme.appBlack : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        titleTwo,
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'lato',
                            color:
                                isSelected ? AppTheme.appBlack : Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.43,
                  height: height * 0.15,
                  child: Container(
                    margin: EdgeInsets.all(20),
                    width: width * 0.45,
                    height: height * 0.15,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: isSelected
                            ? AppTheme.screenBackground
                            : AppTheme.primaryColor,
                        border:
                            Border.all(color: AppTheme.primaryColor, width: 2)),
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleThree,
                            style: TextStyle(
                                fontFamily: 'lato',
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.appBlack,
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            titleFour,
                            style: TextStyle(
                                fontFamily: 'lato',
                                fontSize: 14,
                                color: isSelected
                                    ? Colors.white
                                    : AppTheme.appBlack,
                                fontWeight: FontWeight.w800),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
