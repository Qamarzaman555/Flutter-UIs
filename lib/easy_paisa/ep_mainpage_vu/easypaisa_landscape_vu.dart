import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';
import 'package:practice/ui_kit/local_pub.dart';

import '../Models/easypaisa_model.dart';
import 'easypaisa_vm.dart';

class EasyPaisaLandscapeView extends StatelessWidget {
  const EasyPaisaLandscapeView(this.viewModel, {super.key});
  final EasyPaisaViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerContainer(context),
            easypaisaCardList(context, viewModel),
          ],
        ),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              16.spaceY,
              _headingText('More with easypaisa'),
              _gridPageVIew(context, viewModel),
              16.spaceY,
              _headingText('Get your easypaisa Debit Card'),
              12.spaceY,
              easypaisaDebitCards(context, viewModel),
              4.spaceY,
              _headingText('Promotions'),
            ],
          ),
        ),
      ],
    );
  }

  Widget headerContainer(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width / 2,
      height: MediaQuery.sizeOf(context).height / 2.5,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
            Color.fromARGB(255, 39, 149, 74),
            Color.fromRGBO(50, 189, 94, 1),
          ])),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: userDetailsCard(context),
      ),
    );
  }

  Widget userDetailsCard(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/icons/easypaisa_logo.png",
                  height: MediaQuery.sizeOf(context).height / 18,
                ),
                12.spaceY,
                Text(
                  "QAMAR ZAMAN",
                  style: CHIStyles.xsNormalStyle,
                ),
                4.spaceY,
                Text(
                  "03159392193",
                  style: CHIStyles.mdBoldStyle,
                ),
                4.spaceY,
                Text(
                  "Sign in to your easypaisa account",
                  style: CHIStyles.xsSemiBoldStyle,
                ),
              ],
            ),
            _signinBtn()
          ],
        ),
      ),
    );
  }

  Widget easypaisaCardList(BuildContext context, EasyPaisaViewModel viewModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height / 3.5,
        width: MediaQuery.sizeOf(context).width / 2.2,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.easypaisaCards.length,
            itemBuilder: (context, index) {
              return easypaisaCard(viewModel.easypaisaCards[index], context);
            }),
      ),
    );
  }

  Widget easypaisaCard(EasyPaisaCard easyPaisaCard, BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: MediaQuery.sizeOf(context).height / 16,
          right: MediaQuery.sizeOf(context).width / 34),
      child: SizedBox(
        width: MediaQuery.sizeOf(context).width / 7.6,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  easyPaisaCard.icon,
                  color: const Color.fromARGB(255, 39, 149, 74),
                  size: MediaQuery.sizeOf(context).height / 14,
                ),
                Text(
                  easyPaisaCard.name,
                  style: CHIStyles.xsSemiBoldStyle,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinBtn() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        minimumSize: const Size(100.0, 25.0),
        backgroundColor: const Color.fromARGB(255, 39, 149, 74),
      ),
      onPressed: () {},
      child: Text(
        'Sign In',
        style: CHIStyles.xsNormalStyle.copyWith(color: CHIStyles.whiteColor),
      ),
    );
  }

  Widget _gridPageVIew(BuildContext context, EasyPaisaViewModel viewModel) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 1.3,
      width: MediaQuery.sizeOf(context).width / 2.3,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: PageView(
                    controller: viewModel.pageController,
                    onPageChanged: (page) {
                      viewModel.selectedPage = page;
                      viewModel.notifyListeners();
                    },
                    children: [
                      moreGridView(viewModel.gridView1, context),
                      moreGridView(viewModel.gridView2, context),
                    ],
                  ),
                ),
                Expanded(
                  child: _pageIndicator(viewModel),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _pageIndicator(EasyPaisaViewModel viewModel) {
    return PageViewDotIndicator(
      currentItem: viewModel.selectedPage,
      count: 2,
      unselectedColor: Colors.black26,
      selectedColor: Colors.green,
      duration: const Duration(milliseconds: 200),
      boxShape: BoxShape.circle,
      size: const Size(8, 8),
      onItemClicked: (index) {
        viewModel.pageController?.animateToPage(
          viewModel.selectedPage,
          duration: const Duration(milliseconds: 200),
          curve: Curves.bounceIn,
        );
        viewModel.notifyListeners();
      },
    );
  }

  GridView moreGridView(List<EasyPaisaCard> gridView, BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 4,
      children: List.generate(
        gridView.length,
        (index) {
          return easypaisaGridCell(gridView[index], context);
        },
      ),
    );
  }

  Widget easypaisaGridCell(EasyPaisaCard gridView, BuildContext context) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          gridView.icon,
          color: const Color.fromARGB(255, 39, 149, 74),
        ),
        const SizedBox(height: 12),
        Text(
          gridView.name,
          style: CHIStyles.xsSemiBoldStyle,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget _headingText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Text(
        text,
        style: CHIStyles.xsBoldStyle,
      ),
    );
  }

  Widget easypaisaDebitCards(
      BuildContext context, EasyPaisaViewModel viewModel) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height / 3,
      width: MediaQuery.sizeOf(context).width / 2.2,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: viewModel.debitCard.length,
        itemBuilder: (context, index) {
          return _debitCard(viewModel, index, context);
        },
      ),
    );
  }

  Widget _debitCard(
      EasyPaisaViewModel viewModel, int index, BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      color: viewModel.debitCard[index].color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              viewModel.debitCard[index].name,
              style: CHIStyles.xsSemiBoldStyle
                  .copyWith(color: CHIStyles.whiteColor),
              textAlign: TextAlign.center,
            ),
            // 4.spaceY,
            Expanded(
              child: Text(
                viewModel.debitCard[index].text,
                maxLines: 2,
                style: CHIStyles.xsSemiBoldStyle
                    .copyWith(color: CHIStyles.primaryWarningColor),
              ),
            ),
            _debitCardBtn(viewModel, index, context),
          ],
        ),
      ),
    );
  }

  Widget _debitCardBtn(
      EasyPaisaViewModel viewModel, int index, BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(
            side:
                BorderSide(color: Color.fromARGB(255, 41, 129, 44), width: 2)),
        minimumSize: const Size(100.0, 25.0),
        backgroundColor: viewModel.debitCard[index].color,
      ),
      onPressed: () {
        CHIRouter.push(context, viewModel.debitCard[index].toRoute);
      },
      child: Row(
        children: [
          Text(
            'Manage Card',
            style:
                CHIStyles.xsSemiBoldStyle.copyWith(color: CHIStyles.whiteColor),
          ),
          const SizedBox(width: 4),
          const Icon(
            Icons.arrow_forward,
            color: Colors.white,
            size: 12,
          )
        ],
      ),
    );
  }
}
