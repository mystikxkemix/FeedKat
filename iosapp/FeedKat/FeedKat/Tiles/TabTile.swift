import UIKit
import Charts

class TabTile:Tile, UITextFieldDelegate
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
    var text1:UILabel?
    
    
    var eFeed:[UILabel] = []
    var tFeed:[UILabel] = []
    var modWeight:[UITextField] = []
    var modHour:[UITextField] = []
    let timeFormatter = DateFormatter()
    var feedList:[FeedTime] = []
    
    init(cat:Cat, type:Int, parent:DetailsCatBoardVC, UiImage:UIImageView?, UiDate:UITextField?)
    {
        self.cat = cat
        self.type = type
        self.parent = parent
        self.eDate = UiDate
        super.init(type: type)
        
        switch type
        {
        case 0:
            self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*3)
            self.UiImage = UiImage!
        case 1:
            self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: CGFloat(cat.feeds.count+2)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5))
            self.heightAnchor.constraint(equalToConstant: CGFloat(cat.feeds.count+2)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5)).isActive = true
        case 2:
            self.frame = CGRect (x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*6)
            self.heightAnchor.constraint(equalToConstant: Static.tileHeight*6).isActive = true
        default: break
        }
        
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
    
    func setContent()
    {
        switch type!
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
        
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(TabTile.resignInfoResponder)))
        timeFormatter.dateStyle = .medium
        timeFormatter.timeStyle = .none
    
        eDate!.text = timeFormatter.string(from: self.date!)
        
        eLabel = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth - Static.tileWidth*0.02, height: Static.tileHeight*0.6))
        eLabel!.text = "Editer"
        eLabel!.textColor = UIColor.white
        eLabel!.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
        eLabel!.textAlignment = NSTextAlignment.right
        eLabel!.isUserInteractionEnabled = true
        let aSelector : Selector = #selector(TabTile.InfoTapped)
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
        var i = 1;
        var v:UIView
        for feed in cat.feeds
        {
            self.feedList.append(feed)
            v = UIView(frame: CGRect(x: Static.tileWidth*0.05, y: CGFloat(i)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5), width: Static.tileWidth*0.9, height: Static.tileHeight*0.5))
            
            addSubview(v)
            
            let utFeed = UILabel(frame: CGRect(x: 0, y: 0, width: Static.tileWidth, height: Static.tileHeight*0.5))
            utFeed.text = "- \(feed.Weight)g à \(feed.Hour)"
            utFeed.textColor = UIColor.black
            utFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 20)
            utFeed.textAlignment = NSTextAlignment.left
            
            tFeed.append(utFeed)
            
            let ueFeed = UILabel(frame: CGRect(x: Static.tileWidth*0.7, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
            ueFeed.text = "Editer"
            ueFeed.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            ueFeed.textAlignment = NSTextAlignment.right
            ueFeed.isUserInteractionEnabled = true
            ueFeed.tag = i-1
            let aSelector : Selector = #selector(TabTile.FeedTapped)
            let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
            tapGesture.numberOfTapsRequired = 1
            ueFeed.addGestureRecognizer(tapGesture)
            
            eFeed.append(ueFeed)

            let umodWeight = UITextField(frame: CGRect(x: 0, y: 0, width: Static.tileWidth*0.2, height: Static.tileHeight*0.5))
            umodWeight.text = "\(feed.Weight)"
            umodWeight.delegate = self
            umodWeight.textColor = Static.BlueColor
            umodWeight.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            umodWeight.textAlignment = .center
            umodWeight.layer.borderWidth = 1
            umodWeight.layer.borderColor = UIColor.black.cgColor
            umodWeight.layer.cornerRadius = 10
            umodWeight.isHidden = true
            //umodWeight.addTarget(self, action: #selector(DetailsCatBoardVC.txtFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
            //umodWeight.addTarget(self, action: #selector(TabTile.feedTimeField(_:)), for: .ed)
            
            
            self.modWeight.append(umodWeight)
            
            let umodHour = UITextField(frame: CGRect(x: Static.tileWidth*0.3, y: 0, width: Static.tileWidth*0.3, height: Static.tileHeight*0.5))
            umodHour.text = "\(feed.Hour)"
            umodHour.delegate = self
            umodHour.textColor = Static.BlueColor
            umodHour.font = UIFont(name: "Arial Rounded MT Bold", size: 18)
            umodHour.textAlignment = .center
            umodHour.layer.borderWidth = 1
            umodHour.layer.borderColor = UIColor.black.cgColor
            umodHour.layer.cornerRadius = 10
            umodHour.isHidden = true
            //umodHour.addTarget(self, action: #selector(DetailsCatBoardVC.txtFieldDidChange(textField:)), for: UIControlEvents.editingChanged)
            umodHour.addTarget(self, action: #selector(TabTile.feedTimeField(_:)), for: .editingDidBegin)
            
            modHour.append(umodHour)
            
            v.addSubview(utFeed)
            v.addSubview(ueFeed)
            v.addSubview(umodWeight)
            v.addSubview(umodHour)
            i+=1
        }
        
        let ajout = UILabel(frame: CGRect(x: Static.tileWidth*0.05, y: CGFloat(i)*(Static.tileHeight*0.5 + Static.tileSpacing*0.5), width: Static.tileWidth, height: Static.tileHeight*0.5))
        ajout.text = "Ajouter un FeedTime"
        ajout.textColor = UIColor.darkGray
        ajout.font = UIFont(name: "Arial Rounded MT Bold", size: 14)
        ajout.textAlignment = NSTextAlignment.center
        addSubview(ajout)
    }
    
    func initGraph()
    {
        
        let barActivity = BarChartView(frame: CGRect(x: Static.tileWidth*0.06, y: Static.tileHeight*0.9, width: Static.tileWidth*0.9, height: Static.tileHeight*2.2))
        
        barActivity.chartDescription?.text = "";
        barActivity.noDataText = "Data will be loaded soon."
        
        barActivity.drawBarShadowEnabled = false
        barActivity.drawValueAboveBarEnabled = false
        
        barActivity.maxVisibleCount = 6
        barActivity.fitBars = true
        barActivity.pinchZoomEnabled = true
        barActivity.drawGridBackgroundEnabled = false
        barActivity.drawBordersEnabled = false
        barActivity.dragEnabled = true
        
        var yValsActivity: [BarChartDataEntry] = []
        let tabActivity = [1000, 1500, 1300, 2000, 500, 1200, 1000, 1500, 1300, 2000, 500, 1200]
        for idx in 0..<tabActivity.count {
            yValsActivity.append(BarChartDataEntry(x: Double(Float(idx)), y: Double(tabActivity[idx])))
        }
        
        let set1Activity = BarChartDataSet(values: yValsActivity, label: "Activité")
        set1Activity.setColor(Static.OrangeColor)
        
        let dataActivity = BarChartData(dataSet: set1Activity)
        dataActivity.setValueFont(UIFont(name: "Arial Rounded MT Bold", size: 20))
        barActivity.data = dataActivity
        
        addSubview(barActivity)
        
        let lineWeight = LineChartView(frame: CGRect(x: Static.tileWidth*0.06, y: Static.tileHeight*3.6, width: Static.tileWidth*0.9, height: Static.tileHeight*2.2))
        
        lineWeight.chartDescription?.text = "";
        lineWeight.noDataText = "Data will be loaded soon."
        
        lineWeight.tintColor = UIColor.black
        
        lineWeight.maxVisibleCount = 6
        lineWeight.pinchZoomEnabled = false
        lineWeight.drawGridBackgroundEnabled = true
        lineWeight.drawBordersEnabled = false
        lineWeight.dragEnabled = true
        
        var yValsWeight: [ChartDataEntry] = []
        let tabWeight = [4.5, 4.3, 3.8, 4.9, 4, 3.0]
        for idy in 0..<tabWeight.count {
            yValsWeight.append(ChartDataEntry(x: Double(idy), y: Double(tabWeight[idy])))
        }
        
        let set1Weight = LineChartDataSet(values: yValsWeight, label: "Poids")
        set1Weight.setCircleColor(Static.TransparentColor)
        set1Weight.circleHoleColor = Static.OrangeColor
        set1Weight.setColor(Static.BlueColor)
        
        let dataWeight = LineChartData(dataSet: set1Weight)
        dataWeight.setValueFont(UIFont(name: "Arial Rounded MT Bold", size: 20))
        lineWeight.data = dataWeight
        
        addSubview(lineWeight)
        
    }
    
    func InfoTapped()
    {
        if(nameText!.isHidden)
        {
            _ = InfoShouldReturn(userText: nameEdit!)
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
    
    func FeedTapped()
    {
        let idx = 0
        
        if(!modHour[idx].isHidden)
        {
            _ = FeedShouldReturn(userText: modHour[idx])
        }
        else
        {
            modHour[idx].isHidden = false
            modWeight[idx].isHidden = false
            tFeed[idx].isHidden = true
            eFeed[idx].text = "Valider"
            eFeed[idx].textColor = UIColor.red
        }
    }
    
    func InfoShouldReturn(userText: UITextField) -> Bool
    {
        resignInfoResponder()
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
    
    func FeedShouldReturn(userText: UITextField) -> Bool
    {
        resignFeedResponder()
        
        modHour[currentInd].isHidden = true
        modWeight[currentInd].isHidden = true
        tFeed[currentInd].isHidden = false
        eFeed[currentInd].text = "Editer"
        eFeed[currentInd].textColor = UIColor.black
        
        feedList[currentInd].Weight = Int(modWeight[currentInd].text!)!
        feedList[currentInd].Hour = modHour[currentInd].text!
        
        reloadFeed()
        
        return true
    }
    
    func reloadDate()
    {
        tDate!.text = "Naissance : \(timeFormatter.string(from: self.date!))"
    }
    
    func reloadFeed()
    {
        tFeed[currentInd].text = "- \(feedList[currentInd].Weight)g à \(feedList[currentInd].Hour)"
    }
    
    func resignInfoResponder()
    {
        eDate?.resignFirstResponder()
        nameEdit?.resignFirstResponder()
    }
    
    func resignFeedResponder()
    {
        modHour[currentInd].resignFirstResponder()
        modWeight[currentInd].resignFirstResponder()
    }
    
    private var currentInd = 0
    
    func feedTimeField(_ sender: UITextField)
    {
        currentInd = modHour.index(of: sender)!
        
        let feedPickerView  : UIDatePicker = UIDatePicker()
        feedPickerView.datePickerMode = UIDatePickerMode.time
        sender.inputView = feedPickerView
        feedPickerView.addTarget(self, action: #selector(TabTile.handleFeedTimePicker(_:)), for: UIControlEvents.valueChanged)
    }
    
    func handleFeedTimePicker(_ sender: UIDatePicker)
    {
//        InfoTab!.eDate!.text = timeFormatter.string(from: sender.time)
//        self.InfoTab!.date! = sender.date
        let feedFormatter = DateFormatter()
        feedFormatter.dateFormat = "H:mm"
        modHour[currentInd].text = feedFormatter.string(from: sender.date)
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
}
