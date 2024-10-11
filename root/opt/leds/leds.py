#!/usr/bin/env python

import sys
from openrgb import OpenRGBClient
from openrgb.utils import RGBColor

class LedsClient:

    MODE_BLINKING = "blinking"
    MODE_BREATHING = "breathing"
    MODE_COLOR_CYCLE = "colorcycle"
    MODE_DIRECT = "direct"
    MODE_FLASHING = "flashing"
    MODE_STATIC = "static"

    def __init__(self, device=0):
        self.client = OpenRGBClient()
        self.modes = {
            self.MODE_BLINKING: self.mode_blinking,
            self.MODE_BREATHING: self.mode_breathing,
            self.MODE_COLOR_CYCLE: self.mode_color_cycle,
            self.MODE_DIRECT: self.mode_direct,
            self.MODE_FLASHING: self.mode_flashing,
            self.MODE_STATIC: self.mode_static,
        }

    def usage(self):
        print()
        print("Usage:")
        print(f"\tleds {self.MODE_BLINKING} <r> <g> <b>")
        print(f"\tleds {self.MODE_BREATHING} <r> <g> <b>")
        print(f"\tleds {self.MODE_COLOR_CYCLE}")
        print(f"\tleds {self.MODE_DIRECT}")
        print(f"\tleds {self.MODE_FLASHING} <r> <g> <b>")
        print(f"\tleds {self.MODE_STATIC} <r> <g> <b>")
        print()

    def run(self, argv):

        if len(argv) < 2:
            return self.usage()

        mode = argv[1].lower()
        mode_function = self.modes.get(mode)
        if mode_function is None:
            print(f"Unsupported mode: {mode}")
            return

        mode_function(argv[2:])

    def parse_color(self, args):

        if len(args) != 3:
            raise Exception(f"Invalid color: {args}")

        r = int(args[0])
        g = int(args[1])
        b = int(args[2])

        return RGBColor(r, g, b)

    def parse_mode(self, mode_name):
        for device in self.client.devices:
            for mode in device.modes:
                if mode.name.lower().replace(" ", "") == mode_name.lower():
                    return mode

    def set_color(self, args):
        color = self.parse_color(args)
        for device in self.client.devices:
            device.set_color(color)

    def set_mode(self, mode):
        mode = self.parse_mode(mode)
        for device in self.client.devices:
            device.set_mode(mode)

    def mode_with_color(self, args, mode):
        self.set_mode(mode)
        self.set_color(args)

    def mode_blinking(self, args):
        return self.mode_with_color(args, self.MODE_BLINKING)

    def mode_breathing(self, args):
        return self.mode_with_color(args, self.MODE_BREATHING)

    def mode_color_cycle(self, args):
        self.set_mode(self.MODE_COLOR_CYCLE)

    def mode_direct(self, args):
        raise NotImplementedError

    def mode_flashing(self, args):
        return self.mode_with_color(args, self.MODE_FLASHING)

    def mode_static(self, args):
        return self.mode_with_color(args, self.MODE_STATIC)

def main():
    LedsClient().run(sys.argv)

if __name__ == "__main__":
    main()
