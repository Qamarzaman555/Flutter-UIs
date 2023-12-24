import 'package:flutter/material.dart';
import 'package:practice/ui_kit/local_pub.dart';

import 'package:stacked/stacked.dart';

import 'main_page_vm.dart';

class MainPageVU extends StackedView<MainPageVM> {
  const MainPageVU({super.key});

  @override
  Widget builder(BuildContext context, MainPageVM viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dashBoardCard(),
              20.spaceY,
              _headText('Find the best'),
              _headText('Coffee in the Town!'),
              searchField(),
              optionList(context, viewModel),
              Expanded(
                child: optionCards(viewModel),
              ),
              _normalBoldText('Special for you'),
              specialCard(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget specialCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Card(
        color: Colors.grey.shade800,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.black38,
                child: SizedBox(
                    height: MediaQuery.sizeOf(context).height / 8,
                    width: MediaQuery.sizeOf(context).width / 4,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child:
                          Image(image: AssetImage('assets/brands/Red Eye.png')),
                    )),
              ),
              8.spaceX,
              const Text('5 Coffee Beans You Must Try!',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _normalBoldText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 32),
      child: Text(
        text,
        style: CHIStyles.mdBoldStyle.copyWith(color: CHIStyles.whiteColor),
      ),
    );
  }

  Widget optionCards(MainPageVM viewModel) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: viewModel.coffeeList.length,
            itemBuilder: (context, index) {
              return coffeeCard(viewModel, index, context);
            },
          ),
        )
      ],
    );
  }

  Widget coffeeCard(MainPageVM viewModel, int index, BuildContext context) {
    return Card(
      color: Colors.grey.shade800,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ratingCard(viewModel, index),
                coffeeImageCard(context, viewModel, index),
              ],
            ),
            12.spaceY,
            Text(viewModel.coffeeList[index].name,
                style: CHIStyles.mdNormalStyle
                    .copyWith(color: CHIStyles.whiteColor)),
            Text(
              viewModel.coffeeList[index].detail,
              style:
                  CHIStyles.xsNormalStyle.copyWith(color: CHIStyles.whiteColor),
            ),
            12.spaceY,
            coffeePrice(viewModel, index)
          ],
        ),
      ),
    );
  }

  Widget coffeePrice(MainPageVM viewModel, int index) {
    return Row(
      children: [
        const Icon(
          Icons.attach_money,
          color: Colors.amber,
          size: 18,
        ),
        Text(
          viewModel.coffeeList[index].price.toString(),
          style: CHIStyles.mdBoldStyle.copyWith(color: CHIStyles.whiteColor),
        ),
      ],
    );
  }

  Widget coffeeImageCard(
      BuildContext context, MainPageVM viewModel, int index) {
    return Card(
      color: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height / 7,
          width: MediaQuery.sizeOf(context).width / 4,
          child: Image(image: viewModel.coffeeList[index].assetImage),
        ),
      ),
    );
  }

  Widget ratingCard(MainPageVM viewModel, int index) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          children: [
            const Icon(
              Icons.star_rate,
              color: Colors.amber,
              size: 16,
            ),
            Text(
              viewModel.coffeeList[index].rating.toString(),
              style:
                  CHIStyles.smBoldStyle.copyWith(color: CHIStyles.whiteColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget optionList(BuildContext context, MainPageVM viewModel) {
    return SizedBox(
      height: 40,
      width: MediaQuery.sizeOf(context).width,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: viewModel.textList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: GestureDetector(
                    onTap: () {
                      viewModel.onSelectCard(index);
                    },
                    child: Text(
                      viewModel.textList[index].name,
                      style: TextStyle(
                          color: !viewModel.textList[index].isSelectedText
                              ? Colors.grey.shade800
                              : Colors.amber,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  Widget searchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: TextFormField(
        style: const TextStyle(
            color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          // prefixIconConstraints:
          //     BoxConstraints.tight(const Size(80, 20)),
          prefixIcon: const Icon(
            Icons.coffee,
            color: Colors.white60,
            size: 20,
          ),
          hintText: 'Find Your Coffee',
          hintStyle: const TextStyle(
              color: Colors.white60, fontSize: 12, fontStyle: FontStyle.italic),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          fillColor: Colors.grey.shade800,
          filled: true,
          border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.transparent),
              borderRadius: BorderRadius.circular(10)),
        ),
      ),
    );
  }

  Widget _headText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    );
  }

  Widget dashBoardCard() {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white30,
      child: const Padding(
        padding: EdgeInsets.all(6),
        child: Icon(
          Icons.dashboard,
          color: Colors.white60,
        ),
      ),
    );
  }

  @override
  MainPageVM viewModelBuilder(BuildContext context) {
    return MainPageVM();
  }
}
