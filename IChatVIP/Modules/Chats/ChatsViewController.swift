//
//  ChatsViewController.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import MessageKit
import InputBarAccessoryView

protocol ChatsDisplayLogic: class {
    func displayData(viewModel: Chats.Model.ViewModel.ViewModelData)
}

class ChatsViewController: MessagesViewController, ChatsDisplayLogic {
    
    var interactor: ChatsBusinessLogic?
    var router: (NSObjectProtocol & ChatsRoutingLogic & ChatsDataPassing)?
    
    private var userId: String?
    private var userName: String?
    private var messages: [MMessage] = []
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController        = self
        let interactor            = ChatsInteractor()
        let presenter             = ChatsPresenter()
        let router                = ChatsRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
        router.dataStore          = interactor
    }
    
    // MARK: - View lifecycle
    
    override func loadView() {
        super.loadView()
        
        interactor?.makeRequest(request: .getUserInfo)
        interactor?.makeRequest(request: .setTitle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMessageInputBar()
        adjustMessagesDistanceRightSide()
        
        messagesCollectionView.backgroundColor = .mainWhite()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.delegate = self
        
        interactor?.makeRequest(request: .setMessagesObserve(messages: messages))
    }
    
    private func adjustMessagesDistanceRightSide() {
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout {
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
            layout.photoMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.photoMessageSizeCalculator.incomingAvatarSize = .zero
        }
    }
    
    // MARK: - ChatsDisplayLogic
    
    func displayData(viewModel: Chats.Model.ViewModel.ViewModelData) {
        switch viewModel {
        case .displayUserInfo(let userId, let userName):
            self.userId = userId
            self.userName = userName
            
        case .displayTitle(let title):
            self.title = title
            
        case .displayScrollToBottom:
            messagesCollectionView.scrollToBottom(animated: true)
            
        case .displayAlert(let title, let message):
            router?.showAlert(title: title, message: message)
            
        case .displayMessages(let messages, let isLatestMessage):
            self.messages = messages
            messagesCollectionView.reloadData()
            
            if messagesCollectionView.isAtBottom && isLatestMessage {
                messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
}

// MARK: - MessagesDataSource

extension ChatsViewController: MessagesDataSource {
    
    func currentSender() -> SenderType {
        MSender(senderId: userId!, displayName: userName!)
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        messages[indexPath.item]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        1
    }
    
    func numberOfItems(inSection section: Int, in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        // время после каждого 4-го сообщения
        if indexPath.item % 4 == 0 {
            return NSAttributedString(
                string: MessageKitDateFormatter.shared.string(from: message.sentDate),
                attributes: [.font: UIFont.boldSystemFont(ofSize: 10), .foregroundColor: UIColor.darkGray]
            )
        } else {
            return nil
        }
    }
    
}

// MARK: - Configure Message Input Bar

extension ChatsViewController {
    
    func configureMessageInputBar() {
        messageInputBar.isTranslucent = true
        messageInputBar.separatorLine.isHidden = true
        messageInputBar.backgroundView.backgroundColor = .mainWhite()
        messageInputBar.inputTextView.backgroundColor = .white
        messageInputBar.inputTextView.placeholderTextColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        messageInputBar.inputTextView.textContainerInset = UIEdgeInsets(top: 14, left: 30, bottom: 14, right: 36)
        messageInputBar.inputTextView.placeholderLabelInsets = UIEdgeInsets(top: 14, left: 36, bottom: 14, right: 36)
        messageInputBar.inputTextView.layer.borderColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 0.4033635232)
        messageInputBar.inputTextView.layer.borderWidth = 0.2
        messageInputBar.inputTextView.layer.cornerRadius = 18.0
        messageInputBar.inputTextView.layer.masksToBounds = true
        messageInputBar.inputTextView.scrollIndicatorInsets = UIEdgeInsets(top: 14, left: 0, bottom: 14, right: 0)
        
        messageInputBar.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        messageInputBar.layer.shadowRadius = 5
        messageInputBar.layer.shadowOpacity = 0.3
        messageInputBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        
        configureSendButton()
        configureCameraIcon()
    }
    
    func configureSendButton() {
        messageInputBar.sendButton.setImage(UIImage(named: "Sent"), for: .normal)
        messageInputBar.sendButton.applyGradients(cornerRadius: 10)
        messageInputBar.setRightStackViewWidthConstant(to: 56, animated: false)
        messageInputBar.sendButton.contentEdgeInsets = UIEdgeInsets(top: 2, left: 2, bottom: 6, right: 30)
        messageInputBar.sendButton.setSize(CGSize(width: 48, height: 48), animated: false)
        messageInputBar.middleContentViewPadding.right = -38
    }
    
    func configureCameraIcon() {
        let cameraItem = InputBarButtonItem(type: .system)
        cameraItem.tintColor = #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1)
        let cameraImage = UIImage(named: "camera")!
        cameraItem.image = cameraImage
        
        cameraItem.addTarget(self, action: #selector(cameraButtonPressed), for: .primaryActionTriggered)
        cameraItem.setSize(CGSize(width: 60, height: 30), animated: false)
        
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        
        messageInputBar.setStackViewItems([cameraItem], forStack: .left, animated: false)
    }
    
    @objc private func cameraButtonPressed() {
        router?.showImagePicker()
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension ChatsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[.originalImage] as? UIImage else { return }
        interactor?.makeRequest(request: .sendImage(image))
    }
}


// MARK: - MessagesLayoutDelegate

extension ChatsViewController: MessagesLayoutDelegate {
    
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        CGSize(width: 0, height: 8)
    }
    
    // расстояние сверху/сниху от времени сообщения
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        if indexPath.item % 4 == 0 {
            return 30
        } else {
            return 0
        }
    }
}

// MARK: - MessagesDisplayDelegate

extension ChatsViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? .white : #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1)
    }
    
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        isFromCurrentSender(message: message) ? #colorLiteral(red: 0.2392156863, green: 0.2392156863, blue: 0.2392156863, alpha: 1) : .white
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.isHidden = true
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        .bubble
    }
}

// MARK: - InputBarAccessoryViewDelegate

extension ChatsViewController: InputBarAccessoryViewDelegate {
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        interactor?.makeRequest(request: .sendMessage(text: text))
        inputBar.inputTextView.text = ""
    }
}
