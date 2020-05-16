//
//  ViewController.swift
//  WynkDemo
//
//  Created by Smriti on 14/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    /*
      UI Outlets
    */
    @IBOutlet weak var searchBarView: UIView!
    @IBOutlet weak var searchTextField: AutoSuggestTextField!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Define properties
    var listViewModel = [DataObjectsViewModel]()
    
    var currentPage : Int = 0
    var isLoadingList : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Search Screen"
        searchBarView.setUpViewShadow()
        searchTextField.setRightImage()
        tableView.dataSource = self
        tableView.delegate = self
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadMoreItemsForList()
    }
 
    //MARK:- Fetch result from server
    func getListFromServer(_ pageNumber: Int){
        self.isLoadingList = false
        
        if let text = searchTextField.text, text != ""{
            let params = ["key": Constants.API_KEY,"q": text, "image_type": "photo","page":"\(pageNumber)"]
            DispatchQueue.main.async {
                NetworkManager().sendUser(params) { [weak self] data,error  in
                    if error != nil{
                        self?.createAlert(title: "Alert", body: error!.localizedDescription)
                    }
                    else{
                        if let data = data{
                            self?.listViewModel = data.hits.map({return DataObjectsViewModel(data: $0)})
                            DispatchQueue.main.async {
                                self?.tableView.reloadData()
                            }
                        }
                    }
                }
            }
            
        }
        else{
            self.createAlert(title: "OOPS!", body: "Please enter some keyword for results")
        }
    }
    
    @IBAction func endEditingTextField(_ sender: AutoSuggestTextField) {
        loadMoreItemsForList()
    }
    func loadMoreItemsForList(){
        currentPage += 1
        getListFromServer(currentPage)
    }
     
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !isLoadingList){
            self.isLoadingList = true
            self.loadMoreItemsForList()
        }
    }
    
    
}


extension ViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ListTableViewCell
        let dataObject = self.listViewModel[indexPath.row]
        cell.dataViewModel = dataObject
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController
        vc.imageListViewModel = listViewModel
        vc.modalPresentationStyle = .popover
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
}

