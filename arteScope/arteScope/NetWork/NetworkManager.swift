//
//  GenericViewModel.swift
//  arteScope
//
//  Created by tiago on 04/01/2026.
//

import Network
import UIKit

final class Reachability {

    static let shared = Reachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    var isConnected: Bool = false
    
    public func start(
        onChange: ((Bool) -> Void)?
    ) {
        monitor.pathUpdateHandler = { path in
            self.isConnected = (path.status == .satisfied)
            
            DispatchQueue.main.async {
                onChange?(self.isConnected)
            }
        }
        
        monitor.start(queue: queue)
    }
    
    public func stop() {
        monitor.cancel()
    }
}


