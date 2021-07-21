# NEAR JSON RPC benchmark

## Install [`drill`](https://github.com/fcsonline/drill) with dependencies and run the benchmark

* Install [`cargo`](https://doc.rust-lang.org/cargo/getting-started/installation.html)

    ```bash
    $ curl https://sh.rustup.rs -sSf | sh
    $ source $HOME/.cargo/env
    ```

* Install dependencies

    ```bash
    $ sudo apt install -y build-essential pkg-config libssl-dev
    ```

* Clone this repo

    ```bash
    $ git clone https://github.com/near/jsonrpc-benchmark
    ```

* Navigate to the folder and run `drill`

    ```bash
    $ cd jsonrpc-benchmark/
    $ drill --benchmark benchmark.yml --stats
    ```

## Reasoning for chosen methods to benchmark

For the benchmarking we decided to go with `testnet`. We have spin up the node on GCP `e2-standard-8` (which is recommended machine type for the rpc nodes).

Before writing a drill config we've investigated (manually) the logs of nginx on a few nodes to find out what kind of methods are the most frequent. Despite the "easy" methods (like `block`, `chunk`) there were some `query` view calls:

* `view_state`
* `view_account`
* `view_access_key_list`

It was decided to go with those three. We choose an existing account with contract and small (not empty) state.

During the benchmark we're sending each of the three query requests

## Benchmark results we've got

### Request sent from another machine in the same region

```
Query {{ item.txn }}      Total requests            9000
Query {{ item.txn }}      Successful requests       9000
Query {{ item.txn }}      Failed requests           0
Query {{ item.txn }}      Median time per request   9ms
Query {{ item.txn }}      Average time per request  10ms
Query {{ item.txn }}      Sample standard deviation 9ms

Time taken for tests      23.4 seconds
Total requests            9000
Successful requests       9000
Failed requests           0
Requests per second       385.40 [#/sec]
Median time per request   9ms
Average time per request  10ms
Sample standard deviation 9ms
```

Summary: **385.40 rps**

### Request sent from the same machine (locally)

```
Query {{ item.txn }}      Total requests            9000
Query {{ item.txn }}      Successful requests       9000
Query {{ item.txn }}      Failed requests           0
Query {{ item.txn }}      Median time per request   1ms
Query {{ item.txn }}      Average time per request  1ms
Query {{ item.txn }}      Sample standard deviation 1ms

Time taken for tests      4.0 seconds
Total requests            9000
Successful requests       9000
Failed requests           0
Requests per second       2270.15 [#/sec]
Median time per request   1ms
Average time per request  1ms
Sample standard deviation 1ms
```

Summary: **2270.15 rps**
