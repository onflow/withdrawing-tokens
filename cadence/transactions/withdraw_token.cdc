import "ExampleToken"

// This transaction is a template for a transaction that
// could be used by anyone to send tokens to another account
// that owns a Vault
transaction {

    var temporaryVault: @ExampleToken.Vault
    var receiver: Capability<&{ExampleToken.Receiver}>
    var receiverRef: &{ExampleToken.Receiver}  
    let mintingRef: &ExampleToken.VaultMinter

    prepare(acct: auth(Storage, Capabilities) &Account) {
        // Check if a Vault exists, else create one
        if acct.storage.borrow<&ExampleToken.Vault>(from: /storage/MainVault) == nil {
            let newVault <- ExampleToken.createEmptyVault()
            acct.storage.save<@ExampleToken.Vault>(<-newVault, to: /storage/MainVault)
            log("New Vault created and saved to storage")
        }

        // Mint 50 tokens into the Vault using VaultMinter
        let minter = acct.storage.borrow<&ExampleToken.VaultMinter>(
            from: /storage/CadenceFungibleTokenTutorialMinter
        ) ?? panic("Could not borrow a reference to the minter")
        self.mintingRef = minter
        
        // Issue a Receiver capability for the caller's Vault
        let receiverCap = acct.capabilities.storage.issue<&{ExampleToken.Receiver}>(
            /storage/MainVault
        )
        self.receiver = receiverCap

        self.mintingRef.mintTokens(amount: 30.0, recipient: self.receiver)
        log("Minted 50 tokens into the Vault")

        // Borrow the Vault with Withdraw entitlement
        let vaultRef = acct.storage.borrow<auth(ExampleToken.Withdraw) &ExampleToken.Vault>(
            from: /storage/MainVault
        ) ?? panic("Could not borrow a reference to the sender's Vault")

        // Withdraw 10 tokens into the temporary Vault
        self.temporaryVault <- vaultRef.withdraw(amount: 10.0)

        log("Withdrawn 10 tokens into temporary Vault")

        self.receiverRef = acct.storage.borrow<&{ExampleToken.Receiver}>(
            from: /storage/MainVault
        ) ?? panic("Could not borrow a Receiver reference to the account's Vault")

    }

    execute {
        self.receiverRef.deposit(from: <-self.temporaryVault)
        log("Tokens successfully deposited!")
    }
}