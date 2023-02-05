//
//  HomeMenuViewController.swift
//  MovieHub
//
//  Created by Atchu on 5/2/23.
//

import UIKit

class HomeMenuViewController: UIViewController {

    // MARK: - Outlets and properties
    private var viewModel: HomeMenuViewModelContract!
    private let nibNameString: String = "HomeMenuViewController"

    // MARK: - Init
    init(viewModel: HomeMenuViewModelContract) {
        self.viewModel = viewModel
        let bundle = Bundle(for: type(of: self))
        super.init(nibName: nibNameString, bundle: bundle)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpNavigation()
        // Do any additional setup after loading the view.
    }
    
    func setUpNavigation() {
        self.navigationItem.title = "Movie"
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
