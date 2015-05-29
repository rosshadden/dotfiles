#/usr/bin/env python3

import sys, dbus


"""
@depends python-dbus
"""


bus = dbus.SessionBus()
obj = bus.get_object("im.pidgin.purple.PurpleService", "/im/pidgin/purple/PurpleObject")
purple = dbus.Interface(obj, "im.pidgin.purple.PurpleInterface")

# get list of accounts
accounts = purple.PurpleAccountsGetAll()

users = {}

for accountId in accounts:
    connectionId = purple.PurpleAccountGetConnection(accountId)
    protocol = purple.PurpleConnectionGetDisplayName(connectionId)

    if not connectionId: continue

    # get list of users for an account
    userIds = purple.PurpleFindBuddies(accountId, "")

    for userId in userIds:
        user = {
            "id": userId,
            "name": purple.PurpleBuddyGetName(userId),
            "alias": purple.PurpleBuddyGetAlias(userId),
            "accountId": accountId,
            "protocol": protocol
        }

        # NOTE: this overwrites users if they are in multiple protocols
        users[user["alias"] + " [" + user["protocol"] + "]"] = user


def getUser(userHash):
    return users[userHash]


# Send a message to `user`, which is some entry in `users`
def sendIm(user, message = ""):
    if isinstance(user, str): user = getUser(user)
    if message is None: message = ""

    # First we make a new conversation
    # (I think the `1` in the first arg is "IM", and a 2 would be "chat"...?
    conversationId = purple.PurpleConversationNew(1, user["accountId"], user["name"])

    # Next we make a new IM out of the conversation (yep...)
    imId = purple.PurpleConvIm(conversationId)

    # Finally we send the IM
    purple.PurpleConvImSend(imId, message)


if len(sys.argv) > 1:
    username = sys.argv[1]
    message = sys.argv[2] if len(sys.argv) > 2 else None

    sendIm(username, message)
else:
    for userHash in users:
        print(userHash)
