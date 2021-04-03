//
//  FirestoreService.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//

import FirebaseFirestore
import Firebase

final class FirestoreService {
    
    static let shared = FirestoreService()
    
    let db = Firestore.firestore()
    
    var currentUser: MUser!
    
    private var usersRef: CollectionReference {
        db.collection("users")
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String?, completion: @escaping (Result<MUser, Error>) -> Void) {
        
        guard Validators.isFilled(username: username, description: description, sex: sex) else {
            completion(.failure(UserError.notFilled))
            return
        }
        
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {
            completion(.failure(UserError.photoNotExisted))
            return
        }
        
        var muser = MUser(
            username: username!,
            email: email,
            description: description!,
            sex: sex!,
            avatarStringURL: "not exist",
            id: id
        )
        
        // авторизация только после загрузки фото
        StorageService.shared.upload(photo: avatarImage!) { (result) in
            switch result {
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                
                self.usersRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = usersRef.document(user.uid)
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else {
                    completion(.failure(UserError.cannotUnwrapToMUser))
                    return
                }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.cannotGetUserInfo))
            }
        }
        
    }
    
}
