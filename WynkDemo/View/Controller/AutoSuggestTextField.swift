//
//  AutoSuggestTextField.swift
//  WynkDemo
//
//  Created by Smriti on 16/05/20.
//  Copyright © 2020 Smriti. All rights reserved.
//

import UIKit
import CoreData

protocol SuggestedListDropDownDelegate {
    func optionSelected(option: String)
}

class AutoSuggestTextField: UITextField{
    
    var dataList : [Result] = [Result]()
    var resultsList : [SearchItem] = [SearchItem]()
    var tableView: UITableView?
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
//    var delegate: SuggestedListDropDownDelegate?
    
    // Connecting the new element to the parent view
    open override func willMove(toWindow newWindow: UIWindow?) {
        super.willMove(toWindow: newWindow)
        tableView?.removeFromSuperview()        
    }
    
    override open func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        self.addTarget(self, action: #selector(AutoSuggestTextField.textFieldDidChange), for: .editingChanged)
        self.addTarget(self, action: #selector(AutoSuggestTextField.textFieldDidBeginEditing), for: .editingDidBegin)
        self.addTarget(self, action: #selector(AutoSuggestTextField.textFieldDidEndEditing), for: .editingDidEnd)
        self.addTarget(self, action: #selector(AutoSuggestTextField.textFieldDidEndEditingOnExit), for: .editingDidEndOnExit)
    }
    
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        buildSearchTableView()
        
    }
    
    
    //////////////////////////////////////////////////////////////////////////////
    // Text Field related methods
    //////////////////////////////////////////////////////////////////////////////
    
    @objc open func textFieldDidChange(){
        filter()
        updateSearchTableView()
        tableView?.isHidden = false
    }
    
    @objc open func textFieldDidBeginEditing() {
        print("Begin Editing")
    }
    
    @objc open func textFieldDidEndEditing() {
        print("End editing")
         addData()
    }
    
    @objc open func textFieldDidEndEditingOnExit() {
        print("End on Exit")
//        delegate?.optionSelected(option: capitalized)
    }
    
    //////////////////////////////////////////////////////////////////////////////
    // Data Handling methods
    //////////////////////////////////////////////////////////////////////////////
    
    
    // MARK: CoreData manipulation methods
    
    // Don't need this function in this case
    func saveItems(text: String) {
          do {
            try context.save()
          } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
          }

    }
    
    func loadItems(withRequest request : NSFetchRequest<Result>) {
        print("loading items")
        do {
            dataList = try context.fetch(request)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }

    }
    
    // MARK: Filtering methods
    
    fileprivate func filter() {
        let predicate = NSPredicate(format: "nameType CONTAINS[cd] %@", self.text!)
        let request : NSFetchRequest<Result> = Result.fetchRequest()
        request.predicate = predicate
        
        loadItems(withRequest : request)
        resultsList = []
        
        for i in 0 ..< dataList.count {

            let item = SearchItem(searchSttring: dataList[i].nameType!)
            let searchStringFilter = (item.nameType as NSString).range(of: text!, options: .caseInsensitive)
            if searchStringFilter.location != NSNotFound {
                item.attributedSearchName = NSMutableAttributedString(string: item.nameType)

                item.attributedSearchName!.setAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], range: searchStringFilter)

                resultsList.append(item)
            }
            print("resultant list \(resultsList)")
            tableView?.reloadData()
        }
    }


}

extension AutoSuggestTextField: UITableViewDelegate, UITableViewDataSource {
    

    //////////////////////////////////////////////////////////////////////////////
    // Table View related methods
    //////////////////////////////////////////////////////////////////////////////
    
    
    // MARK: TableView creation and updating
    
    // Create SearchTableview
    func buildSearchTableView() {

        if let tableView = tableView {
            tableView.register(SuggestedListTableViewCell.self, forCellReuseIdentifier: "option")
            tableView.delegate = self
            tableView.dataSource = self
            self.window?.addSubview(tableView)

        } else {
            addData()
            print("tableView created")
            tableView = UITableView(frame: CGRect.zero)
        }
        
        updateSearchTableView()
    }
    
    // Updating SearchtableView
    func updateSearchTableView() {
        
        if let tableView = tableView {
            superview?.bringSubviewToFront(tableView)
            var tableHeight: CGFloat = 0
            tableHeight = tableView.contentSize.height
            
            // Set a bottom margin of 10p
            if tableHeight < tableView.contentSize.height {
                tableHeight -= 10
            }
            
            // Set tableView frame
            var tableViewFrame = CGRect(x: 0, y: 0, width: frame.size.width - 4, height: tableHeight)
            tableViewFrame.origin = self.convert(tableViewFrame.origin, to: nil)
            tableViewFrame.origin.x += 2
            tableViewFrame.origin.y += frame.size.height + 2
            UIView.animate(withDuration: 0.2, animations: { [weak self] in
                self?.tableView?.frame = tableViewFrame
            })
            
            //Setting tableView style
            tableView.layer.masksToBounds = true
            tableView.separatorInset = UIEdgeInsets.zero
            tableView.layer.cornerRadius = 5.0
            tableView.separatorColor = UIColor.lightGray
            tableView.backgroundColor = UIColor.white.withAlphaComponent(0.4)
            
            if self.isFirstResponder {
                superview?.bringSubviewToFront(self)
            }
            
            tableView.reloadData()
        }
    }
    
    
    
    // MARK: TableViewDataSource methods
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(resultsList.count)
        return resultsList.count
    }
    
    // MARK: TableViewDelegate methods
    
    //Adding rows in the tableview with the data from dataList
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "option") as! SuggestedListTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.configureCell(with: resultsList[indexPath.row].getFormatedText())
       
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected row")
        self.text = resultsList[indexPath.row].getStringText()
        tableView.isHidden = true
        self.endEditing(true)
    }
    

    // MARK: Early testing methods
    func addData(){
        let a = Result(context: context)
        guard let text = self.text else { return }
        let capitalized = text.capitalized
        self.text = capitalized
        a.nameType = text
       
        saveItems(text: a.nameType!)
        
        dataList.append(a)
//        dataList.append(b)
//        dataList.append(c)
//        dataList.append(d)
//        dataList.append(e)
    }
    
}
