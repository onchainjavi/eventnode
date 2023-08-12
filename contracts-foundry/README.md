This project is build with foundry. To run it you need to follow these steps:

1. Install foundry and follow steps
    curl -L https://foundry.paradigm.xyz | bash

2. Run foundry
    foundryup

3. Download and install rust compiler and cargo
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    >option1

4. Build  (this will take some minutes)
    cargo install --git https://github.com/foundry-rs/foundry --profile local --force foundry-cli anvil chisel

5. Start a project
    $ forge init hello_foundry

6. BUild the project
    forge build

7. run tests
    forge test+

