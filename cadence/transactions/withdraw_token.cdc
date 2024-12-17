import "ExampleToken"

// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that owns a Vault
transaction {

    // Temporary Vault object that holds the balance being transferred
    var temporaryVault: @ExampleToken.Vault

    prepare(acct: auth(Storage, Capabilities) &Account) {
        // Step 1: Check if a Vault exists, else create one
        if acct.storage.borrow<&ExampleToken.Vault>(from: /storage/MainVault) == nil {
            let newVault <- ExampleToken.createEmptyVault()
            acct.storage.save<@ExampleToken.Vault>(<-newVault, to: /storage/MainVault)
            log("New Vault created and saved to storage")
        }

        // Step 2: Mint 50 tokens into the Vault using VaultMinter
        let minterRef = acct.storage.borrow<&ExampleToken.VaultMinter>(
            from: /storage/CadenceFungibleTokenTutorialMinter
        ) ?? panic("Could not borrow a reference to the VaultMinter")

        let recipientCap = acct.capabilities.storage.issue<auth(ExampleToken.Receiver) &ExampleToken.Vault>(
            /storage/MainVault
        )
        minterRef.mintTokens(amount: 50.0, recipient: recipientCap)
        log("Minted 50 tokens into the Vault")

        // Step 3: Borrow the Vault with Withdraw entitlement
        let vaultRef = acct.storage.borrow<auth(ExampleToken.Withdraw) &ExampleToken.Vault>(
            from: /storage/MainVault
        ) ?? panic("Could not borrow a reference to the sender's Vault")

        // Step 4: Withdraw 10 tokens into the temporary Vault
        self.temporaryVault <- vaultRef.withdraw(amount: 10.0)
        log("Withdrawn 10 tokens into temporary Vault")
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