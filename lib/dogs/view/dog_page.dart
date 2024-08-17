import 'package:cached_network_image/cached_network_image.dart';
import 'package:dog_image_generator/dogs/dogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';

import '../../constants/constants.dart';

class DogPage extends StatefulWidget {
  const DogPage({super.key});

  @override
  State<DogPage> createState() => _DogPageState();
}

class _DogPageState extends State<DogPage> {
  late SingleValueDropDownController _dogTypeController;

  @override
  void initState() {
    _dogTypeController = SingleValueDropDownController(
        data: const DropDownValueModel(name: 'Pitbull', value: 'pitbull'));
    super.initState();
  }

  @override
  void dispose() {
    _dogTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dog Image Generator',
          style: TextStyleConstant.poppinsSemiBold,
        ),
        backgroundColor: ColorConstants.red,
        actions: [
          SvgPicture.asset(IconConstants.info),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 24,
          ),
          child: Column(
            children: [
              BlocBuilder<DogBloc, DogState>(
                builder: (context, state) {
                  switch (state.status) {
                    case DogStatus.initial:
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(IconConstants.dog, height: 100),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              "Let's generate dog image!",
                              style: TextStyleConstant.poppinsRegular.copyWith(
                                color: ColorConstants.red,
                              ),
                            )
                          ],
                        ),
                      );
                    case DogStatus.success:
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: state.image ?? "",
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.red,
                              ),
                            ),
                            errorWidget: (context, url, error) => Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.error,
                                  color: ColorConstants.red,
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(
                                  'Failed to load image',
                                  style:
                                      TextStyleConstant.poppinsRegular.copyWith(
                                    color: ColorConstants.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    case DogStatus.failure:
                      return Container(
                        width: double.infinity,
                        height: 300,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ColorConstants.red,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error,
                              color: ColorConstants.red,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Failed to fetch image',
                              style: TextStyleConstant.poppinsRegular.copyWith(
                                color: ColorConstants.red,
                              ),
                            )
                          ],
                        ),
                      );
                  }
                },
              ),
              const SizedBox(
                height: 24,
              ),
              DropDownTextField(
                controller: _dogTypeController,
                dropDownList: const [
                  DropDownValueModel(name: 'Pitbull', value: "pitbull"),
                  DropDownValueModel(name: 'Akita', value: "akita"),
                  DropDownValueModel(name: 'Shiba', value: "shiba"),
                  DropDownValueModel(name: 'Bulldog', value: "bulldog"),
                  DropDownValueModel(name: 'Chihuahua', value: "chihuahua"),
                ],
                textStyle: TextStyleConstant.poppinsRegular.copyWith(
                  color: ColorConstants.red,
                ),
                listTextStyle: TextStyleConstant.poppinsRegular.copyWith(
                  color: ColorConstants.red,
                ),
                dropDownIconProperty: IconProperty(color: ColorConstants.red),
                clearIconProperty: IconProperty(color: ColorConstants.red),
                textFieldDecoration: InputDecoration(
                  hintText: 'Select Dog Type',
                  hintStyle: TextStyleConstant.poppinsRegular.copyWith(
                    color: ColorConstants.red,
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: ColorConstants.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: ColorConstants.red,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                      width: 1,
                      color: ColorConstants.red,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_dogTypeController.dropDownValue != null) {
                    context.read<DogBloc>().add(
                          DogFetched(
                            _dogTypeController.dropDownValue!.value,
                          ),
                        );
                    _dogTypeController.clearDropDown();
                  } else {
                    const snackBar = SnackBar(
                      content: Text('Please select a dog type first'),
                      duration: Duration(seconds: 3),
                    );

                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstants.red,
                ),
                child: Text(
                  'Generate',
                  style: TextStyleConstant.poppinsRegular,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
