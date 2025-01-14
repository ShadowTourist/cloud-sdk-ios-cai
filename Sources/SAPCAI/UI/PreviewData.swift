// swiftlint:disable all
#if DEBUG
    import Foundation

    struct PreviewData {
        /// for ObjectMessageView
        static var objectMessage: [ObjectMessageData] {
            var arr = [ObjectMessageData]()
            let header = UIModelDataHeader(title: UIModelDataValue(value: "Image testing title with approx",
                                                                   dataType: "text",
                                                                   rawValue: nil,
                                                                   label: nil,
                                                                   valueState: nil),
                                           subtitle: UIModelDataValue(value: "List subtitle 1",
                                                                      dataType: "text",
                                                                      rawValue: nil,
                                                                      label: nil,
                                                                      valueState: nil),
                                           image: UIModelDataImage(imageUrl: "sap-icon://desktop-mobile"))
        
            let longSubtitleheader = UIModelDataHeader(title: UIModelDataValue(value: "Image testing title with approx",
                                                                               dataType: "text",
                                                                               rawValue: nil,
                                                                               label: nil,
                                                                               valueState: nil),
                                                       subtitle: UIModelDataValue(value: "Long description: Apple for years has focused on adding ne",
                                                                                  dataType: "text",
                                                                                  rawValue: nil,
                                                                                  label: nil,
                                                                                  valueState: nil),
                                                       image: UIModelDataImage(imageUrl: "sap-icon://desktop-mobile"))
            let shotButtonMessage = UIModelDataContent(header: header,
                                                       buttons: [UIModelDataAction("Link", "https://www.link.com", .link)])
            let longButtonMessage = UIModelDataContent(header: header,
                                                       buttons: [UIModelDataAction("Long Button AABBCC DD", "https://www.link.com", .link)])
            let longSubtitleButtonMessage = UIModelDataContent(header: longSubtitleheader,
                                                               buttons: [UIModelDataAction("Long Button AABBCC DD", "https://www.link.com", .link)])
            arr.append(contentsOf: [shotButtonMessage, longButtonMessage, longSubtitleButtonMessage])
            return arr
        }
    
        /// for QuickRepliesMessageView
        static var quickReply: MessagingViewModel {
            let viewModel = MessagingViewModel(publisher: MockPublisher())
            let text = "Apple for years has focused on adding new programs to its phones, all designed to make life"
            let iButtons = [UIModelDataAction("QC1", "QC1", .text),
                            UIModelDataAction("QC2", "QC2", .text),
                            UIModelDataAction("QC3", "QC3", .text),
                            UIModelDataAction("QC4withexac19char", "QC4withexac19char", .text),
                            UIModelDataAction("QC5withexac20chars", "QC5withexac20chars", .text),
                            UIModelDataAction("QC6withexac21chars1", "QC6withexac21chars1", .text),
                            UIModelDataAction("QC7withexac22chars12", "QC7withexac22chars12", .text),
                            UIModelDataAction("QC8", "QC8", .text),
                            UIModelDataAction("QC9", "QC9", .text),
                            UIModelDataAction("QC10", "QC10", .text),
                            UIModelDataAction("QC11", "QC11", .text)]
            let responseData = CAIResponseMessageData(text: text, iButtons, buttonType: .quickReplies)
            viewModel.addMessages(contentsOf: [responseData])
            return viewModel
        }

        static var cardSectionData: UIModelDataSection {
            func makeDataValue(label: String? = nil, value: String? = nil, dataType: String? = nil) -> UIModelDataValue {
                UIModelDataValue(value: value, dataType: dataType, rawValue: nil, label: label, valueState: nil)
            }
            return UIModelDataSection("title", [makeDataValue(label: "text",
                                                              value: "Just text",
                                                              dataType: "text"),
                                                makeDataValue(label: "link address",
                                                              value: "https://www.sap.com",
                                                              dataType: "link"),
                                                makeDataValue(label: "email address",
                                                              value: "example@sap.com",
                                                              dataType: "email"),
                                                makeDataValue(label: "tel",
                                                              value: "+1 23 388913 23 ",
                                                              dataType: "phonenumber"),
                                                makeDataValue(label: "real address",
                                                              value: "1234, CA, USA",
                                                              dataType: "address")])
        }
    }

#endif
// swiftlint:enable all
