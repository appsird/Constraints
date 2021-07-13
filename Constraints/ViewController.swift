//
//  ViewController.swift
//  Constraints
//
//  Created by Brian on 7/12/21.
//

// https://stackoverflow.com/questions/26180822/how-to-add-constraints-programmatically-using-swift

import Cocoa

class CustomView: NSView {
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 100, height: 100)
    }
    
}

class ViewController: NSViewController {

    // return a colored view
    func getView() -> NSView {
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        let newView = NSView(frame: frame)
        newView.wantsLayer = true
        newView.layer?.backgroundColor = NSColor.blue.cgColor
        
        // "If you set it to false, then the frame is ignored and positioning and size must be fully specified by NSLayoutConstraints.
        //  If you set it to true, then the frame will be translated into constraints by macOS"
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)
        return newView
    }
    
    // 1. Using NSLayoutConstraint initializer
    func type_1_a() {
        let newView = getView()
        
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func type_1_b() {
        let newView = getView()

        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func type_1_c() {
        let newView = getView()
        
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1, constant: 100).isActive = true
    }
    
    // 2. Using Visual Format Language
    func type_2_a() {
        let newView = getView()

        let views = ["view": view, "newView": newView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-(<=0)-[newView(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(<=0)-[newView(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        view.addConstraints(horizontalConstraints)
        view.addConstraints(verticalConstraints)
    }

    func type_2_b() {
        let newView = getView()

        let views = ["view": view, "newView": newView]
        let horizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[view]-(<=0)-[newView(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterY, metrics: nil, views: views)
        let verticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view]-(<=0)-[newView(100)]", options: NSLayoutConstraint.FormatOptions.alignAllCenterX, metrics: nil, views: views)
        NSLayoutConstraint.activate(horizontalConstraints)
        NSLayoutConstraint.activate(verticalConstraints)
    }

    // 3. Using a mix of NSLayoutConstraint initializer and Visual Format Language
    func type_3_a() {
        let newView = getView()

        let views = ["newView": newView]
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        view.addConstraints(widthConstraints)
        view.addConstraints(heightConstraints)
        view.addConstraints([horizontalConstraint, verticalConstraint])
    }

    func type_3_b() {
        let newView = getView()
        
        let views = ["newView": newView]
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let horizontalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate(widthConstraints)
        NSLayoutConstraint.activate(heightConstraints)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }
    
    func type_3_c() {
        let newView = getView()
        
        let views = ["newView": newView]
        let widthConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        let heightConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[newView(100)]", options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: views)
        NSLayoutConstraint.activate(widthConstraints)
        NSLayoutConstraint.activate(heightConstraints)
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: newView, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: view, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    // 4. Using UIView.AutoresizingMask
    func type_4() {
        let newView = getView()

//        newView.center = CGPoint(x: view.bounds.midX, y: view.bounds.midY)
        newView.autoresizingMask = [NSView.AutoresizingMask.minXMargin, NSView.AutoresizingMask.maxXMargin, NSView.AutoresizingMask.maxYMargin, NSView.AutoresizingMask.minYMargin]
    }

    // 5. Using NSLayoutAnchor
    func type_5_a() {
        let newView = getView()

        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = newView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = newView.heightAnchor.constraint(equalToConstant: 100)
        view.addConstraints([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }

    func type_5_b() {
        let newView = getView()

        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let widthConstraint = newView.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = newView.heightAnchor.constraint(equalToConstant: 100)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
    
    func type_5_c() {
        let newView = getView()
        
        newView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        newView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    // 6. Using intrinsicContentSize and NSLayoutAnchor
    func type_6() {
        let frame = CGRect(origin: .zero, size: CGSize(width: 100, height: 100))
        let newView = NSView(frame: frame)

        newView.wantsLayer = true
        newView.layer?.backgroundColor = NSColor.blue.cgColor
        newView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(newView)

        let horizontalConstraint = newView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let verticalConstraint = newView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint])
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call any of above modes
        type_6()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

