import "ExampleToken"

// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that owns a Vault
transaction {

    // Temporary Vault object that holds the balance that is being transferred
    var temporaryVault: @ExampleToken.Vault

    prepare(acct: auth(Storage, Capabilities) &Account) {
        // Withdraw tokens from your vault by borrowing a reference to it
        // and calling the withdraw function with that reference
        let vaultRef = acct.capabilities.storage.borrow<&ExampleToken.Vault>(
            from: /storage/MainVault
        ) ?? panic("Could not borrow a reference to the owner's vault")
        
        self.temporaryVault <- vaultRef.withdraw(amount: 10.0)
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(0x01)

        // Get the recipient's Receiver reference to their Vault
        // by borrowing the reference from the public capability
        let receiverRef = recipient.capabilities.borrow<&ExampleToken.Vault{ExampleToken.Receiver}>(
            /public/MainReceiver
        ) ?? panic("Could not borrow a reference to the receiver")

        // Deposit your tokens to their Vault
        receiverRef.deposit(from: <-self.temporaryVault)

        log("Transfer succeeded!")
    }
}
