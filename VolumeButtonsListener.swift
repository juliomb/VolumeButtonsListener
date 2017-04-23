//
//  VolumeButtonsListener.swift
//  Created by Julio Martinez on 06/04/2017.
//

import Foundation
import MediaPlayer


class VolumeButtonsListener: NSObject {
    
    static private let outputVolumeKey = "outputVolume"
    static private let volumeView: MPVolumeView = MPVolumeView(frame: CGRect(x: -1000, y: -1000, width: 0, height: 0))
    static private let session = AVAudioSession.sharedInstance()
    static private var currentHandler: (() -> ())?
    static private let shared = VolumeButtonsListener()

    
    static func hideVolumeHUD() {
        UIApplication.shared.delegate?.window??.rootViewController?.view.addSubview(volumeView)
    }
    
    static func listen(handler: @escaping () -> ()){
        do {
            try session.setActive(true)
            if currentHandler == nil {
                session.addObserver(shared, forKeyPath: outputVolumeKey, options: NSKeyValueObservingOptions.new, context: nil)
            }
            currentHandler = handler
        } catch {
            Logger.log.error(error.localizedDescription)
        }
    }
    
    static func stopListen(){
        do {
            try session.setActive(false)
            if currentHandler != nil { // security condition to prevent crashes
                session.removeObserver(shared, forKeyPath: outputVolumeKey)
            }
            currentHandler = nil
        } catch {
            Logger.log.error(error.localizedDescription)
        }
    }

    private static func prepare(){
        if let slider = volumeView.subviews.last as? UISlider{
            slider.value = 0.5 // to prevent reach maximum or minimun
        }
    }
    
    private var preventBounceNotification = false
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == VolumeButtonsListener.outputVolumeKey && preventBounceNotification == false {
            VolumeButtonsListener.prepare()
            if let handler = VolumeButtonsListener.currentHandler {
                handler()
            }
            preventBounceNotification = true
        } else {
            preventBounceNotification = false
        }
    }
    
}
