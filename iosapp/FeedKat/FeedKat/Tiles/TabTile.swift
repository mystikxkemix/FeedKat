import UIKit

class TabTile:Tile
{
    var UiImage:UIImageView!
    var cat:Cat
    var type:Int?
    
    init(cat:Cat, type:Int)
    {
        self.cat = cat
        self.type = type
        super.init(type: type)
        self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3)
        let top = UIView(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        top.backgroundColor = Static.BlueColor
        var title:String
        switch type
        {
        case 0:
            title = "Informations"
        case 1:
            title = "FeedTimes"
        case 2:
            title = "Graphiques"
        default:
            title = "test"
        }
        let tLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.6))
        tLabel.text = title
        tLabel.textColor = UIColor.white
        tLabel.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
        tLabel.textAlignment = NSTextAlignment.center
        
        top.addSubview(tLabel)
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
        UiImage = UIImageView(frame : CGRect(x: Static.tileWidth*0.01, y: Static.tileHeight*0.6, width: Static.tileHeight*1.2, height: Static.tileHeight*1.2))
        
        if(self.cat.getPhoto() != "")
        {
            if(self.cat.image == nil)
            {
                self.UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
                if let checkedUrl = URL(string: cat.getPhoto())
                {
                    UiImage.contentMode = .scaleAspectFit
                    FeedKatAPI.downloadImage(url: checkedUrl, view: UiImage)
                    {
                        data in
                        self.cat.image = data
                    }
                }
            }
            else
            {
                UiImage.image = cat.image!
            }
        }
        else
        {
            self.UiImage.image = Static.getScaledImageWithHeight("Icon", height: Static.tileHeight)
        }
        
        addSubview(UiImage)
        
        
        
    }
    
    func initFeed()
    {
        
    }
    
    func initGraph()
    {
        
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
