//
//  INetworkService.swift
//  SpaceX
//
//  Created by Богдан Баринов on 02.08.2022.
//

//MARK: - INetworkService

protocol INetworkService {
    func fetchResult(complition: @escaping (Result<[Rockets], Error>) -> Void)
}
