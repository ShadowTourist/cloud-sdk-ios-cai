import SwiftUI

struct BotTextView: View {
    @EnvironmentObject private var themeManager: ThemeManager
    @Environment(\.horizontalSizeClass) private var hSizeClass
    
    let value: NSAttributedString
    let isMarkdown: Bool
    let geometry: GeometryProxy
    
    private var markdownSize: CGSize {
        let fixedWidth: CGFloat = self.hSizeClass == .regular ? min(480, self.geometry.size.width) : self.geometry.size.width * 0.8
        let tv = UITextView()
        tv.attributedText = self.value
        let newSize = tv.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        return newSize
    }
    
    private var markdownWidth: CGFloat {
        let fixedWidth: CGFloat = self.hSizeClass == .regular ? min(480, self.geometry.size.width) : self.geometry.size.width * 0.8
        return fixedWidth
    }
    
    private var avatarUrl: String? {
        self.themeManager.value(for: .avatarUrl) as? String
    }
    
    private var lineLimit: Int {
        if self.hSizeClass == .compact {
            return 8
        } else {
            return 6
        }
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            if avatarUrl != nil {
                AvatarView(imageUrl: avatarUrl!)
            }
            if isMarkdown {
                TruncableLabel(value: value, width: markdownWidth, lineLimit: lineLimit)
                    .background(roundedBackground(for: themeManager.theme, key: .incomingBubbleColor))
                    .tail(self.themeManager, reversed: true)
            } else {
                VStack(alignment: .leading) {
                    TruncableText(text: Text(value.string), lineLimit: lineLimit)
                }
            }
        }
    }
}

#if DEBUG
    struct BotTextView_Previews: PreviewProvider {
        static var previews: some View {
            GeometryReader { geometry in
                BotTextView(value: NSAttributedString(string: "hello"), isMarkdown: false, geometry: geometry).environmentObject(ThemeManager.shared)
            }
        }
    }
#endif
