import UIKit
public class RandomColorView : UIView{
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
 
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
        self.backgroundColor = UIColor.red
        
    }
    
    @objc
    func handleTap(){
         print("点击RandomColorView")
    }
    
}
