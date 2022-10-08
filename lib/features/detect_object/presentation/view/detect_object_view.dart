import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/extensions/context_extensions.dart';
import '../../../../locator.dart';
import '../../logic/detect_object_bloc.dart';
import '../widgets/cards/input_method_card.dart';
import '../widgets/containers/default_container.dart';
import '../widgets/image/selected_image.dart';
import '../widgets/indicators/custom_linear_percentage_indicator.dart';

class DetectObjectView extends StatelessWidget {
  const DetectObjectView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Strings.appName),
      ),
      body: BlocProvider(
        create: (_) => getIt<DetectObjectBloc>(),
        child: const _DetectObjectViewBody(),
      ),
    );
  }
}

class _DetectObjectViewBody extends StatelessWidget {
  const _DetectObjectViewBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllDefault,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: DefaultContainer(
              child: BlocBuilder<DetectObjectBloc, DetectObjectState>(
                builder: (context, state) {
                  return state.map(
                    initial: (state) => const Center(
                      child: Text("Please select an image"),
                    ),
                    detectionSuccessful: (state) => Column(
                      children: [
                        Expanded(
                          flex: 7,
                          child: SelectedImage(
                            image: File(state.image?.path ?? ""),
                          ),
                        ),
                        SizedBox(
                          height: context.mediumValue,
                        ),
                        Expanded(
                          flex: 3,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(
                              height: context.mediumValue,
                            ),
                            itemCount: state.predictions.length,
                            itemBuilder: (context, index) {
                              return CustomLinearPercentageIndicator(
                                prediction: state.predictions[index],
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                    detectionUnsuccessful: (state) => const Center(
                      child: Text(
                        "Confidence level too low please use another photo of the object",
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(
            height: context.mediumValue,
          ),
          Expanded(
            child: InputMethodCard(
              onTap: () => context.read<DetectObjectBloc>().add(const TakePhotoPressed()),
              imagePath: Assets.cameraIcon,
              cardText: "Take a Photo",
            ),
          ),
          SizedBox(
            height: context.mediumValue,
          ),
          Expanded(
            child: InputMethodCard(
              onTap: () => context.read<DetectObjectBloc>().add(const SelectFromGalleryPressed()),
              imagePath: Assets.galleryIcon,
              cardText: "Select from Gallery",
            ),
          ),
        ],
      ),
    );
  }
}
