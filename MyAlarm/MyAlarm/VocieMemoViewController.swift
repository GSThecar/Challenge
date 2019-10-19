//
//  VocieMemoTableViewController.swift
//  MyAlarm
//
//  Created by 이덕화 on 2019/10/10.
//  Copyright © 2019 GSTheCar. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire


class VocieMemoViewController: UIViewController {
    
    let formatter: DateFormatter = {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return f
    }()
    
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var voiceMemoListTableView: UITableView!
    
    var list: MemoList?
    var recorder: AVAudioRecorder?
    var recordingSession: AVAudioSession?
    let mp3Path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    var player: AVAudioPlayer?
    
    
    @IBAction func stopRecord(_ sender: Any) {
        stopButton.isHidden = true
        recordButton.isHidden = !stopButton.isHidden
        recorder?.stop()
        uploadMemo {
            self.fetch(completion: self.voiceMemoListTableView.reloadData)
        }
    }
    
    @IBAction func startRecord(_ sender: Any) {
        recordButton.isHidden = true
        stopButton.isHidden = !recordButton.isHidden
        let filename = mp3Path.appendingPathComponent("recording.m4a")
        let setting = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC), AVSampleRateKey: 44100, AVNumberOfChannelsKey: 1, AVEncoderAudioQualityKey: AVAudioQuality.low.rawValue
        ]
        do {
            recorder = try AVAudioRecorder(url: filename, settings: setting)
            
        } catch {
            print(error.localizedDescription)
        }
        recorder?.record()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recordButton.layer.cornerRadius = recordButton.bounds.height / 2
        recordButton.isHidden = true
        stopButton.isHidden = true
        
        fetch {
            self.voiceMemoListTableView.reloadData()
        }
        
        recordingSession = AVAudioSession.sharedInstance()
        do {
            try recordingSession?.setCategory(.playAndRecord, mode: .default)
            try recordingSession?.setActive(true)
            recordingSession?.requestRecordPermission() { [weak self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self?.recordButton.isHidden = false
                    } else { print("녹음기능 사용불가") }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        
        
    }
    
    func fetch(completion: @escaping () -> () ) {
        guard let apiUrl = URL(string: "https://api.dropboxapi.com/2/files/list_folder") else {
            print("Inavalid URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer \(dropBoxToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = ListParameter()
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch { print(error.localizedDescription)}
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            guard let data = data else {
                print("Invalid Data")
                return
            }
            do {
                let decorder = JSONDecoder()
                self.list = try decorder.decode(MemoList.self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func uploadMemo(completion: @escaping () -> () ) {
        guard let apiUrl = URL(string: "https://content.dropboxapi.com/2/files/upload") else {
            print("Inavalid URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer \(dropBoxToken)", forHTTPHeaderField: "Authorization")
        request.setValue("{\"path\": \"/recording.m4a\",\"mode\": \"overwrite\",\"autorename\": true,\"mute\": false,\"strict_conflict\": false}", forHTTPHeaderField: "Dropbox-API-Arg")
        request.setValue("application/octet-stream", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let fileURL = mp3Path.appendingPathComponent("recording.m4a")
        
        do {
            let fileData = try Data(contentsOf: fileURL)
            let task = session.uploadTask(with: request, from: fileData) { (data, response, error) in
                defer {
                    DispatchQueue.main.async {
                        completion()
                    }
                }
                if let error = error {
                    print(error)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse else {
                    print("Invalid Response")
                    return
                }
                guard (200...299).contains(httpResponse.statusCode) else {
                    print(httpResponse.statusCode)
                    return
                }
                guard let data = data, let strData = String(data: data, encoding: .utf8) else {
                    print("Invalid Data")
                    return
                }
                print("녹음파일이저장되었습니다")
            }
            task.resume()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    func delete(filename: String, completion: @escaping () -> () ) {
        guard let apiUrl = URL(string: "https://api.dropboxapi.com/2/files/delete_v2") else {
            print("Inavalid URL")
            return
        }
        
        var request = URLRequest(url: apiUrl)
        request.httpMethod = "POST"
        request.setValue("Bearer \(dropBoxToken)", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let body = DeleteParameter(path: filename)
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(body)
            request.httpBody = data
        } catch { print(error.localizedDescription)}
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            defer {
                DispatchQueue.main.async {
                    completion()
                }
            }
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid Response")
                return
            }
            guard (200...299).contains(httpResponse.statusCode) else {
                print(httpResponse.statusCode)
                return
            }
            guard let data = data else {
                print("Invalid Data")
                return
            }
        }
        task.resume()
    }
}




extension VocieMemoViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list?.entries.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recordedCell", for: indexPath)
        
        cell.textLabel?.text = list?.entries[indexPath.row].name
        if let strDate = list?.entries[indexPath.row].client_modified {
            let date = formatter.date(from: strDate)
            let f = DateFormatter()
            f.dateFormat = "EEEE MMM d"
            cell.detailTextLabel?.text = f.string(for: date)
        }
        
        
        return cell
    }
}

extension VocieMemoViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let name = self.list?.entries[indexPath.row].name else {return}
        let url = mp3Path.appendingPathComponent(name)
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            self.player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            if let name = self.list?.entries[indexPath.row].name {
                delete(filename: "/" + name) {
                    self.voiceMemoListTableView.reloadData()
                    self.list?.entries.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
        }
    }
}

extension VocieMemoViewController: AVAudioRecorderDelegate {
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        fetch {
            self.voiceMemoListTableView.reloadData()
        }
    }
}
