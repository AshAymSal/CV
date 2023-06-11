import 'dart:math' show pi;
import 'package:ecommernce/mainPage.dart';
import 'package:ecommernce/modules/settings/settingsPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomDrawerController {
  int s = 0;
  Function open = () {};
  Function close = () {};
  Function toggle = (Function f) {
    print("togggg  ");
    f();
  };
  bool isOpen = true;

  ValueNotifier<DrawerState>? stateNotifier;

  CustomDrawerController(this.open, this.close, this.toggle, this.isOpen);
  /*void setToggle(Function f, int fq) {
    print("setTooogle");
    toggle = f;
    s = fq;
    print(s);
  }*/
}

class CustomDrawer extends StatefulWidget {
  CustomDrawer({
    //required this.controller,
    //required this.menuScreen,
    // required this.mainScreen,
    this.slideWidth = 275.0,
    this.borderRadius = 16.0,
    this.angle = -12.0,
    this.backgroundColor = Colors.white,
    this.showShadow = false,
    this.openCurve,
    this.closeCurve,
  }) : assert(angle <= 0.0 && angle >= -30.0);

  //final CustomDrawerController controller;

  // final Widget menuScreen;
  // final Widget mainScreen;
  final double slideWidth;
  final double borderRadius;
  final double angle;
  final Color backgroundColor;
  final bool showShadow;
  final Curve? openCurve;
  final Curve? closeCurve;

  @override
  _CustomDrawerState createState() => _CustomDrawerState();

  /// static function to provide the drawer state
  // static State<CustomDrawer>? of(BuildContext context) {
  // return context.findAncestorStateOfType<State<CustomDrawer>>();
  //}

  /// Static function to determine the device text direction RTL/LTR
  static bool isRTL(BuildContext context) {
    return false;
    //  return !Provider.of<LocalizationProvider>(context, listen: false).isLtr;
  }
}

class _CustomDrawerState extends State<CustomDrawer>
    with SingleTickerProviderStateMixin {
  final Curve _scaleDownCurve = Interval(0.0, 0.3, curve: Curves.easeOut);
  final Curve _scaleUpCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  final Curve _slideOutCurve = Interval(0.0, 1.0, curve: Curves.easeOut);
  final Curve _slideInCurve =
      Interval(0.0, 1.0, curve: Curves.easeOut); // Curves.bounceOut

  /// check the slide direction
  ///

  late CustomDrawerController controller;

  AnimationController? _animationController;
  DrawerState _state = DrawerState.closed;

  double get _percentOpen => _animationController!.value;

  open() {
    print("ooop");

    _animationController!.forward();
  }

  close() {
    print("cloooos");

    _animationController!.reverse();
  }

  toggle() {
    print("toooot");
    if (_state == DrawerState.open) {
      close();
    } else if (_state == DrawerState.closed) {
      open();
    }
  }

  bool isOpen() =>
      _state == DrawerState.open /*|| _state == DrawerState.opening*/;

  /// Drawer state
  ValueNotifier<DrawerState>? stateNotifier;

  @override
  void initState() {
    super.initState();

    stateNotifier = ValueNotifier(_state);

    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            _state = DrawerState.opening;
            _updateStatusNotifier();
            break;
          case AnimationStatus.reverse:
            _state = DrawerState.closing;
            _updateStatusNotifier();
            break;
          case AnimationStatus.completed:
            _state = DrawerState.open;
            _updateStatusNotifier();
            break;
          case AnimationStatus.dismissed:
            _state = DrawerState.closed;
            _updateStatusNotifier();
            break;
        }
      });

    /// assign controller function to the widget methods
    controller = CustomDrawerController(open, close, toggle, isOpen());
    /*if (widget.controller != null) {
      print("init toggle");
      
      widget.controller.open = open();
      widget.controller.close = close();
      widget.controller.toggle = toggle();
      // widget.controller.setToggle(toggle, 2);
      widget.controller.isOpen = isOpen();
      widget.controller.stateNotifier = stateNotifier;
    }*/
  }

  _updateStatusNotifier() {
    stateNotifier!.value = _state;
    print(_state);
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  Widget _zoomAndSlideContent(Widget container, BuildContext context,
      {double? angle, double? scale, double slide = 0}) {
    var slidePercent, scalePercent;

    /// determine current slide percent based on the MenuStatus
    switch (_state) {
      case DrawerState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case DrawerState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case DrawerState.opening:
        slidePercent =
            (widget.openCurve ?? _slideOutCurve).transform(_percentOpen);
        scalePercent = _scaleDownCurve.transform(_percentOpen);
        break;
      case DrawerState.closing:
        slidePercent =
            (widget.closeCurve ?? _slideInCurve).transform(_percentOpen);
        scalePercent = _scaleUpCurve.transform(_percentOpen);
        break;
    }

    final int _rtlSlide = CustomDrawer.isRTL(context) ? -1 : 1;

    final slideAmount = (widget.slideWidth - slide) * slidePercent * _rtlSlide;
    final contentScale = (scale ?? 1.0) - (0.4 * scalePercent);
    final cornerRadius = widget.borderRadius * _percentOpen;
    final rotationAngle =
        (((angle ?? widget.angle) * pi * _rtlSlide) / 180) * _percentOpen;

    return Transform(
      transform: Matrix4.translationValues(slideAmount, 0, 0)
        ..rotateZ(rotationAngle)
        ..scale(contentScale, contentScale),
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius),
        child: container,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final slidePercent = CustomDrawer.isRTL(context)
        ? MediaQuery.of(context).size.width * .1
        : 15.0;

    return Stack(
      children: [
        GestureDetector(
          child: slSettingsPage(controller), //widget.menuScreen,
          onPanUpdate: (details) {
            final bool _rtl = CustomDrawer.isRTL(context);
            if (details.delta.dx < -6 && !_rtl ||
                details.delta.dx < 6 && _rtl) {
              //print("asdasdasd");
              toggle();
            }
          },
        ),
        if (widget.showShadow) ...[
          /// Displaying the first shadow
          AnimatedBuilder(
            animation: _animationController!,
            builder: (_, w) => _zoomAndSlideContent(w!, context,
                angle: (widget.angle == 0.0) ? 0.0 : widget.angle - 8,
                scale: .9,
                slide: slidePercent * 2),
            child: Container(
              color: widget.backgroundColor.withAlpha(31),
            ),
          ),

          /// Displaying the second shadow
          AnimatedBuilder(
            animation: _animationController!,
            builder: (_, w) => _zoomAndSlideContent(w!, context,
                angle: (widget.angle == 0.0) ? 0.0 : widget.angle - 4.0,
                scale: .95,
                slide: slidePercent),
            child: Container(
              color: widget.backgroundColor,
            ),
          )
        ],

        /// Displaying the main screen
        AnimatedBuilder(
            animation: _animationController!,
            builder: (_, w) => _zoomAndSlideContent(w!, context),
            child: slMainPage(controller) //widget.mainScreen,
            ),
      ],
    );
  }
}

/// Drawer State enum
enum DrawerState { opening, closing, open, closed }
