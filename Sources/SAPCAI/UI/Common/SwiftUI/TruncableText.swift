import SwiftUI

struct TruncableText: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @State private var intrinsicSize: CGSize = .zero
    @State private var truncatedSize: CGSize = .zero
    @State private var isTruncated: Bool = false
    @State private var forceFullText: Bool = false
    
    let text: Text
    let lineLimit: Int?
    
    var body: some View {
        VStack(alignment: .leading) {
            text
                .lineLimit(forceFullText ? nil : lineLimit)
                .truncationMode(.tail)
                .multilineTextAlignment(.leading)
                .font(.body)
                .fixedSize(horizontal: false, vertical: true)
                .readSize { size in
                    truncatedSize = size
                    isTruncated = truncatedSize != intrinsicSize
                }
                .background(
                    text
                        .fixedSize(horizontal: false, vertical: true)
                        .readSize { size in
                            intrinsicSize = size
                            isTruncated = truncatedSize != intrinsicSize
                        }
                        .hidden()
                )
            
                .foregroundColor(themeManager.color(for: .incomingTextColor))
            if isTruncated && !forceFullText {
                Button(Bundle.cai.localizedString(forKey: "View more", value: "View more", table: nil)) {
                    forceFullText = true
                }
            }
        }
        .padding(themeManager.value(for: .incomingTextContainerInset,
                                    type: EdgeInsets.self,
                                    defaultValue: .all10))
        .background(roundedBackground(for: themeManager.theme, key: .incomingBubbleColor))
        .tail(self.themeManager, reversed: true)
    }
}

struct TruncableLabel: View {
    @State private var isTruncated: Bool = false
    @State private var forceFullText: Bool = false
    
    let value: NSAttributedString
    let width: CGFloat
    let lineLimit: Int?
    
    let labelSize = SizeContainer()
    
    var body: some View {
        VStack(alignment: .leading) {
            UIKLabel(value: value, width: width, lineLimit: forceFullText ? 0 : lineLimit ?? 0) { self.labelSize.value = $0 }
                .onAppear {
                    let rect = value.boundingRect(with: CGSize(width: width, height: .infinity), options: .usesLineFragmentOrigin, context: nil)
                    if rect.size.height > self.labelSize.value.height {
                        isTruncated = true
                    }
                }
            
            if isTruncated && !forceFullText {
                Button(Bundle.cai.localizedString(forKey: "View more", value: "View more", table: nil)) {
                    forceFullText = true
                }
            }
        }
    }
    
    class SizeContainer {
        var value: CGSize
        init() {
            self.value = .zero
        }
    }
}

struct UIKLabel: UIViewRepresentable {
    typealias TheUIView = UILabel
    
    let value: NSAttributedString
    let width: CGFloat
    let lineLimit: Int?
    let sizeUpdatedClosure: (CGSize) -> Void
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> TheUIView {
        let label = UILabel()
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return label
    }
    
    func updateUIView(_ uiView: TheUIView, context: UIViewRepresentableContext<Self>) {
        uiView.attributedText = self.value
        uiView.lineBreakMode = .byTruncatingTail
        uiView.numberOfLines = self.lineLimit ?? 0
        uiView.preferredMaxLayoutWidth = self.width
        self.sizeUpdatedClosure(uiView.intrinsicContentSize)
    }
}
