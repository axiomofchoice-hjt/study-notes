# boost

- [2. ubuntu cmake](#2-ubuntu-cmake)
- [3. asio](#3-asio)
- [4. log](#4-log)

## 2. ubuntu cmake

```sh
vcpkg install boost
```

cmake 要加线程库

```cmake
find_package(Threads REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
find_package(Boost REQUIRED)
target_link_libraries(${PROJECT_NAME} PRIVATE Boost::boost)
```

## 3. asio

timer

```cpp
namespace asio = boost::asio;
asio::io_context io;
asio::steady_timer t(io, asio::chrono::seconds(2));
t.wait(); // 等待 2 秒
t.async_wait([](const boost::system::error_code&) {
    std::cout << "233" << std::endl;
}); // 异步等待两秒，结束后执行回调函数
io.run();
```

一个无尽的 timer

```cpp
namespace asio = boost::asio;

class Timer {
    using Func = std::function<void()>;
public:
    std::unique_ptr<asio::steady_timer> t;
    Func call;
    std::chrono::duration<long long, std::milli> duration;
    void repeat() {
        if (call) {
            call();
        }
        t->expires_at(std::max(t->expiry() + duration, std::chrono::steady_clock::now() + std::chrono::milliseconds(1)));
        t->async_wait([this](const boost::system::error_code &) {
            repeat();
        });
    }
    template<typename ExecutionContext>
    void setContext(ExecutionContext &context) {
        t = std::make_unique<asio::steady_timer>(context);
    }
    void setDuration(size_t ms) {
        duration = std::chrono::milliseconds(ms);
    }
    void run() {
        t->expires_after(duration);
        t->async_wait([this](const boost::system::error_code &) {
            repeat();
        });
    }
    void stop() {
        t->cancel();
    }
};
```

如果只用一个 io_service，即单线程 io，任何时候都是只有一个操作在执行；如果需要多线程 io 需要用 strand 来保证

发送接收 缓冲序列

- `asio::buffer(...)` 一旦构造就长度固定
  - 可以用 `asio::mutable_buffer` 接收
  - `asio::buffer("xxx")`
  - `asio::buffer($string)`
  - buffer **不能**延长对象的生命周期，所以不知道有啥用
  - `asio::buffer_cast<const char *>($buf)`
  - `asio::buffer_size($buf)`
- `asio::streambuf sbuf;`
  - 一个 input 序列一个 output 序列
  - `.commit(n)` input -> output ？
  - `.consume(n)` output -> void ？

socket

```cpp
class tcp_connection
    : public std::enable_shared_from_this<tcp_connection> {
public:
    typedef std::shared_ptr<tcp_connection> pointer;
    std::string s;

    static pointer create(boost::asio::io_context &io_context) {
        return std::make_shared<tcp_connection>(io_context);
    }

    tcp::socket &socket() {
        return socket_;
    }

    void async_read() {
        s.assign(10, 0);
        auto ptr = shared_from_this();
        socket_.async_read_some(boost::asio::buffer(s, 10), [ptr](const boost::system::error_code &error, size_t n) {
            if (!error) {
                printf("%s;\n", ptr->s.data());
                ptr->async_read();
            }
        });
    }

    void async_write(std::string s) {
        std::shared_ptr<std::string> s1 = std::make_shared<std::string>(s);
        socket_.async_write_some(asio::buffer(*s1.get()), [s1](...) {});
    }

    void start() {
        async_read();
    }

    tcp_connection(boost::asio::io_context &io_context)
        : socket_(io_context) {
    }

private:
    tcp::socket socket_;
};
```

## 4. log

```cpp
int main() {
    boost::log::core::get()->set_filter(
        boost::log::trivial::severity >= boost::log::trivial::info
    );
    BOOST_LOG_TRIVIAL(trace) << "A trace severity message";
    BOOST_LOG_TRIVIAL(debug) << "A debug severity message";
    BOOST_LOG_TRIVIAL(info) << "An informational severity message";
    BOOST_LOG_TRIVIAL(warning) << "A warning severity message";
    BOOST_LOG_TRIVIAL(error) << "An error severity message";
    BOOST_LOG_TRIVIAL(fatal) << "A fatal severity message";
    return 0;
}
```
