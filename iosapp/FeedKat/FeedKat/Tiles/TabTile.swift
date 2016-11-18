import UIKit

class TabTile:Tile
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
    var tDate:UILabel?
    var eDate:UITextField?
    var date:Date?
    let timeFormatter = DateFormatter()
    
    init(cat:Cat, type:Int, parent:DetailsCatBoardVC, UiImage:UIImageView?, UiDate:UITextField?)
    {
        self.cat = cat
        self.type = type
        self.parent = parent
        self.eDate = UiDate
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
        self.date = cat.Birthdate
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TabTile.resignResponder)))
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
    
        eDate!.text = timeFormatter.string(from: self.date!)
        
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
        
        tDate = UILabel(frame:CGRect(x: Static.tileWidth*0.03, y: Static.tileHeight*1.5 + offsety, width: Static.tileWidth*0.8, height: Static.tileHeight*0.2))
        tDate!.textColor = UIColor.black
        tDate!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        tDate!.textAlignment = NSTextAlignment.left
        tDate!.isHidden = false
        reloadDate()
        
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
        
        addSubview(tDate!)
        addSubview(eDate!)
        
        
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
            eDate!.isHidden = false
            tDate!.isHidden = true
        }
    }
    
    func textFieldShouldReturn(userText: UITextField) -> Bool
    {
        resignResponder()
        UiImage.isUserInteractionEnabled = false
        nameEdit!.isHidden = true
        nameText!.isHidden = false
        eDate!.isHidden = true
        tDate!.isHidden = false
        name = nameEdit!.text!
        nameText!.text = "Nom : " + name
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        reloadDate()
        
        FeedKatAPI.modifyCat(cat.getID(), name: name, UiImage: (parent.isNewImage ? self.UiImage.image : nil), birth: self.date)
        {
            response, error in
            if(error == nil)
            {
                self.cat.Name = self.name
                self.parent.UITitle.text = self.name
                if(self.parent.isNewImage){self.cat.image = self.UiImage.image}
                self.cat.Birthdate = self.date!
                self.parent.isNewImage = false
                self.parent.isNewDate = false
            }
            else
            {
                print("err : \(error)")
            }
        }
        return true
    }
    
    func reloadDate()
    {
        tDate!.text = "Naissance : \(timeFormatter.string(from: self.date!))"
    }
    
    func resignResponder()
    {
        eDate?.resignFirstResponder()
        nameEdit?.resignFirstResponder()
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
