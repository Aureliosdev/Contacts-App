//
//  IAPManager.swift
//  Contacts App
//
//  Created by Aurelio Le Clarke on 07.03.2023.
//

import Foundation
import RevenueCat
import StoreKit

class IAPManager {
    
    static let shared = IAPManager()
    
    private init() {
        
    }

    
    public func getSubscriptionStatus(completion: ((Bool) -> Void)?) {
        RevenueCat.Purchases.shared.getCustomerInfo { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil
            else {
                return }
            if entitlements.all["Premium"]?.isActive == true {
                UserDefaults.standard.set(true, forKey: "premium")
                completion?(true)
            }else {
                UserDefaults.standard.set(false, forKey: "premium")
                completion?(false)
            }
        }
    }
    
    
    func isPremium() -> Bool {
        return UserDefaults.standard.bool(forKey: "premium")
        
    }
    public func subscribe(package: Package, completion: @escaping( Bool)-> Void) {
           guard !isPremium() else {
               completion(true)
               print("User  already subscribed")
               return
               
           }
        
        RevenueCat.Purchases.shared.purchase(package: package) { transaction, info, error, userCancelled in
               guard let transaction  = transaction,
                     let entitlements = info?.entitlements,
                   error == nil,
                       !userCancelled  else { return }
            switch transaction.sk1Transaction!.transactionState {

               case .purchasing:
                   print("purchasing")
               case .purchased:
                   print("purchased \(entitlements)")
                if entitlements.all["Premium"]?.isActive == true {
                       UserDefaults.standard.set(true, forKey: "premium")
                       completion(true)
                       print("purchased")
                   }else {
                       UserDefaults.standard.set(false , forKey: "premium")
                       completion(false)
                       print("purchase falied")
                   }
               case .failed:
                   print("failed")
               case .restored:
                   print("restore")
               case .deferred:
                   print("defered")
            @unknown default:
                   print("default case")
               }
           }

       }

    public func fetchPackages(completion: @escaping (RevenueCat.Package?) -> Void) {
        Purchases.shared.getOfferings { offerings, error in
            guard let package = offerings?.offering(identifier: "default")?.availablePackages.first,
                  error == nil else {
                completion(nil)
                return
            }
            completion(package)
            print(package)
        }
    }
    
    
    public func restorePurchases(completion: @escaping (Bool)-> Void) {
        RevenueCat.Purchases.shared.restorePurchases { info, error in
                   guard let entitlements = info?.entitlements,
                         error == nil else { return }
                   if entitlements.all["Premium"]?.isActive == true {
                       print("purchased")
                       UserDefaults.standard.set(true, forKey: "premium")
                       completion(true)
                      
                   }else {
                       print("purchase failed")
                       UserDefaults.standard.set(false , forKey: "premium")
                       completion(false)
                      
                   }
               }
               
           }
    
}
