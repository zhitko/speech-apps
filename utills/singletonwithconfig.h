#ifndef SINGLETONWITHCONFIG
#define SINGLETONWITHCONFIG

#include <QObject>

template <class T, class C>
class SingletonWithConfig
{
public:
    // TODO: add get instance without config,
    static T& Instance(C * conf)
    {
        static T _instance(conf);
        return _instance;
    }

private:
    SingletonWithConfig();
    ~SingletonWithConfig();
    SingletonWithConfig(const SingletonWithConfig &);
    SingletonWithConfig& operator=(const SingletonWithConfig &);
};

#endif // SINGLETONWITHCONFIG

