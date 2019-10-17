import UIKit
import PlaygroundSupport



let view = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
view.backgroundColor = UIColor.red
PlaygroundPage.current.liveView = view


let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
iv.image = UIImage(named: "logo")
PlaygroundPage.current.liveView = iv


let bg = RandomColorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
PlaygroundPage.current.liveView = bg


