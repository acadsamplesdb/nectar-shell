#!/usr/bin/env python

# Sits around waiting until the local resolver picks up all names in sys.argv.

import os
import socket
import sys
import time

def ok(names, max_wait = 5 * 60):
    start = time.time()

    while time.time() <= (start + max_wait):
        try:
            return [socket.gethostbyname(name) for name in names]
        except:
            print "at least one name does not exist yet; waiting..."
            time.sleep(20)

    return None

if len(sys.argv) > 1:
    if not ok(sys.argv[1:]):
        sys.exit(1)
