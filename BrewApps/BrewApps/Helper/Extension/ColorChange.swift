//
//  ColorChange.swift

func changeTxtFld (txtArr : [UITextField]){
    for txtfld in txtArr {
        txtfld.changeTxtFlNirzarrs(placeHolderColor: UIColor.black, borderWidth: 0.5, borderColor: UIColor.darkGray, textColor: UIColor.lightGray, bgColor: UIColor.white, font: UIFont.systemFont(ofSize: 15), strPlaceholder: nil)
    }
}

func changeComponentValues (lblArr : [UILabel]){
    for lbl in lblArr {
        lbl.changeLabelAttributes(fontColor: UIColor.black, font: UIFont(name: "Mishafi", size: lbl.font.pointSize), bgColor: UIColor.white)
    }
}

func changeComponentValues (viewArr : [UIView]){
    print(viewArr.count)
    
    for v in viewArr {
        if( type(of: v) == UIView.self){
            v.changeViewAttributes(bgColor: UIColor.white, borderWidth: nil, borderColor: nil)
        }
    }
}

func changeAllBtnAttributes (btnArr : [UIButton] , bgColor : UIColor, titleColor : UIColor, font : UIFont? ,  tintColor : UIColor?){
    for btn in btnArr {
        btn.changeBtnAttributes(bgColor: bgColor, titleColor: titleColor, font: font, tintColor: tintColor, strText: nil)
    }
}

func changeAllBtnTintColor (btnArr : [UIButton]){
    for btn in btnArr {
        btn.setTintColor(UIColor.red)
    }
}

func overrideFontSize(intDefaultFontSize : Int, strBuilderFlySize : String?) -> CGFloat {
    
    return CGFloat(intDefaultFontSize)
}

extension UIButton {
    func changeBtnAttributes(bgColor : UIColor?, borderColor : UIColor = .clear, titleColor : UIColor?, font : UIFont? ,  tintColor : UIColor?, strText : String?)  {
        
        //font else
        /*else {
         self.titleLabel?.font = UIFont(name: Global.shared.wholeAppFont, size: (self.titleLabel?.font.pointSize) ?? 15)
         }*/
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
        
        if titleColor != nil {
            self.setTitleColor(titleColor, for: .normal)
        }
        
        if(font != nil) {
            self.titleLabel?.font = font
        }
        
        if tintColor != nil {
            self.tintColor = tintColor
        }
        
        if strText != nil {
            self.setTitle(strText, for: .normal)
        }
    }
    
    func setTintColor(_ color : UIColor)  {
        self.tintColor = color
    }
}

extension UIFont {
    var bold: UIFont { return withWeight(.bold) }
    var semibold: UIFont { return withWeight(.semibold) }
    var regular: UIFont { return withWeight(.regular) }
    
    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var attributes = fontDescriptor.fontAttributes
        var traits = (attributes[.traits] as? [UIFontDescriptor.TraitKey: Any]) ?? [:]
        
        traits[.weight] = weight
        
        attributes[.name] = nil
        attributes[.traits] = traits
        attributes[.family] = familyName
        
        let descriptor = UIFontDescriptor(fontAttributes: attributes)
        
        return UIFont(descriptor: descriptor, size: pointSize)
    }
}

extension UITextField {
    func changeTxtFlNirzarrs(placeHolderColor : UIColor?, borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont? ,strPlaceholder : String? )  {
        
        if strPlaceholder != nil {
            self.placeholder = strPlaceholder
        }
        if placeHolderColor != nil {
            self.placeHolderColor = placeHolderColor?.withAlphaComponent(0.65)
        }
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UITextView {
    func changeTxtViewAttrs(borderWidth : CGFloat? , borderColor : UIColor?, textColor : UIColor?, bgColor : UIColor? , font : UIFont?)  {
        
        if borderWidth != nil {
            self.borderWidth = borderWidth ?? 0
        }
        if borderColor != nil {
            self.borderColor = borderColor
        }
        if textColor != nil {
            self.textColor = textColor
        }
        if font != nil {
            self.font = font
        }
        if backgroundColor != nil {
            self.backgroundColor = bgColor
        }
    }
}

extension UILabel {
    func changeLabelAttributes( fontColor : UIColor? , font : UIFont? , bgColor : UIColor? )  {
        
        if fontColor != nil {
            self.textColor = fontColor
        }
        
        if font != nil {
            self.font = font
        }
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
    }
}

extension UIView{
    func changeViewAttributes( bgColor : UIColor? , borderWidth : CGFloat? , borderColor : UIColor? )  {
        
        if bgColor != nil {
            self.backgroundColor = bgColor
        }
        
        if borderWidth != nil {
            self.borderWidth = borderWidth!
        }
        
        if borderColor != nil {
            self.borderColor = borderColor
        }
        
    }
}

extension UIView {
    
    func subViews<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        for view in self.subviews {
            if let aView = view as? T{
                all.append(aView)
            }
        }
        return all
    }
    
    func allSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }
}

extension UIColor {
    static func rgbColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
    
    static func colorFromHex(_ hex: String) -> UIColor {
        var hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            hexString.remove(at: hexString.startIndex)
        }
        if hexString.count != 6 {
            return UIColor.magenta
        }
        
        var rgb: UInt64 = 0
        Scanner.init(string: hexString).scanHexInt64(&rgb)
        
        return UIColor.init(red: CGFloat((rgb & 0xFF0000) >> 16)/255,
                            green: CGFloat((rgb & 0x00FF00) >> 8)/255,
                            blue: CGFloat(rgb & 0x0000FF)/255,
                            alpha: 1.0)
    }
    
}

extension UIColor {
    
    convenience init(_ hex: String, alpha: CGFloat = 1.0) {
        var cString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if cString.hasPrefix("#") { cString.removeFirst() }
        
        if cString.count != 6 {
            self.init("ff0000")
            return
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}

extension UIColor {
    func toColor(_ color: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 100), 0) / 30
        switch percentage {
        case 0: return self
        case 1: return color
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard self.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return self }
            guard color.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return self }
            
            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
}
