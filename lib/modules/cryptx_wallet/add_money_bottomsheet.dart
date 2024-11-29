import 'dart:math';

import 'package:crypto_app/network_services/initializer.dart';
import 'package:crypto_app/utills/app_colors.dart';
import 'package:crypto_app/utills/dprint.dart';
import 'package:crypto_app/utills/widget_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reown_appkit/appkit_modal.dart';
import 'package:reown_appkit/modal/i_appkit_modal_impl.dart';

class AddMoneyBottomSheet extends StatefulWidget {
  final VoidCallback onTap;
  final VoidCallback onTapCrypto;
  final IReownAppKitModal appKitModal;
  final TextEditingController amountController;
  final bool loading;

  const AddMoneyBottomSheet({
    super.key,
    required this.onTap,
    required this.onTapCrypto,
    required this.appKitModal,
    required this.amountController,
    required this.loading
  });

  @override
  State<AddMoneyBottomSheet> createState() => _AddMoneyBottomSheetState();
}

class _AddMoneyBottomSheetState extends State<AddMoneyBottomSheet> {

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container (
      padding: EdgeInsets.all(w * 0.05),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(w * 0.05)),
      ),
      child: widget.loading  ?
      const CircularProgressIndicator() :
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Deposit Money',
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
              fontFamily: 'madaSemiBold'
            ),
          ),
          SizedBox(height: h * 0.02),
          widget.appKitModal.isConnected ?
          AppKitModalAccountButton(appKitModal: widget.appKitModal,custom: detailWidget(h, w, widget.appKitModal),) :
          const SizedBox.shrink(),
          SizedBox(height: h * 0.02),
          TextField(
            controller: widget.amountController,
            keyboardType: TextInputType.number,
            style: TextStyle(
                fontSize: w * 0.05,
                fontWeight: FontWeight.bold,
                fontFamily: 'madaSemiBold'
            ),
            readOnly: false,
            decoration: InputDecoration(
              labelText: 'Amount',
              labelStyle: TextStyle(
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'madaSemiBold'
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(w * 0.03)
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: w * 0.06, vertical: h * 0.01 )
            ),
          ),
          SizedBox(height: h * 0.05),
          ElevatedButton(
            onPressed: () {
              // Handle the add money logic
              String amount = widget.amountController.text;
              if (amount.isNotEmpty) {
                // Process the amount
                Get.back(); // Close the bottom sheet
                widget.onTap();
              } else {
                Get.snackbar('Error', 'Please enter an amount');
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.03),
                ),
              minimumSize: Size(w / 1, h * 0.06)
            ),
            child: Text('ADD MONEY',
            style: TextStyle(
              color: AppColors.white10,
                fontSize: w * 0.045,
                fontWeight: FontWeight.bold,
                fontFamily: 'madaSemiBold'
            ),),
          ),
          SizedBox(height: h * 0.01),
          /*ElevatedButton(
            onPressed: () {
              Get.back(); // Close the bottom sheet
              widget.onTapCrypto();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(w / 1, h * 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * 0.03),
                side: const BorderSide(
                  color: AppColors.primary, width: 1
                )
              )
            ),
            child: Row(
             // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network("https://cdn.iconscout.com/icon/free/png-256/free-metamask-logo-icon-download-in-svg-png-gif-file-formats--technology-brand-social-media-company-logos-pack-icons-6297246.png?f=webp&w=128", width: w * 0.1,),
                SizedBox(width: w * 0.12,),
                Text('CONNECT METAMASK',
                  style: TextStyle(
                      color: AppColors.white10,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),*/
          AppKitModalConnectButton(appKit: widget.appKitModal,
          custom: ElevatedButton(
            onPressed: () {
              Get.back(); // Close the bottom sheet
              widget.onTapCrypto();
            },
            style: ElevatedButton.styleFrom(
                minimumSize: Size(w / 1, h * 0.06),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(w * 0.03),
                    side: const BorderSide(
                        color: AppColors.primary, width: 1
                    )
                )
            ),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Image.network("https://cdn.iconscout.com/icon/free/png-256/free-metamask-logo-icon-download-in-svg-png-gif-file-formats--technology-brand-social-media-company-logos-pack-icons-6297246.png?f=webp&w=128", width: w * 0.1,),
                SizedBox(width: widget.appKitModal.isConnected ? w * 0.18 : w * 0.12,),
                Text(widget.appKitModal.isConnected ? 'DISCONNECT' :'CONNECT METAMASK',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppColors.white10,
                      fontSize: w * 0.045,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'madaSemiBold'
                  ),),
              ],
            ),
          ),),
        ],
      ),
    );
  }
  Widget detailWidget(var h, var w, IReownAppKitModal model){
    return GestureDetector(
      onTap: () {
        model.openModalView();
      },
      child: Container(
        height: h * 0.12,
        width: w,
        margin: EdgeInsets.only(bottom: h * 0.03),
        padding: EdgeInsets.symmetric(horizontal: w * 0.02, vertical: h * 0.01),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(w * 0.03),
          border: Border.all(color: AppColors.white90)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Crypto Balance:  ".toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.034
                  ),),
                Text(model.balanceNotifier.value,
                style: TextStyle(
                  fontFamily: 'madaSemiBold',
                  fontSize: w * 0.035
                ),),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Wallet:  ".toUpperCase(),
                  style: TextStyle(
                      fontFamily: 'madaRegular',
                      fontSize: w * 0.035
                  ),),
                Text('${model.session!.connectedWalletName}',
                  style: TextStyle(
                      fontFamily: 'madaSemiBold',
                      fontSize: w * 0.035
                  ),),
              ],
            ),
            SizedBox(height: h * 0.02,),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                    model.openModalView(const ReownAppKitModalSelectNetworkPage());
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h *0.002),
                    decoration: BoxDecoration(
                      color: AppColors.success60,
                      borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('Change Network',
                    style: TextStyle(
                      color: AppColors.white10,
                      fontSize: w * 0.032,
                      fontFamily: 'madaSemibold'
                    ),),
                  ),
                ),
                SizedBox(width: w * 0.02,),
                GestureDetector(
                  onTap: (){
                    WidgetUtils.copyToClipboard(context, formatWalletAddress(model.session!.namespaces?["eip155"]?.accounts.first.split(':').last ?? ""));
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h *0.002),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('Address : ${formatWalletAddress(model.session!.namespaces?["eip155"]?.accounts.first.split(':').last ?? "")}',
                      style: TextStyle(
                          color: AppColors.white10,
                          fontSize: w * 0.032,
                          fontFamily: 'madaSemibold'
                      ),),
                  ),
                ),
                SizedBox(width: w * 0.02,),
               /* GestureDetector(
                  onTap: (){
                    debugPrint('${model.getApprovedEvents()?.length}');
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h *0.002),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(w * 0.01)
                    ),
                    child: Text('Approved : ${model.getApprovedEvents()?.length}',
                      style: TextStyle(
                          color: AppColors.white10,
                          fontSize: w * 0.032,
                          fontFamily: 'madaSemibold'
                      ),),
                  ),
                ),*/
              ],
            )
          ],
        ),
      ),
    );
  }

   String formatWalletAddress(String address, {int start = 6, int end = 4}) {
     if (address.length <= start + end) return address;
     return '${address.substring(0, start)}...${address.substring(address.length - end)}';
   }
}