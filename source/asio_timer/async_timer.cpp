#include <iostream>

#include <boost/asio.hpp>
#include <boost/chrono.hpp>
#include <boost/thread/thread.hpp>

#include <boost/date_time.hpp>

#define NOW_TIME boost::posix_time::second_clock::local_time()

int main()
{
    boost::asio::io_context io_ctx(4);
    std::cout << "Start -- " << boost::this_thread::get_id()
              << " " << NOW_TIME << std::endl;
    
    boost::asio::steady_timer timer1(io_ctx, boost::asio::chrono::seconds(5));

    timer1.async_wait([](const boost::system::error_code& error) {
        std::cout << "Timer1 -- " << boost::this_thread::get_id()
                  << " " << NOW_TIME << std::endl;
    });

    boost::this_thread::sleep_for(boost::chrono::seconds(2));

    boost::asio::steady_timer timer2(io_ctx, boost::asio::chrono::seconds(1));
    timer2.async_wait([](const boost::system::error_code& error) {
        std::cout << "Timer2 -- " << boost::this_thread::get_id()
                  << " " << NOW_TIME << std::endl;
        boost::this_thread::sleep_for(boost::chrono::seconds(4));
    });

    std::cout << "Run -- " << NOW_TIME << std::endl;
    io_ctx.run();
    std::cout << "Exit -- " << NOW_TIME << std::endl;

    return 0;
}