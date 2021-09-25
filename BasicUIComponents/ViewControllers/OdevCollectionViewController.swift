//
//  OdevCollectionViewController.swift
//  BasicUIComponents
//
//  Created by Yavuz Selim Bitmez on 25.09.2021.
//

import UIKit

class OdevCollectionViewController: UIViewController {

    var collectionViewWidth:Int = 0
    var collectionViewHeight:Int = 0
    let minimumLineSpacing:CGFloat = 10
    var isDivide = true
    
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionSize()
        collectionView.register(MyCollectionViewCell.self, forCellWithReuseIdentifier: "MyCollectionViewCell")
        let rightBarButton = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(changeCollectionViewWidth))
        self.navigationItem.rightBarButtonItem = rightBarButton
        
    }
    
    @objc func changeCollectionViewWidth(){
        if isDivide{
            self.collectionViewWidth = Int(self.view.frame.size.width / 2 - 10)
            isDivide = false
        }else{
            self.collectionViewWidth = Int(self.view.frame.size.width)
            isDivide = true
        }
        self.collectionView.reloadData()
    }
    func initCollectionSize(){
        self.collectionViewWidth = Int(self.view.frame.size.width)
        self.collectionViewHeight = 300
    }
}

extension OdevCollectionViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCollectionViewCell", for: indexPath) as! MyCollectionViewCell
        return cell
    }
}
extension OdevCollectionViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionViewWidth, height: self.collectionViewHeight)

    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return self.minimumLineSpacing
    }
}



class MyCollectionViewCell: UICollectionViewCell {
    override init(frame: CGRect) {
         super.init(frame: frame)

        backgroundColor = .red
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
