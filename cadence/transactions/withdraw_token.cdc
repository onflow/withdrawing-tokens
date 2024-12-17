import "ExampleToken"

// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that owns a Vault
transaction {

    // Temporary Vault object that holds the balance being transferred
    var temporaryVault: @ExampleToken.Vault

    prepare(acct: auth(Storage, Capabilities) &Account) {
        // Borrow a reference to the sender's Vault with the Withdraw entitlement
        let vaultRef = acct.storage.borrow<auth(ExampleToken.Withdraw) &ExampleToken.Vault>(
            from: /storage/MainVault
        ) ?? panic("Could not borrow a reference to the sender's Vault with Withdraw entitlement")

        // Withdraw 10 tokens into the temporary Vault
        self.temporaryVault <- vaultRef.withdraw(amount: 10.0)
    }

    execute {
        // Get the recipient's public account object
        let recipient = getAccount(0x01)

        // Borrow the recipient's Receiver capability for their Vault
        let receiverRef = recipient.capabilities.get<&ExampleToken.Vault>(
            /public/MainReceiver
        ).borrow() ?? panic("Could not borrow a Receiver reference from the recipient's Vault")

        // Deposit the tokens into the recipient's Vault
        receiverRef.deposit(from: <-self.temporaryVault)

        log("Transfer succeeded!")
    }
}