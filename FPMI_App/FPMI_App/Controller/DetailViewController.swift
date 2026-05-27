//
//  DetailViewController.swift
//  FPMI_App
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import Foundation
import UIKit

class DetailViewController: UIViewController {
    var item: Department?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = item?.name
        let l = UILabel(frame: CGRect(x: 20, y: 100, width: view.frame.width-40, height: 400))
        l.numberOfLines = 0
        l.text = "\(NSLocalizedString("head", comment: "")): \(item?.headName ?? "")\n\n\(NSLocalizedString("courses", comment: "")):\n\(item?.courses.joined(separator: "\n") ?? "")"
        view.addSubview(l)
    }
}
