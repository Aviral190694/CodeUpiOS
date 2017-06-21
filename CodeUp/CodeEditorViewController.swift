//
//  CodeEditorViewController.swift
//  CodeUp
//
//  Created by Aviral Aggarwal on 21/06/17.
//  Copyright © 2017 Aviral Aggarwal. All rights reserved.
//

import UIKit

class CodeEditorViewController: UIViewController {

    var textView = MarkdownTextView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "print", style: .plain, target: self, action: #selector(self.printAction))
        
        let attributes = MarkdownAttributes()
        let textStorage = MarkdownTextStorage(attributes: attributes)
        do {
            textStorage.addHighlighter(try LinkHighlighter())
        } catch let error {
            fatalError("Error initializing LinkHighlighter: \(error)")
        }
        textStorage.addHighlighter(MarkdownStrikethroughHighlighter())
        textStorage.addHighlighter(MarkdownSuperscriptHighlighter())
        if let codeBlockAttributes = attributes.codeBlockAttributes {
            textStorage.addHighlighter(MarkdownFencedCodeHighlighter(attributes: codeBlockAttributes))
        }
        
        textView = MarkdownTextView(frame: CGRect.zero, textStorage: textStorage)
        textView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        
        let views: [String : Any] = ["textView": textView]
        var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[textView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        constraints += NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[textView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activate(constraints)
    }
    
    func printAction() {
        let text = textView.text ?? ""
        print("text: \n\(text)")
        
        let attrText = textView.attributedText ?? NSAttributedString()
        print("attr text: \n\(attrText)")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
