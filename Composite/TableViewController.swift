//
//  TableViewController.swift
//  Composite
//
//  Created by Nataliya Lazouskaya on 1.11.22.
//

import UIKit

class TableViewController: UITableViewController {
    
    private var currentFolder: Composite =  Folder(name: "Main")
    private var tableViewController: TableViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else {
            print("Smth went wrong")
            return TableViewController() }
        return vc
    }
    
    private var fileCounter: Int = 1
    private var folderCounter: Int = 1

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func addFileBarButtonPressed(_ sender: UIBarButtonItem) {
        currentFolder.addComponent(c: File(name: "New File \(fileCounter)"))
        fileCounter += 1
        tableView.reloadData()
    }
    
    @IBAction func addFolderBarButtonPressed(_ sender: UIBarButtonItem) {
        currentFolder.addComponent(c: Folder(name: "New Folder\(folderCounter)"))
        folderCounter += 1
        tableView.reloadData()
    }
    
    private func showFolder() {
        print("Folder")
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentFolder.contentCount()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        guard let contents = currentFolder.showContent() as? [Composite] else { fatalError() }
        let item = contents[indexPath.row]
        cell.textLabel?.text = item.name
        cell.detailTextLabel? .text = item is Folder ? "Folder" : "File"
        cell.imageView?.image = UIImage(systemName: item is Folder ? "doc" : "folder")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        guard let contents = currentFolder.showContent() as? [Composite] else { fatalError() }
        let item = contents[indexPath.row]
        tableViewController.currentFolder = item
        item is Folder ? showFolder(): print(item.showContent())
    }
}
