//
//  VCHomeViewController.swift
//  SYPCameVideo
//
//  Created by dapeng on 2017/1/16.
//  Copyright © 2017年 SYP. All rights reserved.
//

import UIKit
import Photos

class VCHomeViewController: VCBaseViewController ,UICollectionViewDelegate ,UICollectionViewDataSource {
    
    var assetsFetchResult =  PHFetchResult<AnyObject>()
    ///缩略图大小
    var assetGridThumbnailSize = CGSize()
    /// 带缓存的图片管理对象
    var imageManager = PHCachingImageManager()
    
    var collectionView : UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "主页"
        
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors?.append(NSSortDescriptor(key:"createDate",ascending:true))
        //只取图片 
        allPhotosOptions.predicate = NSPredicate(format: "mediaType = %d",
                                             PHAssetMediaType.image.rawValue)
        
//        assetGridThumbnailSize = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: allPhotosOptions)
        
    
        assetsFetchResult = PHAsset.fetchAssets(with: PHAssetMediaType.image,
                                                              options: allPhotosOptions) as! PHFetchResult<AnyObject>
        
        
        self.imageManager = PHCachingImageManager()
        self.resetCachedAssets()
        

        
        let flowLayout = UICollectionViewFlowLayout()
        
        // 2.设置 Item 的 Size
        flowLayout.itemSize = CGSize(width: (SWIDTH-2)/2 , height:  (SWIDTH-2)/2)
        
        // 3.设置 Item 的排列方式
        flowLayout.scrollDirection = UICollectionViewScrollDirection.vertical
        
        // 4.设置 Item 的四周边距
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        // 5.设置同一竖中上下相邻的两个 Item 之间的间距
        flowLayout.minimumLineSpacing = CGFloat(integerLiteral: 1)
        //
        //        // 6.设置同一行中相邻的两个 Item 之间的间距
        flowLayout.minimumInteritemSpacing = CGFloat(integerLiteral: 1)
        
        // 7.设置UICollectionView 的页头尺寸
        //flowLayout.headerReferenceSize = CGSize(width:100,height: 50)
        
        // 8.设置 UICollectionView 的页尾尺寸
        // flowLayout.footerReferenceSize = CGSize(width:100, height: 50)
        
        
        // 1.自定义 UICollectionView 的位置大小, 以及 Item 的显示样式为 flowLayout
        self.collectionView =  UICollectionView(frame: CGRect(x:0,y: 0, width:SWIDTH,  height:SHEIGHT), collectionViewLayout: flowLayout)
        
        // 2.设置 UICollectionView 的背景颜色
        self.collectionView?.backgroundColor = UIColor.white
        
        // 3.设置 UICollectionView 垂直滚动是否滚到 Item 的最底部内容
        self.collectionView?.alwaysBounceVertical = true
        
        // 4.设置 UICollectionView 垂直滚动是否滚到 Item 的最右边内容
        // collection.alwaysBounceHorizontal = true
        
        // 5.设置 UICollectionView 的数据源对象
        self.collectionView?.dataSource = self
        
        // 6.设置 UICollectionView 的代理对象
        self.collectionView?.delegate = self
        
        
        // 7.设置 UICollectionView 的单元格点击(默认是 true)
        self.collectionView?.allowsSelection = true
        
        // 8.设置 UICollectionView 的单元格多选(默认是 false)
        self.collectionView?.allowsMultipleSelection = false
        
        // 9.开启 UICollectionView 的分页显示效果
        self.collectionView?.isPagingEnabled = true
        
        // 10.注册 UICollectionViewCell
        
        self.collectionView!.register(SYPSelectPhotoCollectionViewCell.self, forCellWithReuseIdentifier:"PhotoCollectionViewCell")
        // 11.添加到 self.view 上
        self.view.addSubview(self.collectionView!)

        // Do any additional setup after loading the view.
    }
    
    func resetCachedAssets() {
        self.imageManager.stopCachingImagesForAllAssets()
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.assetsFetchResult.count;
    }
    
    // CollectionView行数
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // storyboard里设计的单元格
        let identify:String = "PhotoCollectionViewCell"
        // 获取设计的单元格，不需要再动态添加界面元素
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: identify, for: indexPath as IndexPath) as! SYPSelectPhotoCollectionViewCell
    
        let asset = self.assetsFetchResult[indexPath.row] as! PHAsset

        let options = PHImageRequestOptions()
        // deliveryMode 控制获取的图像的质量
        options.deliveryMode = .highQualityFormat

        self.imageManager.requestImage(for: asset, targetSize: assetGridThumbnailSize, contentMode: PHImageContentMode.aspectFit, options: options) { (result, info) in
            
            collectionCell.imgView?.image = result
    
            
            //
        }
        
        
        return collectionCell

    }
    // 获取单元格
   
    
     func collectionView(collectionView: UICollectionView,
                                 didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        let myAsset = self.assetsFetchResults[indexPath.row] as! PHAsset
//        
//        //这里不使用segue跳转（建议用segue跳转）
//        let detailViewController = UIStoryboard(name: "Main", bundle: nil)
//            .instantiateViewControllerWithIdentifier("detail")
//            as! ImageDetailViewController
//        detailViewController.myAsset = myAsset
//        
//        // navigationController跳转到detailViewController
//        self.navigationController!.pushViewController(detailViewController,
//                                                      animated:true)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
