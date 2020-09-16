import weechat
# modifies the string about to be sent to the IRC server
# thus, not interfering with non-IRC buffer text like wee-slack

weechat.register(
    "gt.py", "icyphox", "1.0", "MIT", "greentexting like the hacker called 4chan", "", ""
)

def greentext_cb(data, modifier, modifier_data, string):
    parts = string.split(':')
    if parts[1].startswith(">"):
        parts[1] = ":" + parts[1].replace(">", "\x033" + ">")
        return "".join(parts)
    return string

weechat.hook_modifier("irc_out1_privmsg", "greentext_cb", "")
