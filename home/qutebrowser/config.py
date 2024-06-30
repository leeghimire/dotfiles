from typing import TYPE_CHECKING, Any

from qutebrowser.api import interceptor

if TYPE_CHECKING:
    c: Any = object
    config: Any = object

config.load_autoconfig()

c.colors.webpage.preferred_color_scheme = "dark"

c.content.blocking.method = "both"
c.content.cookies.accept = 'no-3rdparty'
c.content.dns_prefetch = False
c.content.geolocation = False
c.content.media.audio_capture = False
c.content.media.video_capture = False
c.content.notifications.enabled = False

c.downloads.location.directory = "/tmp/"
c.downloads.position = 'bottom'
c.downloads.remove_finished = 5000

c.url.default_page = "https://en.wikipedia.org/wiki/Main_Page"
c.url.searchengines = {'DEFAULT': 'https://www.google.com/search?q={}'}
c.url.start_pages = c.url.default_page

def filter_youtube(info: interceptor.Request):
    url = info.request_url
    if (
        url.host() == "www.youtube.com"
        and url.path() == "/get_video_info"
        and "&adformat=" in url.query()
    ):
        info.block

interceptor.register(filter_youtube)


###########
## THEME ##
###########

BLACK       = "#000000"
WHITE       = "#FFFFFF"
THEME_COLOR = "#1176AA"

bg_default          = BLACK
bg_lighter          = BLACK
bg_selection        = THEME_COLOR
fg_disabled         = "#1b1b1b"
fg_default          = WHITE
bg_lightest         = THEME_COLOR
fg_error            = "#ff0000"
bg_hint             = THEME_COLOR
fg_matched_text     = "#00ff00"
bg_passthrough_mode = THEME_COLOR
bg_insert_mode      = THEME_COLOR
bg_warning          = "#ff00ff"

c.colors.completion.category.bg = bg_default
c.colors.completion.category.border.bottom = bg_default
c.colors.completion.category.border.top = bg_default
c.colors.completion.category.fg = bg_hint
c.colors.completion.even.bg = bg_default
c.colors.completion.fg = fg_default
c.colors.completion.item.selected.bg = bg_selection
c.colors.completion.item.selected.border.bottom = bg_selection
c.colors.completion.item.selected.border.top = bg_selection
c.colors.completion.item.selected.fg = fg_default
c.colors.completion.item.selected.match.fg = fg_matched_text
c.colors.completion.match.fg = fg_matched_text
c.colors.completion.odd.bg = bg_lighter
c.colors.completion.scrollbar.bg = bg_default
c.colors.completion.scrollbar.fg = fg_default
c.colors.contextmenu.disabled.bg = bg_lighter
c.colors.contextmenu.disabled.fg = fg_disabled
c.colors.contextmenu.menu.bg = bg_default
c.colors.contextmenu.menu.fg =  fg_default
c.colors.contextmenu.selected.bg = bg_selection
c.colors.contextmenu.selected.fg = fg_default
c.colors.downloads.bar.bg = bg_default
c.colors.downloads.error.fg = fg_error
c.colors.downloads.start.bg = bg_insert_mode
c.colors.downloads.start.fg = bg_default
c.colors.downloads.stop.bg = bg_passthrough_mode
c.colors.downloads.stop.fg = bg_default
c.colors.hints.bg = bg_hint
c.colors.hints.fg = bg_default
c.colors.hints.match.fg = fg_default
c.colors.keyhint.bg = bg_default
c.colors.keyhint.fg = fg_default
c.colors.keyhint.suffix.fg = fg_default
c.colors.messages.error.bg = fg_error
c.colors.messages.error.border = fg_error
c.colors.messages.error.fg = bg_default
c.colors.messages.info.bg = bg_default
c.colors.messages.info.border = bg_default
c.colors.messages.info.fg = fg_default
c.colors.messages.warning.bg = bg_warning
c.colors.messages.warning.border = bg_warning
c.colors.messages.warning.fg = bg_default
c.colors.prompts.bg = bg_default
c.colors.prompts.border = bg_default
c.colors.prompts.fg = fg_default
c.colors.prompts.selected.bg = bg_selection
c.colors.prompts.selected.fg = fg_default
c.colors.statusbar.caret.bg = bg_warning
c.colors.statusbar.caret.fg = bg_default
c.colors.statusbar.caret.selection.bg = bg_insert_mode
c.colors.statusbar.caret.selection.fg = bg_default
c.colors.statusbar.command.bg = bg_default
c.colors.statusbar.command.fg = fg_default
c.colors.statusbar.command.private.bg = bg_default
c.colors.statusbar.command.private.fg = fg_default
c.colors.statusbar.insert.bg = bg_insert_mode
c.colors.statusbar.insert.fg = bg_default
c.colors.statusbar.normal.bg = bg_default
c.colors.statusbar.normal.fg = fg_matched_text
c.colors.statusbar.passthrough.bg = bg_passthrough_mode
c.colors.statusbar.passthrough.fg = bg_default
c.colors.statusbar.private.bg = bg_lighter
c.colors.statusbar.private.fg = bg_default
c.colors.statusbar.progress.bg = bg_insert_mode
c.colors.statusbar.url.error.fg = fg_error
c.colors.statusbar.url.fg = fg_default
c.colors.statusbar.url.hover.fg = fg_default
c.colors.statusbar.url.success.http.fg = bg_passthrough_mode
c.colors.statusbar.url.success.https.fg = fg_matched_text
c.colors.statusbar.url.warn.fg = bg_warning
c.colors.tabs.bar.bg = bg_default
c.colors.tabs.even.bg = bg_default
c.colors.tabs.even.fg = fg_default
c.colors.tabs.indicator.error = fg_error
c.colors.tabs.indicator.start = bg_insert_mode
c.colors.tabs.indicator.stop = bg_passthrough_mode
c.colors.tabs.odd.bg = bg_lighter
c.colors.tabs.odd.fg = fg_default
c.colors.tabs.pinned.even.bg = bg_passthrough_mode
c.colors.tabs.pinned.even.fg = bg_lightest
c.colors.tabs.pinned.odd.bg = fg_matched_text
c.colors.tabs.pinned.odd.fg = bg_lightest
c.colors.tabs.pinned.selected.even.bg = bg_selection
c.colors.tabs.pinned.selected.even.fg = fg_default
c.colors.tabs.pinned.selected.odd.bg = bg_selection
c.colors.tabs.pinned.selected.odd.fg = fg_default
c.colors.tabs.selected.even.bg = bg_selection
c.colors.tabs.selected.even.fg = fg_default
c.colors.tabs.selected.odd.bg = bg_selection
c.colors.tabs.selected.odd.fg = fg_default
