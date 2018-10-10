//
//  HorizontalScrollViewController.swift
//  Refresher-SWIFT
//
//  Created by Abraham, Aneesh on 10/4/18.
//  Copyright © 2018 Ammini Inc. All rights reserved.
//

import UIKit

struct SuggestionTextSize {
    static let height = 30
    static let margin = 10
    static let originY = 5
    static let fontSize = 16.0
    static let scrollViewHeight = 44
}

class HorizontalScrollViewController: UIViewController {
    
    let suggestionScrollView = UIScrollView()
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createAccessoryView()
        textField.becomeFirstResponder()
        // Do any additional setup after loading the view.
    }
    
    func createAccessoryView (){
        
        let suggestions = ["ഖിയാസ്‌ഡസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡഡ","ഖ്‌അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡഡ","ഖ്അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡഡ","ഖിയാസ്‌ഡസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡവ","qwertyu","ഖ്‌അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡവ","qwertyu","qwertyu","qwertyu","qwertyu","qwertyu","ഖ്‌അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡവ","qwertyu","qwertyu","qwertyu","ഖ്അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡഡ","qwertyu","ഖ്‌അസ്‌വസ്സ്‌ഡ്ക്രഫ്വ്വ്വ്ഖ്ഖ്ഖ്വെവെഡഡഡഡ"]
        let screensize: CGRect = UIScreen.main.bounds
        let screenWidth = screensize.width
        suggestionScrollView.frame = CGRect(x: SuggestionTextSize.margin, y: 0, width: Int(screenWidth) - SuggestionTextSize.margin * 2, height: SuggestionTextSize.scrollViewHeight + 20 )
        suggestionScrollView.showsVerticalScrollIndicator = false;
        suggestionScrollView.showsHorizontalScrollIndicator = false;
        suggestionScrollView.layer.borderWidth = 1
        suggestionScrollView.layer.borderColor = UIColor.green.cgColor
        
        var textContentWidth = 0
        var lastOrigin = 0;
        
        for text in suggestions {
            let estimatedButtonWidth = getTextWidth(text: text, font: UIFont.systemFont(ofSize: CGFloat(SuggestionTextSize.fontSize)))
            let newButton = createButton(title: text)
            newButton.frame = CGRect(x:lastOrigin ,y:SuggestionTextSize.originY, width:Int(estimatedButtonWidth) , height:SuggestionTextSize.height )
            suggestionScrollView.addSubview(newButton)
            textContentWidth = textContentWidth + Int(estimatedButtonWidth) + SuggestionTextSize.margin
            lastOrigin = lastOrigin + Int(estimatedButtonWidth) + SuggestionTextSize.margin
        }
        
        if  suggestions.count > 0 {
            suggestionScrollView.contentSize = CGSize(width: textContentWidth, height: SuggestionTextSize.scrollViewHeight)
            textField.inputAccessoryView = suggestionScrollView
        }

    }
    
    func createButton (title:String) -> UIButton {
        let aButton = UIButton(type: .roundedRect)
        aButton.backgroundColor = .clear
        aButton.setTitle(title, for: .normal)
        aButton.addTarget(self, action: #selector(didTapOnSuggestedText), for: .touchUpInside)
        aButton.sizeToFit()
        aButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        aButton.setTitleColor(UIColor.black, for: .normal)
        aButton.layer.borderWidth = 1
        aButton.layer.borderColor = UIColor.green.cgColor
        return aButton
    }
    
    @objc func didTapOnSuggestedText (sender: UIButton!) {
        print("Tapped!")
    }
    
    func getTextWidth(text: String, font: UIFont?) -> CGFloat {
        let attributes = font != nil ? [NSAttributedString.Key.font: font] : [:]
        return text.size(withAttributes: attributes as [NSAttributedString.Key : Any]).width
    }
}
