add_executable(asio_timer async_timer.cpp)

target_link_libraries(asio_timer
    PUBLIC
    Boost::boost
    Boost::thread
    Boost::chrono
)

install(TARGETS asio_timer)