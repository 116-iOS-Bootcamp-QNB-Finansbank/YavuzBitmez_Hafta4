//
//  heroDetailViewController.swift
//  BasicUIComponents
//
//  Created by Yavuz Selim Bitmez on 25.09.2021.
//

import UIKit
import Hero

class HeroDetailViewController: UIViewController {
    @IBOutlet weak var dismissButton: UIButton!

  override func viewDidLoad() {
    super.viewDidLoad()
    if #available(iOS 13.0, tvOS 13, *) {
      view.backgroundColor = .systemBackground
    } else {
      view.backgroundColor = .white
    }
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap)))

    dismissButton.addTarget(self, action: #selector(onTap), for: .touchUpInside)
   
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
   
  }

  @objc func back() {
    dismiss(animated: true, completion: nil)
  }

  @objc func onTap() {
    let vc2 = HeroDetailViewController2()
    vc2.hero.modalAnimationType = .selectBy(presenting: .pull(direction: .left), dismissing: .slide(direction: .down))
    vc2.hero.isEnabled = true
    present(vc2, animated: true, completion: nil)



  }
}

class HeroDetailViewController2: HeroDetailViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .green
  }
}
