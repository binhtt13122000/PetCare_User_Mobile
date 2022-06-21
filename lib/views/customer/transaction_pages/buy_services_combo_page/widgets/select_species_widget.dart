import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/configs/theme.dart';
import 'package:petapp_mobile/controllers/transaction_page_controllers/buy_services_combo_page_controller.dart';
import 'package:petapp_mobile/models/species_model/species_model.dart';
import 'package:petapp_mobile/views/widgets/customize_widget.dart';

class BuyServicesComboSelectSpeciesWidget
    extends GetView<BuyServicesComboPageController> {
  const BuyServicesComboSelectSpeciesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Visibility(
        visible: controller.isShowPetFilter.value,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(left: 40),
                  child: CUSTOM_TEXT(
                    'Pet species',
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.italic,
                  )),
            ),
            Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 40, top: 10),
                  child: Wrap(
                    alignment: WrapAlignment.start,
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    verticalDirection: VerticalDirection.down,
                    spacing: 10,
                    runSpacing: 10,
                    children: controller.speciesModelList
                        .asMap()
                        .entries
                        .map((e) => speciesItemWidget(speciesModel: e.value))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget speciesItemWidget({required SpeciesModel speciesModel}) => Container(
        width: 55 + speciesModel.name.length * 10,
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            controller
              ..selectedSpeciesId.value = speciesModel.id
              ..isLoadingPet = true
              ..update();
          },
          child: Container(
            height: 40,
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: controller.selectedSpeciesId.value == speciesModel.id
                  ? PRIMARY_COLOR
                  : PRIMARY_COLOR.withOpacity(0.13),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: controller.selectedSpeciesId.value == speciesModel.id
                      ? PRIMARY_COLOR.withOpacity(0.7)
                      : WHITE_COLOR,
                  offset: const Offset(1, 1),
                  blurRadius: 8,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                speciesModel.imageUrl != null
                    ? Image.asset(
                        speciesModel.imageUrl!,
                        height: 25,
                      )
                    : const SizedBox.shrink(),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  speciesModel.name,
                  style: GoogleFonts.itim(
                    color: speciesModel.id == controller.selectedSpeciesId.value
                        ? WHITE_COLOR
                        : PRIMARY_COLOR.withOpacity(0.7),
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
