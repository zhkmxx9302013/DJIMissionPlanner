//
//  FPVCustomize.swift
//  DJIMissionPlan
//
//  Created by zzh on 2021/10/17.
//  Copyright © 2021 DJI. All rights reserved.
//

import Foundation
import DJIUXSDKBeta

class FPVVideoFeedWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("Video Feed", comment: "Video Feed")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("Primary", comment: "Primary"),
            NSLocalizedString("Secondary", comment: "Secondary")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.videoFeed = DJISDKManager.videoFeeder()?.primaryVideoFeed
                case 1: strongSelf.fpvWidget?.videoFeed = DJISDKManager.videoFeeder()?.secondaryVideoFeed
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget, let videoFeeder = DJISDKManager.videoFeeder() {
            return fpv.videoFeed == videoFeeder.primaryVideoFeed ? 0 : 1
        }
        return super.current
    }
}

class FPVCameraNameVisibilityWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("Camera Name", comment: "Camera Name")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("Show", comment: "Show"),
            NSLocalizedString("Hide", comment: "Hide")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.isCameraNameVisible = true
                case 1: strongSelf.fpvWidget?.isCameraNameVisible = false
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.isCameraNameVisible ? 0 : 1
        }
        return super.current
    }
}

class FPVCameraSideVisibilityWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("Camera Side", comment: "Camera Side")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("Show", comment: "Show"),
            NSLocalizedString("Hide", comment: "Hide")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.isCameraSideVisible = true
                case 1: strongSelf.fpvWidget?.isCameraSideVisible = false
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.isCameraSideVisible ? 0 : 1
        }
        return super.current
    }
}

class FPVGridlineVisibilityWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("Gridlines Visibility", comment: "Gridlines Visibility")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("Show", comment: "Show"),
            NSLocalizedString("Hide", comment: "Hide")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.isGridViewVisible = true
                case 1: strongSelf.fpvWidget?.isGridViewVisible = false
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.isGridViewVisible ? 0 : 1
        }
        return super.current
    }
}

class FPVGridlineTypeWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("Gridlines Type", comment: "Gridlines Type")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("None", comment: "None"),
            NSLocalizedString("Parallel", comment: "Parallel"),
            NSLocalizedString("Parallel Diagonal", comment: "Parallel Diagonal")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.gridView.gridViewType = .None
                case 1: strongSelf.fpvWidget?.gridView.gridViewType = .Parallel
                case 2: strongSelf.fpvWidget?.gridView.gridViewType = .ParallelDiagonal
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.gridView.gridViewType.rawValue
        }
        return super.current
    }
}

class FPVCenterViewVisibilityWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("CenterPoint Visibility", comment: "CenterPoint Visibility")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("Show", comment: "Show"),
            NSLocalizedString("Hide", comment: "Hide")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.isCenterViewVisible = true
                case 1: strongSelf.fpvWidget?.isCenterViewVisible = false
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.isCenterViewVisible ? 0 : 1
        }
        return super.current
    }
}

class FPVCenterViewTypeWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("CenterPoint Type", comment: "CenterPoint Type")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("None", comment: "None"),
            NSLocalizedString("Standard", comment: "Standard"),
            NSLocalizedString("Cross", comment: "Cross"),
            NSLocalizedString("Narrow Cross", comment: "Narrow Cross"),
            NSLocalizedString("Frame", comment: "Frame"),
            NSLocalizedString("Frame and Cross", comment: "Frame and Cross"),
            NSLocalizedString("Square", comment: "Square"),
            NSLocalizedString("Square and Cross", comment: "Square and Cross")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.centerView.imageType = .None
                case 1: strongSelf.fpvWidget?.centerView.imageType = .Standard
                case 2: strongSelf.fpvWidget?.centerView.imageType = .Cross
                case 3: strongSelf.fpvWidget?.centerView.imageType = .NarrowCross
                case 4: strongSelf.fpvWidget?.centerView.imageType = .Frame
                case 5: strongSelf.fpvWidget?.centerView.imageType = .FrameAndCross
                case 6: strongSelf.fpvWidget?.centerView.imageType = .Square
                case 7: strongSelf.fpvWidget?.centerView.imageType = .SquareAndCross
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.centerView.imageType.rawValue
        }
        return super.current
    }
    
}

class FPVCenterViewColorWidget: FPVCustomizationWidget {
    
    override func detailsTitle() -> String {
        return NSLocalizedString("CenterPoint Color", comment: "CenterPoint Color")
    }
    
    override func oneOfListOptions() -> [String : Any] {
        return ["current" : current, "list" : [
            NSLocalizedString("None", comment: "None"),
            NSLocalizedString("White", comment: "White"),
            NSLocalizedString("Yellow", comment: "Yellow"),
            NSLocalizedString("Red", comment: "Red"),
            NSLocalizedString("Green", comment: "Green"),
            NSLocalizedString("Blue", comment: "Blue"),
            NSLocalizedString("Black", comment: "Black")]]
    }
    
    override func selectionUpdate() -> (Int) -> Void {
        return { [weak self] selectionIndex in
            if let strongSelf = self {
                switch selectionIndex {
                case 0: strongSelf.fpvWidget?.centerView.colorType = .None
                case 1: strongSelf.fpvWidget?.centerView.colorType = .White
                case 2: strongSelf.fpvWidget?.centerView.colorType = .Yellow
                case 3: strongSelf.fpvWidget?.centerView.colorType = .Red
                case 4: strongSelf.fpvWidget?.centerView.colorType = .Green
                case 5: strongSelf.fpvWidget?.centerView.colorType = .Blue
                case 6: strongSelf.fpvWidget?.centerView.colorType = .Black
                default: break
                }
            }
        }
    }
    
    fileprivate override var current: Int {
        if let fpv = fpvWidget {
            return fpv.centerView.colorType.rawValue
        }
        return super.current
    }
}

class FPVCustomizationWidget: DUXBetaListItemTitleWidget {
    
    var fpvWidget: DUXBetaFPVWidget?
    fileprivate var current: Int {
        return 0
    }
    
    override func hasDetailList() -> Bool {
        return true
    }
    
    override func detailListType() -> DUXBetaListType {
        .selectOne
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
                
        trailingMarginConstraint.isActive = false
        trailingMarginConstraint = trailingTitleGuide.rightAnchor.constraint(equalTo: view.rightAnchor)
        trailingMarginConstraint.isActive = true
    }
    
}
