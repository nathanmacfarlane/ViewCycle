import Foundation
import UIKit

public class ParentView: UIView {

    var children: [String: UIView] = [:]
    var current: String?
    var activeView: UIView!
    var keys: [String] { return Array(children.keys) }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.clipsToBounds = true
    }
    public func addChild(view: UIView, tag: String) {
        if keys.index(of: tag) != nil { return }
        children[tag] = view
    }
    public func switchToView(tag: String) {
        for view in self.subviews { view.removeFromSuperview() }
        current = tag
        guard let view = children[tag] else { return }
        activeView = view
        activeView.frame = self.bounds
        self.addSubview(activeView)
    }

    public func next() {
        guard let current = self.current, var index = self.keys.index(of: current) else { return }
        index = index + 1 == self.keys.count ? 0 : index + 1
        self.switchToView(tag: self.keys[index])
    }
    public func prev() {
        guard let current = current, var index = keys.index(of: current) else { return }
        index = index == 0 ? keys.count - 1 : index - 1
        self.switchToView(tag: self.keys[index])
    }
}
