import 'package:flip_board/flip_widget.dart';
import 'package:flip_panel_plus/flip_panel_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/pomodoro_value_provider.dart';
import '../providers/timer_provider.dart';

enum DigitPosition { first, second, third, fourth }


class FlipPanelWithCondition extends StatefulWidget {
  final Stream<Duration> itemStream;
  final DigitPosition digitPosition;

  const FlipPanelWithCondition(
      {required this.itemStream, Key? key, required this.digitPosition})
      : super(key: key);

  @override
  _FlipPanelWithConditionState createState() => _FlipPanelWithConditionState();
}

class _FlipPanelWithConditionState extends State<FlipPanelWithCondition> {
  Duration? previousValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.itemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final currentValue = snapshot.data!;
        var shouldFlip = false;
        if (widget.digitPosition == DigitPosition.third) {
          shouldFlip = previousValue == null ||
              (previousValue!.inSeconds ~/ 10) !=
                  (currentValue.inSeconds ~/ 10);
        } else if (widget.digitPosition == DigitPosition.fourth) {
          shouldFlip = previousValue == null ||
              (previousValue!.inSeconds.remainder(10)) !=
                  (currentValue.inSeconds.remainder(10));
        } else {
          shouldFlip = previousValue == null ||
              (previousValue!.inSeconds % 10) != (currentValue.inSeconds % 10);
        }

        if (shouldFlip) {
          previousValue = currentValue;
        }

        return shouldFlip
            ? FlipPanelPlus<Duration>.stream(
          initValue: Duration.zero,
          itemStream: widget.itemStream,
          itemBuilder: (context, value) => Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              widget.digitPosition == DigitPosition.third
                  ? (value.inSeconds % 10).toString()
                  : widget.digitPosition == DigitPosition.fourth
                  ? value.inSeconds.remainder(10).toString() : (value.inSeconds ~/ 10).toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Colors.white),
            ),
          ),
        )
            : Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            widget.digitPosition == DigitPosition.third
                ? (currentValue.inSeconds % 10).toString()
                : widget.digitPosition == DigitPosition.fourth
                ? currentValue.inSeconds.remainder(10).toString() : (currentValue.inSeconds ~/ 10).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                color: Colors.white),
          ),
        );
      },
    );
  }
}


class FlipPanelLastSecondDigit extends ConsumerStatefulWidget {
  final Stream<Duration> itemStream;

  FlipPanelLastSecondDigit({Key? key, required this.itemStream}) : super(key: key);


  @override
  _FlipPanelLastSecondDigitState createState() => _FlipPanelLastSecondDigitState();
}

class _FlipPanelLastSecondDigitState extends ConsumerState<FlipPanelLastSecondDigit> {
  Duration? previousValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.itemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final currentValue = snapshot.data!;
        var shouldFlip = false;
        shouldFlip = previousValue == null ||
            (previousValue!.inSeconds.remainder(10)) !=
                (currentValue.inSeconds.remainder(10));

        if (shouldFlip) {
          previousValue = currentValue;
        }

        return shouldFlip
            ? FlipPanelPlus<Duration>.stream(
          initValue: Duration.zero,
          itemStream: widget.itemStream,
          itemBuilder: (context, value) => Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              (value.inSeconds.remainder(10)).toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Colors.white),
            ),
          ),
        )
            : Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            (currentValue.inSeconds.remainder(10)).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                color: Colors.white),
          ),
        );
      },
    );
  }
}


class FlipPanelFirstSecondDigit extends ConsumerStatefulWidget {
  final Stream<Duration> itemStream;

  FlipPanelFirstSecondDigit({Key? key, required this.itemStream}) : super(key: key);


  @override
  _FlipPanelFirstSecondDigitState createState() => _FlipPanelFirstSecondDigitState();
}

class _FlipPanelFirstSecondDigitState extends ConsumerState<FlipPanelFirstSecondDigit> {
  Duration? previousValue;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: widget.itemStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        }

        final currentValue = snapshot.data!;
        var shouldFlip = false;
        shouldFlip = previousValue == null ||
            (previousValue!.inSeconds ~/ 10) !=
                (currentValue.inSeconds ~/ 10);

        if (shouldFlip) {
          previousValue = currentValue;
        }

        return shouldFlip
            ? FlipPanelPlus<Duration>.stream(
          initValue: Duration.zero,
          itemStream: widget.itemStream,
          itemBuilder: (context, value) => Container(
            color: Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Text(
              (value.inSeconds ~/ 10).toString(),
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50.0,
                  color: Colors.white),
            ),
          ),
        )
            : Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            (currentValue.inSeconds ~/ 10).toString(),
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 50.0,
                color: Colors.white),
          ),
        );
      },
    );
  }
}