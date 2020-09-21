#!/usr/bin/env python
# -*- coding: utf8 -*-

"""
This script is meant as a simple way to reply to ical invitations from mutt.
See README for instructions and LICENSE for licensing information.
"""

from __future__ import with_statement

__author__="Martin Sander, Yaroslav Luzin"
__license__="MIT"

import psutil
import vobject
import tempfile, time
import os, sys
import warnings
from pathlib import Path
from tzlocal import get_localzone
from datetime import datetime
from subprocess import Popen, PIPE, call
from getopt import gnu_getopt as getopt

usage="""
usage:
%s [OPTIONS] -e your@email.address filename.ics
OPTIONS:
    -i interactive
    -a accept
    -d decline
    -t tentatively accept
    -c calendar name in khal
    (accept is default, last one wins)
""" % sys.argv[0]

def del_if_present(dic, key):
    if key in dic:
        del dic[key]

def set_accept_state(attendee, state):
    attendee.params['PARTSTAT'] = [str(state)]
    for i in ["RSVP","ROLE","X-NUM-GUESTS","CUTYPE"]:
        del_if_present(attendee.params, i)
    return attendee

def get_accept_decline():
    while True:
        sys.stdout.write("\nAccept Invitation? [Y-yes/N-no/T-tentative/Q-cancel] ")
        ans = sys.stdin.readline()
        if ans.lower() == 'y\n' or ans == '\n':
            return 'ACCEPTED'
        elif ans.lower() == 'n\n':
            return 'DECLINED'
        elif ans.lower() =='t\n':
            return 'TENTATIVE'
        elif ans.lower() == 'q\n':
            return None

def get_answer(invitation):
    # create
    ans = vobject.newFromBehavior('vcalendar')
    ans.add('method')
    ans.method.value = "REPLY"
    ans.add('vevent')

    # just copy from invitation
    #for i in ["uid", "summary", "dtstart", "dtend", "organizer"]:
    # There's a problem serializing TZ info in Python, temp fix
    for i in ["uid", "summary", "organizer"]:
        if i in invitation.vevent.contents:
            ans.vevent.add(invitation.vevent.contents[i][0])

    # new timestamp
    ans.vevent.add('dtstamp')
    ans.vevent.dtstamp.value = datetime.utcnow().replace(
            tzinfo = invitation.vevent.dtstamp.value.tzinfo)
    return ans

def write_to_tempfile(ical, file_name="event-reply.ics"):
    tempdir = tempfile.mkdtemp()
    icsfile = tempdir + "/" + file_name
    with open(icsfile,"w") as f:
        f.write(ical.serialize())
    return icsfile, tempdir

def get_mutt_cfg(pid_path):
    mutt_pid = 0
    pid = os.getpid()
    while pid:
        p = psutil.Process(pid)
        if p.name() == "neomutt" or p.name() == "mutt":
            mutt_pid = pid
            break
        pid = p.ppid()
    if mutt_pid:
        cfg_fname = os.path.join(
            pid_path,
            "muttcfg_{}".format(mutt_pid))
    else:
        cfg_fname = os.path.join(pid_path, "muttcfg")
    if not os.path.isfile(cfg_fname):
        cfg_fname = os.path.join(pid_path, "muttcfg")

    cfg = None
    try:
        with open(cfg_fname, "r") as f:
            cfg = f.read()
            print(cfg)
    except Exception as e:
        print(e)
    return cfg

def get_mutt_command(ical, email_address, accept_decline, icsfile, pid_path):
    #cfg = get_mutt_cfg(pid_path)
    accept_decline = accept_decline.capitalize()
    if 'organizer' in ical.vevent.contents:
        if hasattr(ical.vevent.organizer,'EMAIL_param'):
            sender = ical.vevent.organizer.EMAIL_param
        else:
            sender = ical.vevent.organizer.value.split(':')[1] #workaround for MS
    else:
        sender = "NO SENDER"
    summary = ical.vevent.contents['summary'][0].value
    command = ["neomutt"]
    #if cfg:
    #    command += ["-F", cfg]
    command += ["-a", icsfile,
            "-s", "%s: %s" % (accept_decline, summary), "--", sender]
    return command

def get_khal_command(icsfile, default_calendar):
    command = ["khal", "import", "--batch"]
    if default_calendar:
        command.append("-a")
        command.append(default_calendar)
    command.append(icsfile)

    return command

def execute(command, mailtext):
    process = Popen(command, stdin=PIPE)
    process.stdin.write(mailtext.encode())
    process.stdin.close()

    result = None
    while result is None:
        result = process.poll()
        time.sleep(.1)
    if result != 0:
        sys.stderr.writeline("unable to send reply, subprocess exited with\
                exit code %d\nPress return to continue" % result)
        sys.stdin.readline()

def openics(invitation_file):
    with open(invitation_file) as f:
        try:
            with warnings.catch_warnings(): #vobject uses deprecated Exception stuff
                warnings.simplefilter("ignore")
                invitation = vobject.readOne(f, ignoreUnreadable=True)
        except AttributeError:
            invitation = vobject.readOne(f, ignoreUnreadable=True)
    return invitation

def display(ical):
    summary = ical.vevent.contents['summary'][0].value
    if 'organizer' in ical.vevent.contents:
        if hasattr(ical.vevent.organizer,'EMAIL_param'):
            sender = ical.vevent.organizer.EMAIL_param
        else:
            sender = ical.vevent.organizer.value.split(':')[1] #workaround for MS
    else:
        sender = "NO SENDER"
    if 'description' in ical.vevent.contents:
        description = ical.vevent.contents['description'][0].value
    else:
        description = "NO DESCRIPTION"
    if 'attendee' in ical.vevent.contents:
        attendees = ical.vevent.contents['attendee']
    else:
        attendees = []
    sys.stdout.write("From:\t" + sender + "\n")
    sys.stdout.write("Title:\t" + summary + "\n")
    sys.stdout.write("To:\t")
    for attendee in attendees:
        if hasattr(attendee, 'EMAIL_param'):
            sys.stdout.write(attendee.CN_param + " <" + attendee.EMAIL_param + ">, ")
        else:
            try:
                sys.stdout.write(attendee.CN_param + " <" + attendee.value.split(':')[1] + ">, ") #workaround for MS
            except:
                sys.stdout.write(attendee.value.split(':')[1] + " <" + attendee.value.split(':')[1] + ">, ") #workaround for 'mailto:' in email
    sys.stdout.write("\nWhen: \n\t{}\n\t{}".format(
        ical.vevent.dtstart.value.astimezone(get_localzone()),
        ical.vevent.dtend and ical.vevent.dtend.value.astimezone(get_localzone())))
    sys.stdout.write("\n\n")
    sys.stdout.write(description + "\n")

if __name__=="__main__":
    pid_path = os.path.join(str(Path.home()), '.config/mutt/pid_accounts')
    email_address = None
    email_addresses = []
    default_calendar = None
    accept_decline = 'ACCEPTED'
    opts, args = getopt(sys.argv[1:],"e:c:p:aidt")

    if len(args) < 1:
        sys.stderr.write(usage)
        sys.exit(1)

    invitation = openics(args[0])
    display(invitation)

    for opt,arg in opts:
        if opt == '-e':
            email_addresses = arg.split(',')
        if opt == '-c':
            default_calendar = arg
        if opt == '-i':
            accept_decline = get_accept_decline()
        if opt == '-a':
            accept_decline = 'ACCEPTED'
        if opt == '-d':
            accept_decline = 'DECLINED'
        if opt == '-t':
            accept_decline = 'TENTATIVE'
        if opt == '-p':
            pid_path = arg

    if not accept_decline:
        sys.stdout.write('Cancelled')
        sys.exit(0)

    ans = get_answer(invitation)

    if 'attendee' in invitation.vevent.contents:
        attendees = invitation.vevent.contents['attendee']
    else:
        attendees = []

    ans.vevent.add('attendee')
    ans.vevent.attendee_list.pop()
    flag = 1
    from_address = None
    for attendee in attendees:
        if hasattr(attendee,'EMAIL_param'):
            addr = attendee.EMAIL_param.lower()
        else:
            addr = attendee.value.split(':')[1].lower()
        if addr in email_addresses:
            set_accept_state(attendee, accept_decline)
            ans.vevent.attendee_list.append(attendee)
            email_address = addr
            flag = 0
    if flag:
        sys.stderr.write("Seems like you have not been invited to this event!\n")
        sys.exit(1)

    # write the original invitation with changed attendees
    # to import to khal
    impfile, temp1dir = write_to_tempfile(invitation, "event.ics")

    # write a reply to send using mutt
    icsfile, temp2dir = write_to_tempfile(ans)

    if accept_decline != 'DECLINED':
        # Add to khal
        khal_command = get_khal_command(impfile, default_calendar)
        call(khal_command)

    # send reply via mutt
    mutt_command = get_mutt_command(ans, email_address, accept_decline,
                                    icsfile, pid_path)
    mailtext = "'%s has %s'" % (email_address, accept_decline.lower())
    mailtext = "\n"

    execute(mutt_command, mailtext)

    # delete tempporary files
    os.remove(icsfile)
    os.remove(impfile)
    os.rmdir(temp1dir)
    os.rmdir(temp2dir)
