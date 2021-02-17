config.load_autoconfig(False)

c.tabs.position = 'bottom'
c.qt.highdpi = True
c.content.proxy = 'http://127.0.0.1:8889'

config.bind('<Space>', 'hint')

config.bind('h', 'scroll left')
config.bind('t', 'scroll down')
config.bind('c', 'scroll up')
config.bind('n', 'scroll right')
config.bind('s', 'search-next')
config.bind('l', 'search-prev')

config.bind('j', 'scroll-page 0 1')
config.bind('k', 'scroll-page 0 -1')

config.bind('R', 'restart')
config.bind(',', 'back')
config.bind('.', 'forward')
