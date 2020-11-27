class PopularFilterListData {
  PopularFilterListData({
    this.titleTxt = '',
    this.isSelected = false,
  });

  String titleTxt;
  bool isSelected;

  static List<PopularFilterListData> starFList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: '1',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '2',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '3',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '4',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '5',
      isSelected: false,
    ),
  ];

  static List<PopularFilterListData> accomodationList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Alberghi',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Ristoranti',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Attrazioni',
      isSelected: false,
    ),

  ];

  static List<PopularFilterListData> priceList = <PopularFilterListData>[
    PopularFilterListData(
      titleTxt: 'Economico',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Fascia Media',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: 'Raffinato',
      isSelected: false,
    ),

  ];

  static List<PopularFilterListData> starList = [
    PopularFilterListData(
      titleTxt: '1',
      isSelected: false,

    ),
    PopularFilterListData(
      titleTxt: '2',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '3',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '4',
      isSelected: false,
    ),
    PopularFilterListData(
      titleTxt: '5',
      isSelected: false,
    ),
  ];


}
