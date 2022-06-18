import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:petapp_mobile/controllers/post_page_controllers/update_sale_post_page_controller.dart';

class DescriptionWidget extends GetView<UpdateSalePostPageController> {
  const DescriptionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Desciption',
            style: GoogleFonts.quicksand(
              fontWeight: FontWeight.w500,
              color: const Color.fromARGB(255, 78, 98, 124),
              fontSize: 16,
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.symmetric(vertical: 5),
          //   child: HtmlEditor(
          //     controller: controller,
          //     htmlToolbarOptions: const HtmlToolbarOptions(
          //       defaultToolbarButtons: [
          //         FontButtons(),
          //         ColorButtons(),
          //         ListButtons(),
          //       ],
          //     ),
          //     htmlEditorOptions: const HtmlEditorOptions(
          //       hint: "Description about your pet...",
          //     ),
          //     otherOptions: const OtherOptions(
          //       height: 200,
          //     ),

          //   ),
          // ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 149, 169, 194),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(10)),
                  child: quill.QuillToolbar.basic(
                    controller: controller.quillController,
                    showAlignmentButtons: false,
                    showBackgroundColorButton: false,
                    showBoldButton: true,
                    showCameraButton: false,
                    showClearFormat: true,
                    showCodeBlock: false,
                    showColorButton: true,
                    showHeaderStyle: false,
                    showImageButton: false,
                    showIndent: false,
                    showInlineCode: false,
                    showItalicButton: true,
                    showLink: false,
                    showListBullets: true,
                    showListCheck: false,
                    showListNumbers: true,
                    showQuote: true,
                    showSmallButton: false,
                    showStrikeThrough: true,
                    showUnderLineButton: true,
                    showVideoButton: false,
                    multiRowsDisplay: false,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: quill.QuillEditor.basic(
                      controller: controller.quillController,
                      readOnly: false,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
