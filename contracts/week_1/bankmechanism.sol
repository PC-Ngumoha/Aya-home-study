// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;


/*
A simple banking mechanism that is meant to allow users to perform
the following functions

- create an account
    - Can only do this if you have not already done so for this particular address
- Deposit DBT tokens into the account
    - Cannot deposit a negative number
    - Must have an account to deposit to
- Withdraw DBT tokens from the account
    - Cannot work if user has insufficient balance
    - Cannot withdraw a negative number
    - Must have an account to withdraw from
- Send DBT tokens to a friend
    - Cannot work if user has insufficient balance
    - Friend's wallet address must belong to a valid, registered wallet
    - Must have an account from which to carry out the transaction
    - Cannot transfer negative number
- view balance in user's account
    - Must have an account from which to get the balance

*/
contract DecentralBank {
    struct Account {
        string firstName;
        string lastName;
        uint balance;
        uint8 flag;
    }

    mapping (address => Account) accounts;

    modifier mustNotHaveAccount() {
        require(accounts[msg.sender].flag == 0,
        "You seem to already have an account" );
        _;
    }

    modifier mustHaveAccount() {
        require(accounts[msg.sender].flag == 1,
        "You do not have an account, create one");
        _;
    }

    modifier isBalanceSufficient(uint amount) {
        require(accounts[msg.sender].balance > amount,
        "Insufficient funds to complete this transaction");
        _;
    }

    modifier isRealAccountAddress(address addr) {
        require(accounts[addr].flag == 1,
        "The supplied address does not belong to an existing address");
        _;
    }

    modifier checkAmountValue(uint amount) {
        require(amount > 0, "Amount must be positive, cannot be zero or negative");
        _;
    }

    // Create wallet/account
    function createAccount(
        string memory _fName, 
        string memory _lName
        )
        public
        mustNotHaveAccount 
    {
        accounts[msg.sender] = Account(_fName, _lName, 0, 1);
    }

    // Get wallet/account balance
    function getBalance()
        public
        view
        mustHaveAccount
        returns(uint)
    {
        uint balance = accounts[msg.sender].balance;
        return balance;
    }

    // P2P token transfers
    function transferTokens(
        uint amount, 
        address dest
        ) 
        public
        mustHaveAccount
        checkAmountValue(amount)
        isBalanceSufficient(amount)
        isRealAccountAddress(dest) 
    {
        accounts[msg.sender].balance -= amount;
        accounts[dest].balance += amount;
    }

    // Deposit some token
    function depositToken (uint amount)
        public
        mustHaveAccount
        checkAmountValue(amount)
    {
        accounts[msg.sender].balance += amount;
    }

    // Withdraw some token
    function withdrawToken(uint amount)
        public
        mustHaveAccount
        checkAmountValue(amount) 
        isBalanceSufficient(amount)
    {
        accounts[msg.sender].balance -= amount;
    }
}