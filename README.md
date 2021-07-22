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
    $ chmod a+x run.sh
    $ URL="http://localhost:3030" ./run.sh
    ```

## Reasoning for chosen methods to benchmark

For the benchmarking we decided to go with `testnet`. We have spin up the node on GCP `e2-standard-8` (which is recommended machine type for the rpc nodes).

Before writing a drill config we've investigated (manually) the logs of nginx on a few nodes to find out what kind of methods are the most frequent. Despite the "easy" methods (like `block`, `chunk`) there were some `query` view calls:

* `view_state`
* `view_account`
* `view_access_key_list`

It was decided to go with those three. Also we've added `view_call` to call view method of some contract. We choose an existing account with contract and small (not empty) state.

During the benchmark we're sending each of the four query requests and **the main metric currently is requests per second (rps)**

## Benchmark results we've got

### Request sent from another machine in the same region

```
View call method          Total requests            3000
View call method          Successful requests       3000
View call method          Failed requests           0
View call method          Median time per request   16ms
View call method          Average time per request  20ms
View call method          Sample standard deviation 8ms

Time taken for tests      15.7 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       191.18 [#/sec]
Median time per request   16ms
Average time per request  20ms
Sample standard deviation 8ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://34.91.236.50:3030


View access key list      Total requests            3000
View access key list      Successful requests       3000
View access key list      Failed requests           0
View access key list      Median time per request   9ms
View access key list      Average time per request  9ms
View access key list      Sample standard deviation 6ms

Time taken for tests      7.6 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       393.99 [#/sec]
Median time per request   9ms
Average time per request  9ms
Sample standard deviation 6ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://34.91.236.50:3030


View account              Total requests            3000
View account              Successful requests       3000
View account              Failed requests           0
View account              Median time per request   8ms
View account              Average time per request  9ms
View account              Sample standard deviation 2ms

Time taken for tests      7.5 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       398.99 [#/sec]
Median time per request   8ms
Average time per request  9ms
Sample standard deviation 2ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://34.91.236.50:3030


View state                Total requests            3000
View state                Successful requests       3000
View state                Failed requests           0
View state                Median time per request   9ms
View state                Average time per request  9ms
View state                Sample standard deviation 6ms

Time taken for tests      7.9 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       380.32 [#/sec]
Median time per request   9ms
Average time per request  9ms
Sample standard deviation 6ms
```

### Request sent from the same machine (locally)

```
View call method          Total requests            3000
View call method          Successful requests       3000
View call method          Failed requests           0
View call method          Median time per request   8ms
View call method          Average time per request  8ms
View call method          Sample standard deviation 2ms

Time taken for tests      7.1 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       419.84 [#/sec]
Median time per request   8ms
Average time per request  8ms
Sample standard deviation 2ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://127.0.0.1:3030


View access key list      Total requests            3000
View access key list      Successful requests       3000
View access key list      Failed requests           0
View access key list      Median time per request   1ms
View access key list      Average time per request  1ms
View access key list      Sample standard deviation 1ms

Time taken for tests      1.6 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       1894.98 [#/sec]
Median time per request   1ms
Average time per request  1ms
Sample standard deviation 1ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://127.0.0.1:3030


View account              Total requests            3000
View account              Successful requests       3000
View account              Failed requests           0
View account              Median time per request   1ms
View account              Average time per request  1ms
View account              Sample standard deviation 1ms

Time taken for tests      1.4 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       2079.54 [#/sec]
Median time per request   1ms
Average time per request  1ms
Sample standard deviation 1ms
Concurrency 4
Iterations 3000
Rampup 5
Base URL http://127.0.0.1:3030


View state                Total requests            3000
View state                Successful requests       3000
View state                Failed requests           0
View state                Median time per request   1ms
View state                Average time per request  1ms
View state                Sample standard deviation 1ms

Time taken for tests      1.8 seconds
Total requests            3000
Successful requests       3000
Failed requests           0
Requests per second       1680.33 [#/sec]
Median time per request   1ms
Average time per request  1ms
Sample standard deviation 1ms
```
