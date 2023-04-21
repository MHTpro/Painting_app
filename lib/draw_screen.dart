import 'package:flutter/material.dart';

import 'dart:io';
import 'dart:ui';

import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class Draw extends StatefulWidget {
  const Draw({super.key});

  @override
  DrawState createState() => DrawState();
}

class DrawState extends State<Draw> {
  Color selectedColor = Colors.black;
  Color pickerColor = Colors.black;
  double strokeWidth = 3.0;
  List<DrawingPoints?> points = [];
  bool showBottomList = false;
  double opacity = 1.0;
  StrokeCap strokeCap = (Platform.isAndroid) ? StrokeCap.butt : StrokeCap.round;
  SelectedMode selectedMode = SelectedMode.strokeWidth;
  List<Color> colors = <Color>[
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.amber,
    Colors.white
  ];

  //bg
  Color backgoundColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgoundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.black,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          semanticLabel: "Thikness",
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (selectedMode == SelectedMode.strokeWidth) {
                                showBottomList = !showBottomList;
                              }
                              selectedMode = SelectedMode.strokeWidth;
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.opacity,
                          color: Colors.white,
                          semanticLabel: "Opacity",
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (selectedMode == SelectedMode.opacity) {
                                showBottomList = !showBottomList;
                              }
                              selectedMode = SelectedMode.opacity;
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.color_lens,
                          color: Colors.white,
                          semanticLabel: "Colors",
                        ),
                        onPressed: () {
                          setState(
                            () {
                              if (selectedMode == SelectedMode.color) {
                                showBottomList = !showBottomList;
                              }
                              selectedMode = SelectedMode.color;
                            },
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.delete_rounded,
                          color: Colors.white,
                          semanticLabel: "Delete",
                        ),
                        onPressed: () {
                          setState(
                            () {
                              showBottomList = false;
                            },
                          );
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                content: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    //Eraser
                                    IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            selectedColor = backgoundColor;
                                            Navigator.of(context).pop(true);
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.cleaning_services_rounded,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),

                                    //Delete
                                    IconButton(
                                      onPressed: () {
                                        setState(
                                          () {
                                            points.clear();
                                            Navigator.of(context).pop(true);
                                          },
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.white,
                                        size: 40.0,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),

                      //background --start
                      IconButton(
                        icon: const Icon(
                          Icons.format_color_fill_rounded,
                          color: Colors.white,
                          semanticLabel: "BG color",
                        ),
                        onPressed: () {
                          setState(
                            () {
                              showBottomList = false;
                            },
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                content: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text(
                                      "Choose background Color!",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20.0,
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 16.0),
                                      child: Wrap(
                                        spacing: 10.0,
                                        runSpacing: 10.0,
                                        children: <Widget>[
                                          circlebackgroundColor(
                                              bgColor: Colors.blue),
                                          circlebackgroundColor(
                                              bgColor: Colors.red),
                                          circlebackgroundColor(
                                              bgColor: Colors.yellow),
                                          circlebackgroundColor(
                                              bgColor: Colors.green),
                                          circlebackgroundColor(
                                              bgColor: Colors.cyan),
                                          circlebackgroundColor(
                                              bgColor: Colors.pink),
                                          circlebackgroundColor(
                                              bgColor: Colors.purple),
                                          circlebackgroundColor(
                                              bgColor: Colors.white),
                                          circlebackgroundColor(
                                              bgColor: Colors.brown),
                                          circlebackgroundColor(
                                              bgColor: Colors.white10),
                                          circlebackgroundColor(
                                              bgColor: Colors.lime),
                                          circlebackgroundColor(
                                              bgColor: Colors.orange),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                      //background --end
                    ],
                  ),
                  Visibility(
                    visible: showBottomList,
                    child: (selectedMode == SelectedMode.color)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: getColorList(),
                          )
                        : Slider(
                            activeColor: Colors.white,
                            value: (selectedMode == SelectedMode.strokeWidth)
                                ? strokeWidth
                                : opacity,
                            max: (selectedMode == SelectedMode.strokeWidth)
                                ? 50.0
                                : 1.0,
                            min: 0.0,
                            onChanged: (val) {
                              setState(
                                () {
                                  if (selectedMode ==
                                      SelectedMode.strokeWidth) {
                                    strokeWidth = val;
                                  } else {
                                    opacity = val;
                                  }
                                },
                              );
                            },
                          ),
                  ),
                ],
              ),
            )),
      ),
      body: GestureDetector(
        onPanUpdate: (details) {
          setState(
            () {
              var findR = context.findRenderObject();
              RenderBox renderBox = findR as RenderBox;
              points.add(
                DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth,
                ),
              );
            },
          );
        },
        onPanStart: (details) {
          setState(
            () {
              var findR = context.findRenderObject();
              RenderBox renderBox = findR as RenderBox;
              points.add(
                DrawingPoints(
                  points: renderBox.globalToLocal(details.globalPosition),
                  paint: Paint()
                    ..strokeCap = strokeCap
                    ..isAntiAlias = true
                    ..color = selectedColor.withOpacity(opacity)
                    ..strokeWidth = strokeWidth,
                ),
              );
            },
          );
        },
        onPanEnd: (details) {
          setState(
            () {
              points.add(null);
            },
          );
        },
        child: CustomPaint(
          size: Size.infinite,
          painter: DrawingPainter(
            pointsList: points,
          ),
        ),
      ),
    );
  }

  GestureDetector circlebackgroundColor({required Color bgColor}) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            backgoundColor = bgColor;
          },
        );
        Navigator.of(context).pop(true);
      },
      child: ClipOval(
        child: Container(
          height: 50.0,
          width: 50.0,
          color: bgColor,
        ),
      ),
    );
  }

  getColorList() {
    List<Widget> listWidget = [];
    for (Color color in colors) {
      listWidget.add(
        colorCircle(color),
      );
    }
    Widget colorPicker = GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.black,
              title: const Text(
                'Pick a color!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
              ),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: pickerColor,
                  onColorChanged: (color) {
                    pickerColor = color;
                  },
                  labelTypes: const [],
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                      ),
                    ),
                    onPressed: () {
                      setState(() => selectedColor = pickerColor);
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.red,
                Colors.red,
                Colors.green,
                Colors.blue,
                Colors.amber,
                Colors.amber
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
    );
    listWidget.add(colorPicker);
    return listWidget;
  }

  Widget colorCircle(Color color) {
    return GestureDetector(
      onTap: () {
        setState(
          () {
            selectedColor = color;
          },
        );
      },
      child: ClipOval(
        child: Container(
          padding: const EdgeInsets.only(bottom: 16.0),
          height: 36,
          width: 36,
          color: color,
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  DrawingPainter({this.pointsList});
  List<DrawingPoints?>? pointsList;
  List<Offset> offsetPoints = [];
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList!.length - 1; i++) {
      if (pointsList![i] != null && pointsList![i + 1] != null) {
        canvas.drawLine(pointsList![i]!.points!, pointsList![i + 1]!.points!,
            pointsList![i]!.paint!);
      } else if (pointsList![i] != null && pointsList![i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList![i]!.points!);
        offsetPoints.add(Offset(pointsList![i]!.points!.dx + 0.1,
            pointsList![i]!.points!.dy + 0.1));
        canvas.drawPoints(
            PointMode.points, offsetPoints, pointsList![i]!.paint!);
      }
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}

class DrawingPoints {
  Paint? paint;
  Offset? points;
  DrawingPoints({this.points, this.paint});
}

enum SelectedMode { strokeWidth, opacity, color }
