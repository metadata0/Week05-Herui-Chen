//
//  BundleAudio.swift
//  Week05
//
//  Created by Henry Chen on 2/28/23.
//
import SwiftUI
import AVFoundation

let bundleAudio = [
    "07 SR20DET.mp3",
    "Mother.mp3",
    "Why Try.mp3"]

func loadBundleAudio(_ filename: String) -> AVAudioPlayer? {
    //_ is a place holder; it is parsing in a parameter named "filename" with type being a String. It then returns an optional AVAudioPlayer instance.
    let path = Bundle.main.path(forResource: filename, ofType:nil)!
    let url = URL(fileURLWithPath: path)
    //url is refering to the system file path; it creates a new URL object from a local file path and makes it available for use within a closure.
    do {
        return try AVAudioPlayer(contentsOf: url)
    } catch {
        print("loadBundleAudio error", error)
    }
    return nil
}

struct Page1: View {
    @State private var soundIndex = 0
    @State private var soundFile = bundleAudio[0]
    @State private var player: AVAudioPlayer? = nil
    var body: some View {
        //TimelineView is a view that lets you redraw your view as often as you can
        //create a new instance of TimelineView with a predefined animation configuration.
        TimelineView(.animation) { context in
            //The .animation parameter is actually a shorthand for a more complex animation configuration that you can customize further if needed. By default, it specifies a linear timing curve and a duration of 0.35 seconds, but you can change these properties if you want to create a different type of animation.
            VStack {
                HStack {
                    Text("Song \(soundIndex + 1)")
                        .font(.system(size: 60))
                        .foregroundColor(.black)
                }
                
                
                Text("File Name: \(soundFile)")
                if let player = player {
                    Text("duration " + String(format: "%.1f", player.duration) + "s")
                    Text("currentTime " + String(format: "%.1f", player.currentTime) + "s")
                }
                
                HStack {
                    Button("Play") {
                        print("Button Play")
                        player = loadBundleAudio(soundFile)
                        print("player", player as Any)
                        // Loop indefinitely
                        player?.numberOfLoops = -1
                        player?.play()
                    }
                    Button("Stop") {
                        print("Button Stop")
                        player?.stop()
                    }
                    Button("Next") {
                        soundIndex = (soundIndex+1) % bundleAudio.count
                        soundFile = bundleAudio[soundIndex];
                    }
                }
            }
        }
    }
}

struct Page1_Previews: PreviewProvider {
    static var previews: some View {
        Page1()
    }
}

