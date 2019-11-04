from __future__ import unicode_literals

import weechat as weechat
import subprocess
from os import environ, path

crimnotify_name = "crimnotify"
crimnotify_version = "0.1"
crimnotify_license = "GPL3"

# convenient table checking for bools
true = { "on": True, "off": False }

# declare this here, will be global config() object
# but is initialized in __main__
cfg = None

class config(object):
    def __init__(self):
        # default options for lnotify
        self.opts = {
            "highlight": "on",
            "query": "on",
            "notify_away": "off",
            "icon": "weechat",
        }

        self.init_config()
        self.check_config()

    def init_config(self):
        for opt, value in self.opts.items():
            temp = weechat.config_get_plugin(opt)
            if not len(temp):
                weechat.config_set_plugin(opt, value)

    def check_config(self):
        for opt in self.opts:
            self.opts[opt] = weechat.config_get_plugin(opt)

    def __getitem__(self, key):
        return self.opts[key]

def printc(msg):
    weechat.prnt("", msg)

def handle_msg(data, pbuffer, date, tags, displayed, highlight, prefix, message):
    highlight = bool(highlight) and cfg["highlight"]
    query = true[cfg["query"]]
    notify_away = true[cfg["notify_away"]]
    buffer_type = weechat.buffer_get_string(pbuffer, "localvar_type")
    away = weechat.buffer_get_string(pbuffer, "localvar_away")
    x_focus = False
    window_name = ""
    my_nickname = "nick_" + weechat.buffer_get_string(pbuffer, "localvar_nick")

    # Check if active window is in the ignore_windows_list and skip notification
    if (environ.get('DISPLAY') != None) and path.isfile("/bin/xdotool"):
        cmd_pid="xdotool getactivewindow getwindowpid".split()
        window_pid = subprocess.check_output(cmd_pid).decode("utf-8")
        cmd_name=("ps -ho comm -p %s"%(window_pid)).split()
        window_name = subprocess.check_output(cmd_name).decode("utf-8")
        ignore_windows_list = [""]
        if window_name in ignore_windows_list:
            x_focus = True
            return weechat.WEECHAT_RC_OK

    if pbuffer == weechat.current_buffer() and x_focus:
        return weechat.WEECHAT_RC_OK

    if away and not notify_away:
        return weechat.WEECHAT_RC_OK

    if my_nickname in tags:
        return weechat.WEECHAT_RC_OK

    buffer_name = weechat.buffer_get_string(pbuffer, "short_name")


    if buffer_type == "private" and query:
        notify_user(buffer_name, message)
    elif buffer_name == "#crimson":
        notify_user("{}".format(prefix), message)
    elif buffer_type == "channel" and highlight:
        notify_user("{} @ {}".format(prefix, buffer_name), message)

    return weechat.WEECHAT_RC_OK

def process_cb(data, command, return_code, out, err):
    if return_code == weechat.WEECHAT_HOOK_PROCESS_ERROR:
        weechat.prnt("", "Error with command '%s'" % command)
    elif return_code != 0:
        weechat.prnt("", "return_code = %d" % return_code)
        weechat.prnt("", "notify-send has an error")
    return weechat.WEECHAT_RC_OK

def notify_user(origin, message):
    hook = weechat.hook_process_hashtable("notify-send",
        { "arg1": "-i", "arg2": cfg["icon"],
          "arg3": "-a", "arg4": "WeeChat",
          "arg5": origin, "arg6": message },
        20000, "process_cb", "")

    return weechat.WEECHAT_RC_OK

# execute initializations in order
if __name__ == "__main__":
    weechat.register(crimnotify_name, "kevr", crimnotify_version, crimnotify_license,
        "{} - A libnotify script for weechat".format(crimnotify_name), "", "")

    cfg = config()
    print_hook = weechat.hook_print("", "", "", 1, "handle_msg", "")

