config.load_autoconfig(False)

config.bind('<Space>', 'hint')

config.bind('h', 'scroll left')
config.bind('t', 'scroll down')
config.bind('c', 'scroll up')
config.bind('n', 'scroll right')
config.bind('s', 'search-next')
config.bind('r', 'search-prev')

config.bind('R', 'restart')
config.bind('k', 'back')
config.bind('j', 'forward')
config.bind(',', 'tab-prev')
config.bind('.', 'tab-next')
config.bind('<Esc>', 'fake-key <Esc>')

c.tabs.position = 'bottom'
c.qt.highdpi = True
c.content.proxy = 'http://127.0.0.1:8889'
c.colors.webpage.darkmode.enabled = False
c.colors.webpage.bg = "#000"
c.colors.tabs.even.fg = "#aaaaaa"
c.colors.tabs.even.bg = "#2c363d"
c.colors.tabs.odd.fg = "#aaaaaa"
c.colors.tabs.odd.bg = "#2c3d2e"
c.colors.tabs.selected.even.fg = "#bbbbbb"
c.colors.tabs.selected.even.bg = "#603e59"
c.colors.tabs.selected.odd.fg = "#bbbbbb"
c.colors.tabs.selected.odd.bg = "#603e59"
c.colors.statusbar.normal.fg = "#aaaaaa"
c.colors.statusbar.url.fg = "#bbbbbb"
