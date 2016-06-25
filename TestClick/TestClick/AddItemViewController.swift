//
//  AddItemViewController.swift
//  TestClick
//
//  Created by cl-macmini-150 on 24/06/16.
//  Copyright © 2016 cl-macmini-150. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UITableViewDelegate,UITableViewDataSource
 {
    let pickerData = ["shirt", "jeans Denim", "trousers", "shorts", "jackets"]
    var selecteditem: String!
    let imagePicker = UIImagePickerController()
    let picker = UIPickerView(frame: CGRectMake(0, 200, 200, 300))
    private var DictionaryOfItems = [String : String]()
    var itmeArray: [String] = []
    var dataClass: ModelClass?
    var arrayOfObjects = [ModelClass]()
    var imageNew: UIImage!
  //  var count: Int?
    var filter = ["shirt", "jeans Denim", "trousers", "shorts", "jackets"]
    var a: String = "0"
    let arrayOfObjectsKey = "arrayOfObjectsKey"

    
    //MARK  Outlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itemTextField: UITextField!
        
    @IBAction func saveButton(sender: AnyObject) {
        let names = "\(NSDate()).png".stringByReplacingOccurrencesOfString(" ", withString: "")
        saveData(imageNew, path: fileInDocumentsDirectory(names))
        print(names)
    }
    
    func saveData(image: UIImage, path: String ) {
       //Image saved to AppDirectory
        let pngImageData = UIImagePNGRepresentation(image)
      _ = pngImageData?.writeToFile(path, atomically: true)
        print(path)
        
        dataClass=ModelClass(imagePath: path, itemName: itemTextField!.text!, content : DictionaryOfItems)
        let defaults = NSUserDefaults.standardUserDefaults()

        
        let arrayOfObjectsData = NSKeyedArchiver.archivedDataWithRootObject(arrayOfObjects)
        defaults.setObject(arrayOfObjectsData, forKey: arrayOfObjectsKey)
        
        
        
        
        
        let arrayOfObjectsUnarchivedData = defaults.dataForKey(arrayOfObjectsKey)!
        let arrayOfObjectsUnarchived = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfObjectsUnarchivedData) as! [ModelClass]
        print(arrayOfObjectsUnarchived)
        
        
        
        
        
        
//        if NSUserDefaults.standardUserDefaults().valueForKey("demoProject") != nil{
//            print(NSUserDefaults.standardUserDefaults().valueForKey("demoProject"))
//            
//            data = (NSUserDefaults.standardUserDefaults().arrayForKey("demoProject") as! [[String:String]])
//            data.appendContentsOf(allImagedata)
//            
//        }
//        else{
//            data=allImagedata
//        }
//        
//        NSUserDefaults.standardUserDefaults().setObject(data, forKey: "demoProject")
        
        
        
    }
    
    
    
    //  Get the documents Directory
    func documentsDirectory() -> String {
        let documentsFolderPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)[0]
        //print(documentsFolderPath)
        return documentsFolderPath
    }
    
    // Get path for a file in the directory
    func fileInDocumentsDirectory(filename: String) -> String {
        let path = documentsDirectory().stringByAppendingPathComponent(filename)
        print(path)
        return path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view.
        circularImage(imageView)
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(AddItemViewController.imageTapped(_:)))
        imagePicker.delegate = self
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapGestureRecognizer)
    //pickerVieew
        picker.backgroundColor = .whiteColor()
        picker.showsSelectionIndicator = true
        picker.delegate = self
        picker.dataSource = self
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.Default
        toolBar.translucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AddItemViewController.donePicker(_:)))
        toolBar.setItems([doneButton], animated: false)
        toolBar.userInteractionEnabled = true
        textField.inputView = picker
        textField.inputAccessoryView = toolBar
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }

  
    
    func imageTapped(img: AnyObject){
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .PhotoLibrary
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    //MARK  function to make Image Circular
    func circularImage(photoImageView: UIImageView?){
        photoImageView!.layer.frame = CGRectInset(photoImageView!.layer.frame, 0, 0)
        photoImageView!.layer.borderColor = UIColor.grayColor().CGColor
        photoImageView!.layer.cornerRadius = photoImageView!.frame.height/2
        photoImageView!.layer.masksToBounds = false
        photoImageView!.clipsToBounds = true
        photoImageView!.layer.borderWidth = 0.5
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageView.contentMode = .ScaleAspectFill
            imageView.image = pickedImage
            imageNew = pickedImage
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // Deligate Functions of picker view
    //
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let a1=Set(filter)
        if selecteditem != nil{
        let a2=Set(arrayLiteral: selecteditem)
        filter=Array(a1.subtract(a2))
        }
        print(filter)
        return filter.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return filter[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = filter[row]
        selecteditem = filter[row]
        
//      if itmeArray.contains(selecteditem) == false
//      {
//        itmeArray.append(selecteditem)
//      }
        print(selecteditem)
//      let a1=Set(pickerData)
//      let a2=Set(itmeArray)
//      filter=Array(a1.subtract(a2))
//      print(filter)
    }
    
    
    func donePicker(pick: AnyObject) {
        itmeArray.append(selecteditem)
        textField.resignFirstResponder()
        print(selecteditem)
        DictionaryOfItems.updateValue(a, forKey: selecteditem)
        print (DictionaryOfItems)
        self.tableView.reloadData()

    }
    
    
    //MARK  Table view data source protocol conformation
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(itmeArray.count)
        return itmeArray.count
    }
    
    // create a cell for each table view row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CustomItemCellTableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! CustomItemCellTableViewCell
        cell.itemLabel.text=itmeArray[indexPath.row]
        print(DictionaryOfItems.updateValue((cell.countLabel.text!), forKey: itmeArray[indexPath.row]))
        return cell
    }
    
    
    // method to run when table view cell is tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.Delete) {
        // handle delete (by removing the data from your array and updating the tableview)
           let t = itmeArray.removeAtIndex(indexPath.row)
           tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
           filter.append(t)
           self.tableView.reloadData()
            }
    }
}

extension String {
    
    func stringByAppendingPathComponent(path: String) -> String {
        
        let nsSt = self as NSString
        
        return nsSt.stringByAppendingPathComponent(path)
    }
}
