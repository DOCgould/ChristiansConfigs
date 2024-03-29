#!/usr/bin/env python3
from datetime import datetime
from psutil import disk_usage, sensors_battery
from psutil._common import bytes2human
from socket import gethostname, gethostbyname
from subprocess import check_output
from sys import stdout
from time import sleep


def write(data):
    stdout.write("%s\n" % data)
    stdout.flush()


def refresh():
    disk = bytes2human(disk_usage("/").free)
    ip = gethostbyname(gethostname())
    try:
        ssid = check_output("iwgetid -r", shell=True).strip().decode("utf-8")
        ssid = "(%s)" % ssid
    except Exception:
        ssid = "None"
    bluetooth = check_output(
        "systemctl status bluetooth | grep Status",
        shell=True).strip().decode("utf-8")
    battery = int(sensors_battery().percent)
    status = "Charging" if sensors_battery().power_plugged else "Discharging"
    date = datetime.now().strftime("%h %d %A %I:%M")
    format = "Space: %s | Internet: %s %s | Bluetooth %s | Battery: %s%% %s | Date: %s"
    write(format % (disk, ip, ssid, bluetooth, battery, status, date))


if __name__ == "__main__":
    refresh()
