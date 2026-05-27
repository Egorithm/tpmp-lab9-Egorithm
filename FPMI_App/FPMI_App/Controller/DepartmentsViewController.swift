//
//  DepartmentsViewController.swift
//  FPMI_App
//
//  Created by user on 13.05.26.
//  Kurdeko Egor

import Foundation
import UIKit

class DepartmentsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var collectionView: UICollectionView!
    let departments = Department.loadFromPlist()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        title = NSLocalizedString("main_title", comment: "")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: NSLocalizedString("logout_btn", comment: ""),
            style: .plain,
            target: self,
            action: #selector(didTapLogout)
        )
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (view.frame.width / 2) - 15, height: 160)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(DepartmentCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return departments.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DepartmentCell
        let item = departments[indexPath.row]
        cell.label.text = item.name
        cell.img.image = UIImage(named: item.imageName)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detVC = DetailViewController()
        detVC.item = departments[indexPath.row]
        navigationController?.pushViewController(detVC, animated: true)
    }

    @objc func didTapLogout() {
        UserDefaults.standard.set(false, forKey: "isAuth")
        let loginVC = LoginViewController()
        if let window = view.window {
            window.rootViewController = loginVC
            UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: nil, completion: nil)
        }
    }
}
