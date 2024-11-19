access(all)
resource interface Provider {

    // withdraw
    //
    // Function that subtracts tokens from the owner's Vault
    // and returns a Vault resource (@Vault) with the removed tokens.
    //
    // The function's access level is public, but this isn't a problem
    // because even public functions are not fully accessible unless the owner
    // grants access by publishing a resource that exposes the withdraw function.
    //
    access(all)
    fun withdraw(amount: UFix64): @Vault {
        post {
            // 'result' refers to the return value of the function
            result.balance == UFix64(amount):
                "Withdrawal amount must match the balance of the withdrawn Vault"
        }
    }
}
