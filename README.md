# Storage contracts with Foundry

This repo documents simple storage implementations in solidity, using foundry: forge, cast & anvil

## General development process

1. create a new contract in `src/`
2. create a new deploy script in `script/`
3. run anvil

    ```sh
    anvil
    ```

4. grab a private key from anvil & add it to your `.env`

    ```sh
    # .env
    PRIVATE_KEY=
    ```

5. run `source .env` to update that `PRIVATE_KEY` in your shell
6. deploy contracts on anvil's network

    ```sh
    # run deploy script as documented in `Storage.s.sol` or `Widget.s.sol`
    forge script script/Storage.s.sol:MyScript --fork-url http://localhost:8545 --broadcast
    # or
    forge script script/Widget.s.sol:MyScript --fork-url http://localhost:8545 --broadcast
    ```

7. grab contract addresses from the `broadcast/` directory & store in your shell

    ```sh
    STORAGE_ADDR=
    WIDGET_ADDR=
    ```

8. run functions with cast on the anvil network

    ```sh
    # as documented in `Storage.sol` and `Widget.sol`
    cast call --rpc-url=http://localhost:8545 $WIDGET_ADDR "getWidgetCount()(uint)"
    ```

9. when submitting transactions you can use a private key from anvil per steps 4 & 5 above

    ```sh
    b32String=$(cast --format-bytes32-string "second")
    cast send --rpc-url=http://localhost:8545 --private-key=$PRIVATE_KEY $WIDGET_ADDR "newWidget(bytes32,string,bool,uint)" $b32String "some name" false 100
    ```

## Don't Forget Gas Reports

Add `gas_reports` to `foundry.toml` under `[profile.default]`

run `forge test --gas-report`
