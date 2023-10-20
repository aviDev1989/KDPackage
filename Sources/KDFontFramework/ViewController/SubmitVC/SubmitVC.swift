//
//  SubmitVC.swift
//  
//
//  Created by Apptunix on 19/10/23.
//

import UIKit
import Starscream

public class SubmitVC: UIViewController {
    public static let storyboardVC = UIStoryboard(name: "SubmitVC", bundle: Bundle.module).instantiateInitialViewController()
    @IBOutlet weak var lblMessage: UILabel!
    @IBOutlet weak var txtfldInput: UITextField!

    
    var socket: WebSocket?
    var delegate : WebSocketDelegate?

    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSubmitClicked(_ sender: Any) {
        lblMessage.text = ""
        lblMessage.text = txtfldInput.text ?? ""
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SubmitVC{

    func socketConnect(){
        var userID : Int = 0
        userID = 2323
        let socketUrl = "ws://182.72.246.251:1111/"
        let request = URLRequest(url: URL(string: socketUrl+"ws/chat/\(userID)\("/")")!)
        print(request)
        socket = WebSocket(request: request)
        socket?.delegate = self
        socket?.connect()

    }
    func setupPay(amt: Int, type: Int) -> Void {
        let amount = amt
        let room_id = 1232
        let sender = 2344343
        let transaction_type = type
        var param = [String:AnyObject]()
        param.updateValue(amount as AnyObject, forKey: "amount")
        param.updateValue(room_id as AnyObject, forKey: "room_id")
        param.updateValue(sender as AnyObject, forKey: "sender")
        param.updateValue(transaction_type as AnyObject, forKey: "transaction_type")
        let jsonData = try? JSONSerialization.data(withJSONObject: param, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        socket?.write(string: jsonString!)
    }
    
    func setupStatus(idss: Int, transaction_status: Int) -> Void {
        var param = [String:AnyObject]()
        param.updateValue(idss as AnyObject, forKey: "id")
        param.updateValue(transaction_status as AnyObject, forKey: "transaction_status")
        let jsonData = try? JSONSerialization.data(withJSONObject: param, options: [])
        let jsonString = String(data: jsonData!, encoding: .utf8)
        socket?.write(string: jsonString!)
    }

    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected(let headers):
          print("connected \(headers)")
          socket?.connect()
        case .disconnected(let reason, let closeCode):
          print("disconnected \(reason) \(closeCode)")
          socket?.disconnect()
        case .text(let text):
//            listenSocketForPay(txt: text)
          print("received text: \(text)")
        case .binary(let data):
          print("Received data: \(data)")
        case .pong(let pongData):
          print("received pong: \(String(describing: pongData))")
        case .ping(let pingData):
          print("received ping: \(String(describing: pingData))")
        case .error(let error):
          print("error \(String(describing: error))")
        case .viabilityChanged:
          print("viabilityChanged")
        case .reconnectSuggested:
          print("reconnectSuggested")
        case .cancelled:
          print("cancelled")
        case .peerClosed:
            print("peerClosed")
        }
      }
}
// MARK: - WebSocketDelegate

extension SubmitVC : WebSocketDelegate {
    public func didReceive(event: Starscream.WebSocketEvent, client: Starscream.WebSocketClient) {
        
    }
    
  public func websocketDidConnect(_ socket: Starscream.WebSocket) {
  }
  public func websocketDidDisconnect(_ socket: Starscream.WebSocket, error: NSError?) {
  }
  public func websocketDidReceiveMessage(_ socket: Starscream.WebSocket, text: String) {
  }
  public func websocketDidReceiveData(_ socket: Starscream.WebSocket, data: Data) {
  }
}
