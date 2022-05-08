//
//  MissedCallsScreenViewModel.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 05.05.2022.
//

import Foundation
import UIKit

typealias MissedCallsScreenViewModelDatasource = MissedCallsScreenViewModelProtocol & UITableViewDataSource

protocol MissedCallsScreenViewModelProtocol: AnyObject {
    func retrieveMissedCallsData() async throws
}

final class MissedCallsScreenViewModel: NSObject {
    private let serviceLayer: MissedCallsDataProviderFacade = ServiceLayer.shared
    
    func retrieveMissedCallsData() async {
   
    }
    
}

extension MissedCallsScreenViewModel: MissedCallsScreenViewModelDatasource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
}
