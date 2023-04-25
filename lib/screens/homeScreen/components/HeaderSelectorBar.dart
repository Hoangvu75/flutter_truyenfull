import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_scale_tap/flutter_scale_tap.dart';
import 'package:flutter_truyenfull/generated/PColors.dart';

import '../../../generated/Dimensions.dart';
import '../bloc/headerSelector/HeaderSelectorBloc.dart';
import '../bloc/headerSelector/HeaderSelectorEvent.dart';
import '../bloc/headerSelector/HeaderSelectorState.dart';

class HeaderSelectorBar extends StatelessWidget {
  const HeaderSelectorBar({
    super.key,
  });
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: BlocBuilder<HeaderSelectorBloc, HeaderSelectorState>(
        builder: (context, categorySelectorState) {
          return Row(
            children: [
              HeaderSelector(
                title: 'Cập nhật',
                position: 0,
                categorySelectorState: categorySelectorState,
              ),
              HeaderSelector(
                title: 'Danh mục',
                position: 1,
                categorySelectorState: categorySelectorState,
              ),
              HeaderSelector(
                title: 'Đã full',
                position: 2,
                categorySelectorState: categorySelectorState,
              ),
              HeaderSelector(
                title: 'Sáng tác',
                position: 3,
                categorySelectorState: categorySelectorState,
              ),
              HeaderSelector(
                title: 'Của bạn',
                position: 4,
                categorySelectorState: categorySelectorState,
              ),
            ],
          );
        }
      ),
    );
  }
}

class HeaderSelector extends StatelessWidget {
  const HeaderSelector({
    super.key,
    required this.title,
    required this.position,
    required this.categorySelectorState,
  });

  final String title;
  final int position;
  final HeaderSelectorState categorySelectorState;

  @override
  Widget build(BuildContext context) {
    return ScaleTap(
      onPressed: () {
        context.read<HeaderSelectorBloc>().add(ChangeHeaderSelectorPosition(position: position));
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 15.0 * Dimensions.responsiveSize.width,
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 15.0 * Dimensions.responsiveSize.width,
                vertical: 15.0 * Dimensions.responsiveSize.height,
              ),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 20.0 * Dimensions.responsiveSize.width,
                  fontWeight: FontWeight.w500,
                  color: PColors.primary,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: categorySelectorState.position == position ? PColors.primary : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              height: 4.0 * Dimensions.responsiveSize.height,
              width: 100.0 * Dimensions.responsiveSize.width,
            )
          ],
        ),
      ),
    );
  }
}