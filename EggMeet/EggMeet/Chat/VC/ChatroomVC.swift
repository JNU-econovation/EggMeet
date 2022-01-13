//
//  ChatroomVC.swift
//  EggMeet
//
//  Created by 이윤성 on 2022/01/11.
//

import Foundation
import UIKit
import Starscream

class ChatroomVC: UIViewController, URLSessionWebSocketDelegate {
    var nickname: String?
    private var webSocket: URLSessionWebSocketTask?
    @IBOutlet weak var chatOpponentNameLabel : UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())
        var mainAddress :String = Bundle.main.infoDictionary!["WS_URL"] as? String ?? ""
        let wsURL: String = "ws://118.221.12.92:8082/ws/chat"
        let url = URL(string: wsURL)
        NSLog("server URL : \(wsURL)")
        webSocket = session.webSocketTask(with: url!)
        webSocket = session.webSocketTask(with: url!)
        webSocket?.resume()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
    }
    
    @IBAction func stopWebSocket(_ sender: Any) {
        close()
    }
    
    @IBAction func passMessage(_ sender: Any) {
        send()
    }
    
    func updateUI() {
        if let nickname = nickname {
            self.navigationItem.title = "\(nickname)"
            chatOpponentNameLabel.text = "\(nickname)"
        }
    }
    
    func ping() {
        webSocket?.sendPing(pongReceiveHandler: { error in
            if let error = error {
                NSLog("Ping error: \(error)")
            }
        })
    }
    func close() {
        webSocket?.cancel(with: .goingAway, reason: "Demo ended".data(using: .utf8))
    }
    
    func send() {
        DispatchQueue.global().asyncAfter(deadline: .now()+1) {
            self.webSocket?.send(.string("hello"), completionHandler: {error in
                if let error = error {
                    NSLog("send error: \(error)")
                }
            })
        }
    }
    func receive() {
        webSocket?.receive(completionHandler: { [weak self] result in
            switch result {
            case .success(let message):
                switch message {
                case .data(let data):
                    print("get Data : \(data)")
                case .string(let message):
                    print("Got String : \(message)")
                @unknown default:
                    break
                }
            case .failure(let error):
                print("Receive Error: \(error)")
            }
            
            self?.receive()
        })
        
        
        
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didOpenWithProtocol protocol: String?){
        NSLog("Did connect to socket")
        ping()
        receive()
        send()
        
        
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
        print("did close connection with reason")
    }
}


