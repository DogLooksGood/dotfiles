config.load_autoconfig(False)




c.tabs.position = 'bottom'
c.qt.highdpi = True
c.content.proxy = 'http://127.0.0.1:8889'

c.bindings.default['normal'] = {}

config.bind('i', 'mode-enter insert')
config.bind('r', 'reload')
config.bind('R', 'restart')
config.bind('t', 'scroll down')
config.bind('c', 'scroll up')
config.bind('h', 'scroll left')
config.bind('n', 'scroll right')
config.bind(',', 'back')
config.bind('.', 'forward')
config.bind('j', 'tab-next')
config.bind('k', 'tab-prev')
config.bind('o', 'set-cmd-text -s :open')
config.bind('l', 'hint links fill :open -t {hint-url}')
config.bind('bb', 'bookmark-list')
config.bind('ba', 'bookmark-add')
config.bind('bd', 'bookmark-del')
config.bind('H', 'history-list')
config.bind('<F3>', 'macro-record')
config.bind('<F4>', 'macro-run')
config.bind('<F11>', 'fullscreen')
config.bind('/', 'set-cmd-text /')
config.bind('s', 'search-next')
config.bind('r', 'search-prev')
config.bind('gs', 'view-source')
config.bind('gi', 'devtools')
config.bind('gd', 'download')
config.bind('v', 'mode-enter caret')
config.bind('<Space>', 'hint')
