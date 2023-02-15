import UIKit
import WebKit
import Web3Inbox

final class Web3InboxViewController: UIViewController {

    private let importAccount: ImportAccount

    init(importAccount: ImportAccount) {
        self.importAccount = importAccount
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        Web3Inbox.configure(account: importAccount.account, onSign: onSing)
        view = Web3Inbox.instance.getWebView()

        navigationItem.title = "Web3Inbox SDK"
    }
}

private extension Web3InboxViewController {

    func onSing(_ message: String) -> CacaoSignature {
        let privateKey = Data(hex: importAccount.privateKey)
        let signer = MessageSignerFactory(signerFactory: DefaultSignerFactory()).create()
        return try! signer.sign(message: message, privateKey: privateKey, type: .eip191)
    }
}
