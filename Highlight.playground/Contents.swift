import Highlight
import UIKit
import XCPlayground

// Prepare views
let label = UILabel(frame: CGRectMake(0,0,300,100))
XCPlaygroundPage.currentPage.liveView = label
label.backgroundColor = UIColor.whiteColor()
label.textColor       = UIColor.blackColor()
label.textAlignment   = .Center

let highlight = Highlight(string: "@boy Good morning. @girl Good night.")
let text = NSMutableAttributedString()

// Highlight mentions
for w in highlight.extract(tagPattern: "@[a-zA-Z_-]*?\\s") {
    switch w {
    case .Normal(let word):
        let str = NSAttributedString(string: word, attributes: [
            NSFontAttributeName            : UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName : UIColor.darkTextColor(),
        ])
        text.appendAttributedString(str)
        break
    case .Highlighted(let word):
        let str = NSAttributedString(string: word, attributes: [
            NSFontAttributeName            : UIFont.systemFontOfSize(16),
            NSForegroundColorAttributeName : UIColor.magentaColor(),
            ])
        text.appendAttributedString(str)
        break
    }
}
label.attributedText = text