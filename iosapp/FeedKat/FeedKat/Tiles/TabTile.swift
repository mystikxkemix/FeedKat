import UIKit

class TabTile:Tile, UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    var UiImage:UIImageView!
    var cat:Cat
    var type:Int?
    var nameText:UILabel?
    var nameEdit:UITextField?
    var name:String = ""
    var eLabel:UILabel?
    var tLabel:UILabel?
    var parent:DetailsCatBoardVC
    
    init(cat:Cat, type:Int, parent:DetailsCatBoardVC, UiImage:UIImageView?)
    {
        self.cat = cat
        self.type = type
        self.parent = parent
        super.init(type: type)
        self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3)
        let top = UIView(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        top.backgroundColor = Static.BlueColor
        var title:String = ""
        switch type
        {
        case 0:
            title = "Informations"
            self.UiImage = UiImage!
        case 1:
            title = "FeedTimes"
        case 2:
            title = "Graphiques"
        default: break
        }
        tLabel = UILabel(frame: CGRect(x: Static.tileWidth*0.02, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        tLabel!.text = title
        tLabel!.textColor = UIColor.white
        tLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        
        top.addSubview(tLabel!)
        self.addSubview(top)
        
    }
    
    func setContent(type: Int)
    {
        switch type
        {
        case 0:
            initInfo()
        case 1:
            initFeed()
        case 2:
            initGraph()
        default: break
            
        }
    }
    
    func initInfo()
    {
        let offsetx = Static.tileWidth*0.04 + Static.tileHeight*1.2
        let offsety = Static.tileHeight*0.6 + Static.tileWidth*0.02
        self.name = cat.getName()
        
        eLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth - Static.tileWidth*0.02, height: Static.tileHeight*0.6))
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        eLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        eLabel!.textAlignment = NSTextAlignment.right
        eLabel!.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(TabTile.lblTapped)
        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
        tapGesture.numberOfTapsRequired = 1
        eLabel!.addGestureRecognizer(tapGesture)
        
        nameText = UILabel(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.2 + offsety, width: Static.tileWidth*0.6, height: Static.tileHeight*0.2))
        nameText!.text = "Nom : " + name
        nameText!.textColor = UIColor.black
        nameText!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        nameText!.textAlignment = NSTextAlignment.left
        nameText!.isHidden = false
        
        nameEdit = UITextField(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.2 + offsety, width: Static.tileWidth*0.4, height: Static.tileHeight*0.2))
        nameEdit!.text = name
        nameEdit!.textColor = Static.BlueColor
        nameEdit!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        nameEdit!.textAlignment = NSTextAlignment.left
        nameEdit!.isHidden = true
        nameEdit!.autocorrectionType = .no
        nameEdit!.textAlignment = .center
        nameEdit!.layer.borderWidth = 1
        nameEdit!.layer.cornerRadius = 10

        addSubview(nameText!)
        addSubview(nameEdit!)
        addSubview(eLabel!)
        
        addSubview(UiImage)
        
        
        let bat = UILabel(frame: CGRect(x: offsetx, y: offsety, width: Static.tileWidth*0.6, height: Static.tileHeight*0.3))
        bat.text = "Batterie : \(cat.statusBattery)%"
        bat.textColor = UIColor.black
        bat.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        bat.textAlignment = NSTextAlignment.left
        addSubview(bat)
        
        let weight = UILabel(frame: CGRect(x: offsetx, y: offsety + Static.tileHeight*0.3, width: Static.tileWidth*0.6, height: Static.tileHeight*0.3))
        weight.text = "Poids : \(Double(cat.weight)*0.001)Kg"
        weight.textColor = UIColor.black
        weight.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        weight.textAlignment = NSTextAlignment.left
        addSubview(weight)
        
    }
    
    func initFeed()
    {
        
    }
    
    func initGraph()
    {
        
    }
    
    func lblTapped()
    {
        if(nameText!.isHidden)
        {
            _ = textFieldShouldReturn(userText: nameEdit!)
        }
        else
        {
            UiImage.isUserInteractionEnabled = true
            eLabel!.text = "Valider"
            eLabel!.textColor = UIColor.red
            nameText!.isHidden = true
            nameEdit!.isHidden = false
        }
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool
    {
        userText.resignFirstResponder()
        UiImage.isUserInteractionEnabled = false
        nameEdit!.isHidden = true
        nameText!.isHidden = false
        name = nameEdit!.text!
        nameText!.text = "Nom : " + name
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        
        FeedKatAPI.modifyCat(cat.getID(), key: "name", data: name as NSObject)
        {
            response, error in
            if(error == nil)
            {
                self.cat.Name = self.name
                self.parent.UITitle.text = self.name
            }
        }
        
        let imgdata:NSData = UIImagePNGRepresentation(UiImage.image!)! as NSData
        FeedKatAPI.modifyCat(cat.getID(), key: "photo", data:imgdata.base64EncodedString(options: NSData.Base64EncodingOptions.lineLength64Characters) as NSObject)
        {
            response, error in
            if(error == nil)
            {
                self.cat.image = self.UiImage.image
            }
        }
        return true
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
